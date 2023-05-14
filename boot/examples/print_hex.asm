print_hex:
  pusha
  mov cx,5
  loop:
	cmp dx, 0
	je endf
	mov al, dl
	shr dx, 4
	and al, 15
	add al, '0'
	cmp al, '9'
	jle fine
	add al, 7
  fine:
	mov [HEX_OUT + ecx],al
	sub cx,1
	jmp loop
  endf:
	mov bx, HEX_OUT
	call print_string
	popa
	ret

HEX_OUT: db '0x0000',0
