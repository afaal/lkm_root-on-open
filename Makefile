obj-m += mod.o

all:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules

clean:
	make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
test:
	-sudo rmmod mod
	sudo dmesg -C
	sudo insmod mod.ko
	dmesg
remove: 
	-sudo rm /dev/lkm_example
	-sudo rmmod lkm_example