ARCHS = arm64 
TARGET = iphone:clang:latest:14.0
INSTALL_TARGET_PROCESSES = WeChat
include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WCHideChatAvatars
$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS += -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
TARGET := iphone:clang:latest:15.6
INSTALL_TARGET_PROCESSES = com.tencent.xin
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = tx

WCHideChatAvatars_FILES = Tweak.x
WCHideChatAvatars_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk
