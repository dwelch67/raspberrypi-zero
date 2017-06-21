
ARMGNU ?= arm-none-eabi
#ARMGNU ?= arm-linux-gnueabi

AOPS = --warn --fatal-warnings -mcpu=arm1176jzf-s -march=armv6 -mfpu=vfp
COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding -mcpu=arm1176jzf-s -mtune=arm1176jzf-s -mhard-float -mfpu=vfp

all : kernel.img

clean :
	rm -f *.o
	rm -f *.bin
	rm -f *.srec
	rm -f *.elf
	rm -f *.list
	rm -f *.img

start.o : start.s
	$(ARMGNU)-as $(AOPS) start.s -o start.o

notmain.o : notmain.c
	$(ARMGNU)-gcc $(COPS) -c notmain.c -o notmain.o

periph.o : periph.c
	$(ARMGNU)-gcc $(COPS) -c periph.c -o periph.o

fun.o : fun.c
	$(ARMGNU)-gcc $(COPS) -c fun.c -o fun.o

notmain.elf : memmap start.o fun.o periph.o notmain.o 
	$(ARMGNU)-ld start.o fun.o periph.o notmain.o -T memmap -o notmain.elf
	$(ARMGNU)-objdump -D notmain.elf > notmain.list

kernel.img : notmain.elf
	$(ARMGNU)-objcopy --srec-forceS3 notmain.elf -O srec notmain.srec
	$(ARMGNU)-objcopy notmain.elf -O binary kernel.img

