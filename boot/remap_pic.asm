remap_pic:
pushad
mov al, 0x11  ; initialize command
out 0x20, al  ; master pic
out 0x80, al  ; buffer instruction to let pic process previous io

out 0xA0, al  ; slave pic
out 0x80, al

mov al, 0x20;idt_start+0x100  ; vector offset for master pic
out 0x21, al
out 0x80, al

mov al, 0x28;idt_start+0x108  ; vector offset for slave pic
out 0xA1, al
out 0x80, al

mov al, 0x04  ; slave pic present at IRQ 2
out 0x21, al
out 0x80, al

mov al, 0x02  ; slave pic is cascaded
out 0xA1, al
out 0x80, al

mov al, 0x01  ; 8086 mode
out 0x21, al
out 0x80, al

out 0xA1, al
out 0x80, al

mov al, 0xFF  ; mask all interrupts off for now
out 0x21, al
out 0x80, al

out 0xA1, al
out 0x80, al
popad
ret
