#PACKAGES += 

.PHONY: packages $(PACKAGES)

packages: $(PACKAGES)

$(PACKAGES):
	echo $@
	make -C $@

#all:
#	@for DIR in $(PACKAGES); do	\
#		make -C $$DIR;		\
#	done

clean:
	@echo "CLean"
	@for DIR in $(PACKAGES); do	\
		make -C $$DIR clean;	\
	done

distclean:
	@rm -rf build
