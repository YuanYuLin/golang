OS=$(shell uname -s)
TARGET_OBJNAME_MAJOR = $(TARGET_OBJNAME).$(MAJOR)
TARGET_OBJNAME_MAJOR_MINOR = $(TARGET_OBJNAME_MAJOR).$(MINOR)

all: check_env build_target install_target
	@echo "$(TARGET_OBJNAME_MAJOR_MINOR) built"

check_env:
ifeq ($(MAJOR),)
	@echo "Please check your version of MAJOR number"
	@exit 1
endif
ifeq ($(MINOR),)
	@echo "Please check your version of MINOR number"
	@exit 1
endif


install_target:
	@mkdir -p $(TARGET_DIR)
	@ln -s $(TARGET_OBJNAME_MAJOR_MINOR)	$(TARGET_OBJNAME_MAJOR)
	@ln -s $(TARGET_OBJNAME_MAJOR)		$(TARGET_OBJNAME)
	@mv $(TARGET_OBJNAME)			$(TARGET_DIR)
	@mv $(TARGET_OBJNAME_MAJOR)		$(TARGET_DIR)
	@mv $(TARGET_OBJNAME_MAJOR_MINOR)	$(TARGET_DIR)

clean:
	@rm -rf $(TARGET_DIR)/$(TARGET_OBJNAME)*
	@echo "$(TARGET_OBJNAME) cleaned up"

build_target:
	$(GOROOT)/bin/go build -v -x -buildmode=$(BUILDMODE) -o $(TARGET_OBJNAME_MAJOR_MINOR)

