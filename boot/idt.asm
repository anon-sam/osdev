;idt
num_entries equ 48

; 32 for software interrupts reserved by intel, 16 hardware interrupts from irq
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
[extern irq1]
[extern irq2]
[extern irq3]
[extern irq4]
[extern irq5]
[extern irq6]
[extern irq7]
[extern irq8]
[extern irq9]
[extern irq10]
[extern irq11]
[extern irq12]
[extern irq13]
[extern irq14]
[extern irq15]
[extern irq16]

isr_list times num_entries dd
isr1,isr2,isr3,isr4,isr5,isr6,isr7,isr8,isr9,isr10,isr11,isr12,isr13,isr14,isr15,isr16,isr17,isr18,isr19,isr20,isr21,isr22,isr23,isr24,isr25,isr26,isr27,isr28,isr29,isr30,isr31,isr32,irq1,irq2,irq3,irq4,irq5,irq6,irq7,irq8,irq9,irq10,irq11,irq12,irq13,irq14,irq15,irq16

offset1 dw num_entries dup(0) ; higher word of offset
offset2 dw num_entries dup(0) ; lower word of offset

idt_entry macro offset1, gtpdpl, offset2
  dw offset1
  dw CODE_SEG
  db 0
  db gtpdpl
  dw offset2
endm

idt_start:
  idt_entry [offset1], 0x8f, [offset2]
  idt_entry [offset1+8], 0x8f, [offset2+8]
  idt_entry [offset1+16], 0x8f, [offset2+16]
  idt_entry [offset1+24], 0x8f, [offset2+24]
  idt_entry [offset1+32], 0x8f, [offset2+32]
  idt_entry [offset1+40], 0x8f, [offset2+40]
  idt_entry [offset1+48], 0x8f, [offset2+48]
  idt_entry [offset1+56], 0x8f, [offset2+56]
  idt_entry [offset1+64], 0x8f, [offset2+64]
  idt_entry [offset1+72], 0x8f, [offset2+72]
  idt_entry [offset1+80], 0x8f, [offset2+80]
  idt_entry [offset1+88], 0x8f, [offset2+88]
  idt_entry [offset1+96], 0x8f, [offset2+96]
  idt_entry [offset1+104], 0x8f, [offset2+104]
  idt_entry [offset1+112], 0x8f, [offset2+112]
  idt_entry [offset1+120], 0x8f, [offset2+120]
  idt_entry [offset1+128], 0x8f, [offset2+128]
  idt_entry [offset1+136], 0x8f, [offset2+136]
  idt_entry [offset1+144], 0x8f, [offset2+144]
  idt_entry [offset1+152], 0x8f, [offset2+152]
  idt_entry [offset1+160], 0x8f, [offset2+160]
  idt_entry [offset1+168], 0x8f, [offset2+168]
  idt_entry [offset1+176], 0x8f, [offset2+176]
  idt_entry [offset1+184], 0x8f, [offset2+184]
  idt_entry [offset1+192], 0x8f, [offset2+192]
  idt_entry [offset1+200], 0x8f, [offset2+200]
  idt_entry [offset1+208], 0x8f, [offset2+208]
  idt_entry [offset1+216], 0x8f, [offset2+216]
  idt_entry [offset1+224], 0x8f, [offset2+224]
  idt_entry [offset1+232], 0x8f, [offset2+232]
  idt_entry [offset1+240], 0x8f, [offset2+240]
  idt_entry [offset1+248], 0x8f, [offset2+248]
  idt_entry [offset1+256], 0x8f, [offset2+256]
  idt_entry [offset1+264], 0x8e, [offset2+264]
  idt_entry [offset1+272], 0x8e, [offset2+272]
  idt_entry [offset1+280], 0x8e, [offset2+280]
  idt_entry [offset1+288], 0x8e, [offset2+288]
  idt_entry [offset1+296], 0x8e, [offset2+296]
  idt_entry [offset1+304], 0x8e, [offset2+304]
  idt_entry [offset1+312], 0x8e, [offset2+312]
  idt_entry [offset1+320], 0x8e, [offset2+320]
  idt_entry [offset1+328], 0x8e, [offset2+328]
  idt_entry [offset1+336], 0x8e, [offset2+336]
  idt_entry [offset1+344], 0x8e, [offset2+344]
  idt_entry [offset1+352], 0x8e, [offset2+352]
  idt_entry [offset1+360], 0x8e, [offset2+360]
  idt_entry [offset1+368], 0x8e, [offset2+368]
  idt_entry [offset1+376], 0x8e, [offset2+376]
  idt_entry [offset1+384], 0x8e, [offset2+384]
 times 208 db 0
idt_end:

init_idt:
  pushad
  mov ax,0
  idt_loop:
	cmp eax, num_entries
	jge init_done
	shld edx,eax,3
	mov ebx, [isr_list + eax]
	mov [offset1 + edx], ebx
	shr ebx, 16
	mov [offset2 + edx], ebx
	add ax, 1
	jmp idt_loop
  init_done:
	popad
	ret

idt_descriptor:
  dw idt_end - idt_start - 1
  dd idt_start
