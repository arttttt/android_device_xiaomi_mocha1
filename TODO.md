# TODO

## HIDL: thermal

- [ ] **thermal** → binderized — blocked on hardware access:
    - Pull `thermalhal.<ro.hardware>.xml` from stock (`/system/etc/` or `/vendor/etc/`).
    - Dump `/sys/class/thermal/thermal_zone*/type` layout.
    - Vendor `LineageOS/android_hardware_nvidia_thermal` (branch `lineage-15.1`) into `hardware/nvidia/thermal/`, drop entry from `lineage.dependencies`, swap `@1.0-impl` for `@1.0-service`, add XML via `PRODUCT_COPY_FILES`, flip manifest.
    - Fallback if stock XML missing: synthesise from `Smoke-kernel-mocha` DT thermal-zones.

## Audio policy: on-device verification

Migration to XSD XML is done (`media/audio_policy_configuration.xml`,
`USE_XML_AUDIO_POLICY_CONF := 1`). Needs device-side checks once mocha
is reachable:

- All four modules (primary / a2dp / usb / r_submix) register with
  audiopolicyservice — check `dumpsys media.audio_policy` after boot.
- Routing through tinyhal paths in `media/audio.mocha.xml` still works
  for speaker, headphone, headset, internal mic.
- Bluetooth A2DP output streams.
- Volume curves from the AOSP-stock `audio_policy_volumes.xml` and
  `default_volume_tables.xml` (pulled via `PRODUCT_COPY_FILES` from
  `frameworks/av/services/audiopolicy/config/`) give acceptable levels.

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
