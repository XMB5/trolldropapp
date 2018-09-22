ifeq ($(THEOS),)
	THEOS = /home/sam/Downloads/Applications/Libraries/theos
endif

TARGET = ::11.0
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = trolldropapp
trolldropapp_FILES = XXAppDelegate.swift XXRootViewController.swift
trolldropapp_FRAMEWORKS = UIKit CoreGraphics
trolldropapp_CODESIGN_FLAGS = -Sent.xml

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"trolldropapp\"" || true
