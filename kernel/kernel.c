#include "../drivers/screen.h"
void main() {
  //char* video_memory = (char *) (0xb8000+160);
  //*video_memory = 'X';
  clear_screen();
  char a[] = "Hello World";
  //print_at(a,0,0);
  print(a);
}
