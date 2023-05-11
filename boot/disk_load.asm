; load DH sectors to ES:BX from drive DL
disk_load:
  push dx		  ; Store DX on stack so later we can recall
				  ; how many sectors were request to be read
  mov ah, 0x02	  ; disk read mode
  mov al, dh	  ; read dh sectors
  mov ch, 0x00	  ; Select cylinder 0
  mov dh, 0x00	  ; Select head 0
  mov cl, 0x02	  ; Start reading from second sector

  int 0x13		  ; BIOS interrupt

  jc disk_error	  ; Jump if error (i.e. carry flag set)

  pop dx		  ; Restore DX
  cmp dh, al	  ; if AL (sectors read) != DH (sectors present)
  jne disk_error  ; error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $

DISK_ERROR_MSG db "Disk read error",0
