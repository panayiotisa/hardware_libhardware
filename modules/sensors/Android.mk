# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


LOCAL_PATH := $(call my-dir)

ifneq ($(TARGET_SIMULATOR),true)

# HAL module implemenation, not prelinked, and stored in
# hw/<SENSORS_HARDWARE_MODULE_ID>.<ro.product.board>.so
include $(CLEAR_VARS)

LOCAL_MODULE :=  sensors.$(TARGET_BOARD_PLATFORM)

LOCAL_MODULE_PATH := $(TARGET_OUT_SHARED_LIBRARIES)/hw

LOCAL_MODULE_TAGS := eng debug optional

#LOCAL_CFLAGS := -DLOG_TAG=\"Sensors\" \
#				-DSENSORHAL_ACC_ADXL346 \
#				-Wall
#				-DSENSORHAL_ACC_KXTF9 \

LOCAL_CFLAGS:= -DLOG_TAG=\"SensorHal\"  

#LOCAL_C_INCLUDES := \
  #               kernel/include

LOCAL_SRC_FILES := \
			SensorBase.cpp \
			InputEventReader.cpp \
			AkmSensor.cpp \
			BmaSensor.cpp \
			sensors.cpp

ifeq ($(TARGET_PRODUCT), U8828D)
LOCAL_CFLAGS += -DSENSORHAL_LIGHT_TSL -DSENSORHAL_ACC_BAMLIS3DH
LOCAL_SRC_FILES += \
			TmdSensor.cpp
else
LOCAL_SRC_FILES += \
			LightSensor31XX.cpp \
			ProximitySensor.cpp 
endif


LOCAL_SHARED_LIBRARIES := liblog libcutils libdl
LOCAL_PRELINK_MODULE := false

include $(BUILD_SHARED_LIBRARY)

endif # !TARGET_SIMULATOR
