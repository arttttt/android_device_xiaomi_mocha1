LOCAL_PATH:= $(call my-dir)

PROTOBUF_SYMLINK := $(TARGET_OUT_VENDOR)/lib/libprotobuf-cpp-lite-3.9.1.so
$(PROTOBUF_SYMLINK):
	$(hide) mkdir -p $(TARGET_OUT_VENDOR)/lib
	$(hide) ln -sf /system/lib/libprotobuf-cpp-lite.so $@

ALL_DEFAULT_INSTALLED_MODULES += $(PROTOBUF_SYMLINK)

# libshim_atomic
include $(CLEAR_VARS)
LOCAL_SRC_FILES := atomic.cpp
LOCAL_MODULE := libshim_atomic
LOCAL_MODULE_CLASS := SHARED_LIBRARIES
LOCAL_CFLAGS := -O3 -Wno-unused-variable -Wno-unused-parameter
LOCAL_PROPRIETARY_MODULE := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := camera.cpp
LOCAL_MULTILIB := 32
LOCAL_MODULE := libcamera_shim
LOCAL_MODULE_TAGS := optional
LOCAL_VENDOR_MODULE := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE           := libnvmm_shim
LOCAL_SRC_FILES        := nvmm_shims.cpp
LOCAL_MULTILIB         := 32
LOCAL_SHARED_LIBRARIES := libstagefright libui
LOCAL_VENDOR_MODULE    := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE           := libphs
LOCAL_SRC_FILES        := dummy.cpp
LOCAL_SHARED_LIBRARIES := libnvphs
LOCAL_VENDOR_MODULE    := true
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := stdio_vsnprintf.cpp
LOCAL_C_INCLUDES := \
    bionic/libc \
    bionic/libc/stdio \
    bionic/libc/async_safe/include
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_MODULE := libs
LOCAL_MODULE_TAGS := optional
LOCAL_LDFLAGS_arm += -Wl,--version-script,$(LOCAL_PATH)/stdio_vsnprintf.arm.map
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_SRC_FILES := zygote_whitelist.cpp
LOCAL_C_INCLUDES := frameworks/base/core/jni \
                    system/core/base/include
ifneq ($(ZYGOTE_WHITELIST_PATH_EXTRA),)
    LOCAL_CFLAGS += -DPATH_WHITELIST_EXTRA=$(ZYGOTE_WHITELIST_PATH_EXTRA)
endif
LOCAL_SHARED_LIBRARIES := liblog
LOCAL_MODULE := libshim_zw
LOCAL_MODULE_TAGS := optional
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE           := libw
LOCAL_SRC_FILES_32     := intrinsics_shim.s
LOCAL_SRC_FILES_64     := intrinsics_shim.cpp
LOCAL_SHARED_LIBRARIES := libcutils
LOCAL_VENDOR_MODULE    := true
LOCAL_LDFLAGS_arm      += -Wl,--version-script,$(LOCAL_PATH)/intrinsics_shim.arm.map
include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)

LOCAL_SRC_FILES := \
    camera_shim.cpp

LOCAL_SHARED_LIBRARIES := \
    libgui \
    libui

LOCAL_C_INCLUDES := \
    frameworks/native/include

LOCAL_MODULE := libshim_camera
LOCAL_MODULE_TAGS := optional
LOCAL_MULTILIB := 32
LOCAL_VENDOR_MODULE := true

include $(BUILD_SHARED_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE           := libnvos_shim
LOCAL_SRC_FILES        := nvos_shim.cpp
LOCAL_SHARED_LIBRARIES := libnvos
LOCAL_VENDOR_MODULE    := true
include $(BUILD_SHARED_LIBRARY)