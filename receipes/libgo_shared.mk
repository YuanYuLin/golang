#
# Combine all the listed non-main packages into a single shared library.
#
TARGET_DIR	= $(GOPATH)/build
TARGET_OBJNAME	= lib$(TARGET_NAME).so
BUILDMODE	= shared

include $(GOROOT)/../libgo_build.mk
