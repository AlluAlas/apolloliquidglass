TARGET := iphone:clang:latest:18.0
ARCHS = arm64
INSTALL_TARGET_PROCESSES = Apollo

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = ApolloFix

ApolloFix_FILES = Tweak.x
ApolloFix_CFLAGS = -fobjc-arc
ApolloFix_FRAMEWORKS = UIKit Foundation

include $(THEOS)/makefiles/tweak.mk
