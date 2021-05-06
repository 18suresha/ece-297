#include <stdio.h>
#include <unistd.h>

int main() {   
  int i = 0;
  while (1) {
    if (i % 2 == 0)
      printf("Hello SIGPwny!\n");
    else
      printf("Hello ECE 297!\n");
    i = 1 - i;
    sleep(5);
  }
  return 0;
}
