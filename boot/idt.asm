;idt
num_entries equ 32

; 32 for software interrupts reserved by intel, 16 hardware interrupts from irq
; 22-31 are unused reserved
; need to add handlers for hardware interrupts later, currently all irqs are masked off
[extern isr1]
[extern isr2]
[extern isr3]
[extern isr4]
[extern isr5]
[extern isr6]
[extern isr7]
[extern isr8]
[extern isr9]
[extern isr10]
[extern isr11]
[extern isr12]
[extern isr13]
[extern isr14]
[extern isr15]
[extern isr16]
[extern isr17]
[extern isr18]
[extern isr19]
[extern isr20]
[extern isr21]
[extern isr22]
[extern isr23]
[extern isr24]
[extern isr25]
[extern isr26]
[extern isr27]
[extern isr28]
[extern isr29]
[extern isr30]
[extern isr31]
[extern isr32]

isr_list dd isr1,isr2,isr3,isr4,isr5,isr6,isr7,isr8,isr9,isr10,isr11,isr12,isr13,isr14,isr15,isr16,isr17,isr18,isr19,isr20,isr21,isr22,isr23,isr24,isr25,isr26,isr27,isr28,isr29,isr30,isr31,isr32

idt_start:
  times 512 dd 0
idt_end:

init_idt:
  pushad
  mov ecx,0
  mov edx, 0
  idt_loop:
	cmp ecx, num_entries
	jge init_done
	mov ebx, [isr_list + ecx]
	mov [idt_start + edx], bx
	add edx, 2
	mov word [idt_start + edx], CODE_SEG
	add edx, 2
	mov byte [idt_start + edx], 0
	add edx, 1
	mov byte [idt_start + edx], 0x8f
	add edx, 1
	shr ebx,16
	mov [idt_start + edx], bx
	add edx, 2
	add ecx, 4
	jmp idt_loop
  init_done:
	popad
	ret

idt_descriptor:
  dw idt_end - idt_start - 1
  dd idt_start
