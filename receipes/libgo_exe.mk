TARGET_DIR	= $(GOPATH)/build/
TARGET_OBJNAME	= $(TARGET_NAME)
BUILDMODE	= exe

include $(GOROOT)/../libgo_build.mk
