ifeq ($(THEOS),)
	THEOS = /home/sam/Downloads/Applications/Libraries/theos
endif

include $(THEOS)/makefiles/common.mk

APPLICATION_NAME = trolldropapp
trolldropapp_FILES = main.m XXAppDelegate.m XXRootViewController.m
trolldropapp_FRAMEWORKS = UIKit CoreGraphics

include $(THEOS_MAKE_PATH)/application.mk

after-install::
	install.exec "killall \"trolldropapp\"" || true
