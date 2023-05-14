mov bx, 3

cmp bx, 4
jle lesseq4
cmp bx, 40
jl less40
mov al, 'C'

doit:
mov ah, 0x0e
int 0x10

jmp $

lesseq4:
  mov al, 'A'
  jmp doit

less40:
  mov al,'B'
  jmp doit

times 510-($-$$) db 0
dw 0xaa55
