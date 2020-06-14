TARGET = iphone:clang:13.0:11.0
ARCHS = arm64 arm64e

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libappearancecell

libappearancecell_FILES = AppearanceSelectionTableCell.m
libappearancecell_CFLAGS = -fobjc-arc
libappearancecell_FRAMEWORKS = UIKit
libappearancecell_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/library.mk

after-all::
	cp .theos/obj/debug/libappearancecell.dylib $(THEOS)/lib
	mkdir -p $(THEOS_STAGING_DIR)/usr/include/libappearancecell
	cp ./public/*.h $(THEOS_STAGING_DIR)/usr/include/libappearancecell

# SUBPROJECTS += PreferencesExample

include $(THEOS_MAKE_PATH)/aggregate.mk
