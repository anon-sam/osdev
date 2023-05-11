; Read some sectors from the boot disk
[org 0x7c00]

mov [BOOT_DRIVE], dl  ; BIOS stores boot drive in DL

mov bp, 0x8000
mov sp, bp

mov bx, 0x9000
mov dh, 2
mov dl, [BOOT_DRIVE]
call disk_load

mov dx, [0x9000]
call print_hex

mov dx, [0x9000 + 3]
call print_hex

mov dx, [0x9000 + 512]
call print_hex

mov dx, [0x9000 + 516]
call print_hex

jmp $

%include "print_string.asm"
%include "print_hex.asm"
%include "disk_load.asm"

BOOT_DRIVE db 0

times 510-($-$$) db 0
dw 0xaa55

; We know that BIOS will load only he first 512 byte
; sector from the disk so if we purposely add a few
; more sectors, we can prove to ourself that we loaded
; the two additional sectors from the disk we booted
; from

;times 1280 dw 0xfefa
times 256 dw 0xdab9
times 256 dw 0xface
