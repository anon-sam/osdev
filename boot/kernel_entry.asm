[bits 16]
call switch_to_pm
[bits 32]
[extern main]

; BEGIN_PM function called after switching to pm

BEGIN_PM:
  mov ebx, MSG_PROT_MODE
  call print_string_pm
  

  call main
  jmp $

%include "switch_to_pm.asm"
%include "print_string_pm.asm"
%include "idt.asm"
%include "remap_pic.asm"
%include "gdt.asm"

MSG_PROT_MODE db "Successfully landed in protected mode",0
