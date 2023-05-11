C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)

OBJ = ${C_SOURCES:.c=.o}

os-image: boot/boot_ckern.bin kernel.bin
	cat $^ > $@

run: os-image
	kvm $<

%.bin: %.asm
	nasm -f bin $< -I'boot/' -o $@

kernel.bin: kernel/kernel_entry.o ${OBJ}
	ld  -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c
	 gcc -m32 -MMD -fno-pie -ffreestanding -c $< -o $@

kernel/%.o: boot/%.asm
	 nasm -f elf $< -I'boot/' -o $@

clean:
	rm -rf *.o *.bin os-image *.d
	rm -rf kernel/*.o boot/*.bin drivers/*.o kernel/*.d drivers/*.d
