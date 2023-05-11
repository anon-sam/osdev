; A boot sector that boots a C kernel in 32-bit protected mode
[org 0x7c00]
KERNEL_OFFSET equ 0x1000  ; Memory offset to load kernel

mov [BOOT_DRIVE], dl

mov bp, 0x9000
mov sp, bp

mov bx, MSG_REAL_MODE
call print_string

call load_kernel

jmp $

%include "print_string.asm"
%include "disk_load.asm"

[bits 16]

; load kenrel
load_kernel:
  mov bx, MSG_LOAD_KERNEL
  call print_string
  
  mov bx, KERNEL_OFFSET
  mov dh, 10				; set parameters to load 
  mov dl, [BOOT_DRIVE]		; sectors to KERNEL_OFFSET
  
  call disk_load
  call KERNEL_OFFSET	  ; jump to address of loaded kernel

; Global variables
BOOT_DRIVE db 0
MSG_REAL_MODE db "Started in 16-bit Real mode\n",0
MSG_LOAD_KERNEL db "Loading kernel into memory\n",0

;Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
