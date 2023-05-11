;idt
idt_start:
  times 256 db 0
idt_end:

idt_descriptor:
  dw idt_end - idt_start - 1
  dd idt_start
