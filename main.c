#include <stdlib.h>
#include "uart.h"

static int
puts(const char *str)
{
   while (*str) uart_tx(0, *(str++));
   return 0;
}

__attribute__ ((destructor))
void
foo()
{
   puts("exiting\n");
}

int
main (int argc, char *argv[])
{
   *(volatile unsigned long*)0xabcd0000 = 0xff;
   exit(1); /* runs destructors */
   while(1) {;}
}
