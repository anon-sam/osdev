[bits 16]
; Switch to protected mode

switch_to_pm:
  cli				; Switch interrupts off
  lgdt [gdt_descriptor]	; Load global desciptor table

  mov eax, cr0
  or eax, 0x1
  mov cr0, eax			; set first bit of cr0 to 1 to switch to 
						; protected mode

  jmp CODE_SEG:init_pm	; Make a far jump to flush pipeline

  [bits 32]
  ;	Initialize registers and stack once in PM
  init_pm:
	mov ax, DATA_SEG	; Point segment registers to the data selector
	mov ds, ax			; defined in GDT
	mov ss, ax
	mov es, ax
	mov fs, ax
	mov gs, ax

	mov ebp, 0x90000
	mov esp, ebp
	lidt [idt_descriptor]
	call remap_pic
	sti

	call BEGIN_PM		; Call some label in PM
