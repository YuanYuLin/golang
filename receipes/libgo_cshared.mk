#
# Build the listed main packages, 
# plus all packages that they import, 
# into C shared libraries.
#
TARGET_DIR	= $(GOPATH)/build
TARGET_OBJNAME	= lib$(TARGET_NAME).so
BUILDMODE	= c-shared

include $(GOROOT)/../libgo_build.mk
