export TARGET = iphone:clang:latest:14.0
export ARCHS = arm64
export ADDITIONAL_CFLAGS = -I$(THEOS_PROJECT_DIR)/Tweaks/RemoteLog -I$(THEOS_PROJECT_DIR)/Tweaks

INSTALL_TARGET_PROCESSES = YouTube
TWEAK_NAME = YouTubePlus
DISPLAY_NAME = YouTube
BUNDLE_ID = com.google.ios.youtube

$(TWEAK_NAME)_FILES := $(wildcard Sources/*.xm) $(wildcard Sources/*.x)
$(TWEAK_NAME)_FRAMEWORKS = UIKit Security
$(TWEAK_NAME)_CFLAGS = -fobjc-arc -Wno-module-import-in-extern-c

include $(THEOS)/makefiles/common.mk
ifneq ($(JAILBROKEN),1)
SUBPROJECTS += Tweaks/Return-YouTube-Dislikes Tweaks/YouPiP Tweaks/YTUHD Tweaks/DontEatMyContent Tweaks/NoYTPremium Tweaks/YouTube-X Tweaks/YTPremiumLogo Tweaks/YouChooseQuality
include $(THEOS_MAKE_PATH)/aggregate.mk
endif
include $(THEOS_MAKE_PATH)/tweak.mk

ISPONSORBLOCK_PATH = Tweaks/iSponsorBlock

before-package::
	@mkdir -p $(THEOS_STAGING_DIR)/Library/Application\ Support
	@mkdir -p $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries
	@cp -r $(ISPONSORBLOCK_PATH)/*.bundle $(THEOS_STAGING_DIR)/Library/Application\ Support/
	@cp -r $(ISPONSORBLOCK_PATH)/*.dylib $(THEOS_STAGING_DIR)/Library/MobileSubstrate/DynamicLibraries/
