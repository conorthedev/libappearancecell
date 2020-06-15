TARGET = iphone:clang:13.0:11.0
ARCHS = arm64 arm64e
DEBUG = 0
FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

LIBRARY_NAME = libappearancecell

libappearancecell_FILES = AppearanceSelectionTableCell.m
libappearancecell_CFLAGS = -fobjc-arc
libappearancecell_FRAMEWORKS = UIKit
libappearancecell_PRIVATE_FRAMEWORKS = Preferences

after-all::
	cp .theos/obj/libappearancecell.dylib $(THEOS)/lib
	mkdir -p $(THEOS_STAGING_DIR)/usr/include/libappearancecell
	cp libappearancecell.h $(THEOS_STAGING_DIR)/usr/include/libappearancecell
	cp libappearancecell.h $(THEOS)/include/libappearancecell/libappearancecell

# SUBPROJECTS += PreferencesExample

include $(THEOS_MAKE_PATH)/library.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
