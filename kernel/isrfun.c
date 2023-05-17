#include "../drivers/screen.h"

void dbz_handler(){
  char a[] = "Finally made it\n";
  print(a);
  __asm__("hlt":::); // Halt until processes are properly established
}
