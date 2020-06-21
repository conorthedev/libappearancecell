include $(THEOS)/makefiles/common.mk

SUBPROJECTS += Library

ifeq ($(DEBUG), 1)
SUBPROJECTS += Example
endif

include $(THEOS_MAKE_PATH)/aggregate.mk
