
# To build modules outside of the kernel tree, we run "make"
# in the kernel source tree; the Makefile these then includes this
# Makefile once again.
# This conditional selects whether we are being included from the
# kernel Makefile or not.
ifeq ($(KERNELRELEASE),)

    # Assume the source tree is where the running kernel was built
    # You should set KERNELDIR in the environment if it's elsewhere
    KERNELDIR ?= ./linux-2.6.37-psp04.04.00.01
    # The current directory is passed to sub-makes as argument
    PWD := $(shell pwd)
	
modules:
	$(MAKE) ARCH=arm CROSS_COMPILE=/opt/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi- -C $(KERNELDIR) M=$(PWD) modules

modules_install:
	$(MAKE) ARCH=arm CROSS_COMPILE=/opt/CodeSourcery/Sourcery_G++_Lite/bin/arm-none-linux-gnueabi- -C $(KERNELDIR) M=$(PWD) modules_install

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions *.order *.symvers

.PHONY: modules modules_install clean

else
    # called from kernel build system: just declare what our modules are
	obj-m := mc.o
endif


