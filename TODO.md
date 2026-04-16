# TODO

## HIDL

- [ ] **thermal** → binderized — blocked on hardware access:
    - Pull `thermalhal.<ro.hardware>.xml` from stock (`/system/etc/` or `/vendor/etc/`).
    - Dump `/sys/class/thermal/thermal_zone*/type` layout.
    - Then: vendor `LineageOS/android_hardware_nvidia_thermal` (branch `lineage-15.1`) into `hardware/nvidia/thermal/`, drop entry from `lineage.dependencies`, swap `@1.0-impl` for `@1.0-service`, add XML via `PRODUCT_COPY_FILES`, flip manifest.
    - Fallback if stock XML missing: synthesise from `Smoke-kernel-mocha` DT thermal-zones.
- [ ] **manifest coverage** — add entries once the corresponding HAL services are actually built & wired:
    - `camera.provider@2.4` — no camera HAL configured today; needs a `-service` + provider impl first.
    - `gatekeeper@1.0` — if we want gatekeeper alongside keymaster.
    - `dumpstate@1.0` — optional, nice-to-have for bugreports.

## Audio

- [ ] Migrate from legacy `audio_policy.conf` (pre-8.0 text format) to
  `audio_policy_configuration.xml` (XSD-validated). Set
  `USE_XML_AUDIO_POLICY_CONF := 1` in BoardConfig.mk. `media/audio.mocha.xml`
  already looks like a partial attempt at the new format.

## Init (Mi Pad 1 / mocha, inherited tn8 codename)

Detailed audit needed of `initfiles/init.*.rc` to separate mocha-specific
needs from legacy NVIDIA Shield inheritance. Preliminary findings:

- `init.cal.rc` — creates `/data/misc/{touchscreen,mpu}` as symlinks to
  `/usercalib/*`, exports `TOUCH_CONF_DIR` / `MPU_DATA_DIR`. **Needed** —
  touchscreen + gyro (MPU6515) are calibrated on mocha.
- `init.hdcp.rc` — just `setprop hdcp.srm.path` etc. HDCP SRM paths are
  used by Miracast / WiFi-Display; mocha has no HDMI but may still need
  this for WFD. **Probably keep; low cost.**
- `init.comms.rc` — starts `wpa_supplicant` and `dns_masq`. Core.
- `init.tlk.rc` — starts `tlk_daemon` + `run_ss_status.sh`. Needed for
  TrustZone / widevine L1.
- `init.ussrd.rc` — starts `ussrd` (NVIDIA secure resource daemon).
  Needed for secure boot chain.
- `init.t124.rc` — 37 writes tuning CPU/power on T124. Needed.
- `init.tn8.usb.rc` — 42 writes configuring Tegra USB (MTP/PTP/RNDIS).
  Needed.
- `init.tn8.rc`, `init.tn8_common.rc` — entry points, charger service. Needed.
- `init.tegra.rc` — sets `LD_PRELOAD libshim_zw.so` on zygote. **Needed**
  for NVIDIA graphics fd whitelist.

Next step: on-device testing to confirm nothing here is actually dead on
mocha specifically (vs tn8 generic Shield Tablet inheritance).

## Sepolicy

- [ ] Reorganise `sepolicy/{common,lineage-common,mocha}/` into the
  Treble-standard `sepolicy/{private,public,vendor}/` split. Classifying
  each `.te` file by role (system-private rule vs public type vs vendor
  rule) is the bulk of the work. Low priority — current layout functions
  correctly on 8.1.
