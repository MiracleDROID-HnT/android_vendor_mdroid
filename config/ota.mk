# Copyright (C) 2018 MiracleDROID
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

ifeq ($(MDROID_BUILDTYPE), OFFICIAL)
ifneq ($(filter mdroid_mido mdroid_land mdroid_kenzo mdroid_tissot mdroid_santoni mdroid_potter mdroid_wt88047 mdroid_vince,$(TARGET_PRODUCT)),)

PRODUCT_PACKAGES += \
    MiracleOTA

endif
endif
