TARGET = iphone:clang:13.0:11.0
ARCHS = arm64 arm64e
INSTALL_TARGETS_PROCESS = Preferences

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = libappearancecell_demo

libappearancecell_demo_FILES = ACDRootListController.m
libappearancecell_demo_INSTALL_PATH = /Library/PreferenceBundles
libappearancecell_demo_FRAMEWORKS = UIKit
libappearancecell_demo_LIBRARIES = appearancecell
libappearancecell_demo_PRIVATE_FRAMEWORKS = Preferences
libappearancecell_demo_CFLAGS = -fobjc-arc

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/libappearancecell_demo.plist$(ECHO_END)

include $(THEOS_MAKE_PATH)/bundle.mk
