print_string:
  pusha
  mov ah, 0x0e
  compare:
	cmp byte [bx], 0
	je endfun
	mov al, byte [bx]
	add bx, 1
	int 0x10
	jmp compare
  endfun:
	popa
    ret
