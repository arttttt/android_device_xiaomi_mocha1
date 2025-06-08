/*
 * Copyright (C) 2017 The Android Open Source Project
 * Copyright (C) 2019 The LineageOS Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#define LOG_TAG "android.hardware.memtrack@1.0-service-nvidia"

// #define LOG_NDEBUG 0

#include <android/log.h>
#include <utils/Log.h>
#include "Memtrack.h"

namespace android {
namespace hardware {
namespace memtrack {
namespace V1_0 {
namespace implementation {

Memtrack::Memtrack() {
}

// Methods from ::android::hardware::memtrack::V1_0::IMemtrack follow.
Return<void> Memtrack::getMemory(int32_t pid, MemtrackType type,
        getMemory_cb _hidl_cb)  {
    hidl_vec<MemtrackRecord> records;

    switch (type) {
        case MemtrackType::GL:
            getNvmapMemory(pid, records);
            break;

        default:
            break;
    };

    _hidl_cb(MemtrackStatus::SUCCESS, records);
    return Void();
}

status_t Memtrack::registerAsSystemService() {
    status_t ret = 0;

    ret = IMemtrack::registerAsService();
    if (ret != 0) {
        ALOGE("Failed to register IMemtrack (%d)", ret);
        goto fail;
    } else {
        ALOGI("Successfully registered IMemtrack");
    }

fail:
    return ret;
}

}  // namespace implementation
}  // namespace V1_0
}  // namespace memtrack
}  // namespace hardware
}  // namespace android
