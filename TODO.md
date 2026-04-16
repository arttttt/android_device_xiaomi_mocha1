# TODO

## HIDL: thermal

- [ ] **thermal** → binderized — blocked on hardware access:
    - Pull `thermalhal.<ro.hardware>.xml` from stock (`/system/etc/` or `/vendor/etc/`).
    - Dump `/sys/class/thermal/thermal_zone*/type` layout.
    - Vendor `LineageOS/android_hardware_nvidia_thermal` (branch `lineage-15.1`) into `hardware/nvidia/thermal/`, drop entry from `lineage.dependencies`, swap `@1.0-impl` for `@1.0-service`, add XML via `PRODUCT_COPY_FILES`, flip manifest.
    - Fallback if stock XML missing: synthesise from `Smoke-kernel-mocha` DT thermal-zones.

## Audio policy: migrate to XSD format

Legacy `media/audio_policy.conf` (pre-8.0 text format, 104 lines) still
drives the stack. Android 8.1 supports the XSD-validated XML format and it's
the forward-compatible path. Current blockers are **risk without device
testing**, not fundamental unknowns.

Plan:
- Enable `USE_XML_AUDIO_POLICY_CONF := 1` in `BoardConfig.mk`.
- Author `hidl/audio/audio_policy_configuration.xml` with inline module
  definitions (self-contained, no xi:include — avoids cross-partition path
  resolution surprises). Modules to cover, from the current `.conf`:
  - `primary` — five outputs (primary 48k stereo, multichannel PCM 7.1,
    passthrough AC3/E_AC3/DTS→HDMI, ulp_output MP3/AAC offload, dual_audio
    direct) + one PCM input.
  - `a2dp` — 44.1k stereo out.
  - `usb` — 44.1k stereo out + PCM in for dock accessories.
  - `r_submix` — AOSP stock submix module.
- Add `PRODUCT_COPY_FILES` for the main XML → `$(TARGET_COPY_OUT_VENDOR)/etc/`.
- Delete `media/audio_policy.conf` and its `PRODUCT_COPY_FILES` entry.
- Post-migration: verify Bluetooth audio, HDMI passthrough (if WFD in use),
  headphone/speaker routing through tinyhal paths in `media/audio.mocha.xml`.

Schema: `frameworks/av/services/audiopolicy/config/audio_policy_configuration.xsd`.

## Sepolicy: Treble split

Current layout (three flat BOARD_SEPOLICY_DIRS umbrellas):
```
sepolicy/
├── common/          # 76 .te (NVIDIA + Lineage-generic)
├── lineage-common/  # 11 .te (Lineage system-domain tweaks)
└── mocha/           # 2 .te (conn_wifi, mac_generator)
```

Target layout (Treble private/public/vendor):
```
sepolicy/
├── private/   # augmentations to AOSP system domains (system_server, zygote,
│              # surfaceflinger, mediaserver, cameraserver, platform_app, etc.)
├── public/    # type declarations visible to both system and vendor (rare)
└── vendor/    # new vendor-side domains (ussrd, bt_loader, hal_*, gpsd, etc.)
              # + file_contexts, genfs_contexts, property_contexts
```

BoardConfig.mk target state:
```
BOARD_PLAT_PRIVATE_SEPOLICY_DIR := device/xiaomi/mocha/sepolicy/private
BOARD_PLAT_PUBLIC_SEPOLICY_DIR  := device/xiaomi/mocha/sepolicy/public
BOARD_VENDOR_SEPOLICY_DIRS      += device/xiaomi/mocha/sepolicy/vendor
```

Bulk of the work is per-file classification (89 .te files + context/macros
files). Approach:
1. Scan each .te file's domain targets. Rules on AOSP-defined types
   (`type system_server`, `type zygote`, etc.) go to `private/`.
2. New domain definitions (e.g., `type ussrd`) go to `vendor/`.
3. Merge same-named files from `common/` + `lineage-common/` to avoid
   duplicate module names.
4. Migrate contexts files (`file_contexts`, `genfs_contexts`,
   `property_contexts`, `service_contexts`) into `vendor/`.
5. `te_macros`, `mac_permissions.xml`, `keys.conf` → `vendor/` (or
   `public/` if actually shared).

This is the bulk of work. Best done as a dedicated PR where each commit
can be reviewed against a reference device (e.g., marlin) for naming and
structure.

## Init.rc: dead code in init.tegra.rc

Found during init.cal.rc audit but left intact for safety. Needs
device-side verification before cleanup:

- `initfiles/init.tegra.rc:29-36` — mkdir `/mnt/factory`, `/factory`,
  `/factory/wifi_config`, `/mnt/usercalib`. mocha's fstab has no
  USRCL/FACTORY partitions, so nothing is mounted there — these mkdir's
  create empty unused directories at boot.
- `initfiles/init.tegra.rc:44-53` — chown/chmod on `/usercalib`, creating
  `/usercalib/lost+found`, `restorecon_recursive /usercalib`. Same story.
- `initfiles/init.tegra.rc:131-140` — permissions on
  `/sys/class/invensense/mpu/{akm89xx,bmpX80}/...`. These sysfs paths
  come from the **Invensense MPL userspace blob** (MotionProLink), which
  mocha doesn't ship. Only the in-kernel mpu6515 driver is present,
  exposing different paths (`/sys/class/invensense/mpu/...` top-level,
  which *are* used in lines 116-130 and should stay).

Low-risk to drop these chunks once someone can boot and confirm nothing
regresses. High-value for cleanliness: `init.tegra.rc` becomes a coherent
mocha file instead of a tn8-inheritance hodgepodge.

## Manifest coverage (out of scope for now)

- `camera.provider@2.4`, `gatekeeper@1.0`, `dumpstate@1.0` —
  adding manifest entries only makes sense once the matching HAL services
  exist on device. camera in particular has no HAL wired at all right now;
  gatekeeper would need either the tegra blob or the AOSP software
  fallback; dumpstate default impl is a stub. All require HAL-setup work
  before any manifest change.
