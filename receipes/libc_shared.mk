TARGET_DIR	=$(GOPATH)/build
TARGET_OBJNAME	= lib$(TARGET_NAME).so
TARGET_OBJS	= $(TARGET_SRCS:.c=.o)
CROSS_CC	= gcc
CFLAGS		+= -fPIC -g
LDFLAGS		+= -shared

OS = $(shell uname -s)
TARGET_OBJNAME_MAJOR = $(TARGET_OBJNAME).$(MAJOR)
TARGET_OBJNAME_MAJOR_MINOR = $(TARGET_OBJNAME_MAJOR).$(MINOR)

ifeq ($(OS), Linux)

endif

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
	@rm -f *.so* *.o
	@echo "$(TARGET_OBJNAME) cleaned up"

build_target: $(TARGET_OBJNAME_MAJOR_MINOR)

$(TARGET_OBJNAME_MAJOR_MINOR): $(TARGET_OBJS)
	$(CROSS_CC) -shared -Wl,-soname,$@ $^ -o $@

%.o: %.c
	$(CROSS_CC) $(CFLAGS) -c $<

#all: $(TARGET_NAME)

#$(TARGET_NAME): $(TARGET_OBJS)
#	$(CROSS_CC) $(LDFLAGS) $(CFLAGS) -o $@ $(TARGET_OBJS)


#gen_goso:
#	rm -f $(TARGET_DIR)/build/libc/$(TARGET_NAME)*
	
	
#shared:
#	rm -f libcddaex.so libcddaex.so.1
#	gcc -c -fPIC cdda_ex.c
#	gcc -shared -Wl,-soname,libcddaex.so.1 -o libcddaex.so cdda_ex.o
#	ln -s libcddaex.so libcddaex.so.1
#	rm -rf cdda_ex.o

#clean:
#	@rm libcddaex.so libcddaex.so.1
