[bits 32]

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f
WHITE_ON_BLUE equ 0x1f
BLACK_ON_BLUE equ 0x10
BLACK_ON_WHITE equ 0xf0

print_string_pm:
  pusha
  mov edx, VIDEO_MEMORY

  print_string_loop:
	mov al, [ebx]
	mov ah, BLACK_ON_WHITE
	cmp al, 0
	je done

	mov [edx], ax
	add ebx, 1	  ; Increment ebx to next char
	add edx, 2	  ; Move to next character cell

	jmp print_string_loop

  done:
	popa
	ret
