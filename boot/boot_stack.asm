;
; A simple boot sector program that demonstrates the stack.

mov ah, 0x0e

mov bp, 0x8000	; Set the base of the stack a little above where BIOS
				; loads our boot sector (0x7c00) - so it wont' overwrite us

mov sp, bp

push 'A'		; Push some characters on stack. pushed as 16-bit values
push 'B'
push 'C'

pop bx			; we can only pop 16-bits, so pop to bx then copy bl
mov al, bl		; i.e. 8-bit char to al
int 0x10

pop bx
mov al, bl
int 0x10

mov al, [0x7ffe] ; To prove stack grows downwards from bp, fetch
				 ; character at 0x8000 - 0x2 (16 bits)
int 0x10

jmp $

; Padding and magic BIOS number

times 510-($-$$) db 0
dw 0xaa55
