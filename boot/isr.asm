; Interrupt service routines for exceptions
; will call interrupt handlers written in C, along with wrapping

%macro unhandled_isr 1
  isr%1:
	cli
	mov ebx, MSG_HLT
	call print_string_pm
	hlt
%endmacro

[extern dbz_handler]
isr1:
  pushad
  cld
  call dbz_handler
  popad
  iret

;unhandled_isr 1
unhandled_isr 2
unhandled_isr 3
unhandled_isr 4
unhandled_isr 5
unhandled_isr 6
unhandled_isr 7
unhandled_isr 8
unhandled_isr 9
unhandled_isr 10
unhandled_isr 11
unhandled_isr 12
unhandled_isr 13
unhandled_isr 14
unhandled_isr 15
unhandled_isr 16
unhandled_isr 17
unhandled_isr 18
unhandled_isr 19
unhandled_isr 20
unhandled_isr 21
unhandled_isr 22
unhandled_isr 23
unhandled_isr 24
unhandled_isr 25
unhandled_isr 26
unhandled_isr 27
unhandled_isr 28
unhandled_isr 29
unhandled_isr 30
unhandled_isr 31
unhandled_isr 32

MSG_HLT db "Halting on unhandled interrupt",0
