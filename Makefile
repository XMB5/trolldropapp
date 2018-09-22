ifeq ($(THEOS),)
	THEOS = /home/sam/Downloads/Applications/Libraries/theos
endif

TARGET = ::11.2
ARCHS = arm64

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = trolldropapp
trolldropapp_FILES = XXAppDelegate.swift XXRootViewController.swift trolldrop/Person.swift trolldrop/Sharing.swift trolldrop/TrollController.swift
trolldropapp_FRAMEWORKS = UIKit CoreGraphics Foundation
trolldropapp_CODESIGN_FLAGS = -Sent.xml

_THEOS_PLATFORM_DPKG_DEB_COMPRESSION = gzip

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"trolldropapp\"" || true
