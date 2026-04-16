# TODO

## HIDL: passthrough → binderized

- [ ] **thermal** — blocked on hardware access:
    - Pull `thermalhal.<ro.hardware>.xml` from stock (`/system/etc/` or `/vendor/etc/`).
    - Dump `/sys/class/thermal/thermal_zone*/type` layout.
    - Then: vendor `LineageOS/android_hardware_nvidia_thermal` (branch `lineage-15.1`) into `hardware/nvidia/thermal/`, drop entry from `lineage.dependencies`, swap `@1.0-impl` for `@1.0-service`, add XML via `PRODUCT_COPY_FILES`, flip manifest.
    - Fallback if stock XML missing: synthesise from `Smoke-kernel-mocha` DT thermal-zones.
- [ ] **memtrack** — currently `@1.0-impl` only, not in `manifest.xml`. Add `@1.0-service` + manifest entry.
- [ ] **bluetooth**, **drm** — same pattern as memtrack but higher risk (service-process coupling); evaluate later.

## Cleanup

- [ ] `usb@1.0-service` listed in `hidl.mk:57-58` but has no entry in `manifest.xml`. Either add manifest entry or drop from `hidl.mk` as cruft.
- [ ] `manifest.xml` is incomplete (no entries for bluetooth, drm, memtrack, usb) — audit and align with `hidl.mk`.
