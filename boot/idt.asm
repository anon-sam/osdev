;idt
num_entries equ 22

; 32 for software interrupts reserved by intel, 16 hardware interrupts from irq
; 22-31 are unused reserved
; irqs are hopefully handled by pic remapping
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

isr_list times num_entries dd isr1,isr2,isr3,isr4,isr5,isr6,isr7,isr8,isr9,isr10,isr11,isr12,isr13,isr14,isr15,isr16,isr17,isr18,isr19,isr20,isr21,isr22

offset1 dw num_entries dup(0) ; higher word of offset
offset2 dw num_entries dup(0) ; lower word of offset

%macro idt_entry 3
  dw %1
  dw CODE_SEG
  db 0
  db %2
  dw %3
%endmacro

idt_start:
  idt_entry offset1, 0x8f, offset2
  idt_entry offset1+1, 0x8f, offset2+1
  idt_entry offset1+2, 0x8f, offset2+2
  idt_entry offset1+3, 0x8f, offset2+3
  idt_entry offset1+4, 0x8f, offset2+4
  idt_entry offset1+5, 0x8f, offset2+5
  idt_entry offset1+6, 0x8f, offset2+6
  idt_entry offset1+7, 0x8f, offset2+7
  idt_entry offset1+8, 0x8f, offset2+8
  idt_entry offset1+9, 0x8f, offset2+9
  idt_entry offset1+10, 0x8f, offset2+10
  idt_entry offset1+11, 0x8f, offset2+11
  idt_entry offset1+12, 0x8f, offset2+12
  idt_entry offset1+13, 0x8f, offset2+13
  idt_entry offset1+14, 0x8f, offset2+14
  idt_entry offset1+15, 0x8f, offset2+15
  idt_entry offset1+16, 0x8f, offset2+16
  idt_entry offset1+17, 0x8f, offset2+17
  idt_entry offset1+18, 0x8f, offset2+18
  idt_entry offset1+19, 0x8f, offset2+19
  idt_entry offset1+20, 0x8f, offset2+20
  idt_entry offset1+21, 0x8f, offset2+21
 times 10 db 0
idt_end:

init_idt:
  pushad
  mov ax,0
  idt_loop:
	cmp eax, num_entries
	jge init_done
	mov ebx, [isr_list + eax]
	mov [offset1 + eax], ebx
	shr ebx, 16
	mov [offset2 + eax], ebx
	add ax, 1
	jmp idt_loop
  init_done:
	popad
	ret

idt_descriptor:
  dw idt_end - idt_start - 1
  dd idt_start
