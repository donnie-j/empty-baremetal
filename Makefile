OBJS = main.o uartlite.o

SPECS_FILE = specs
CC = sh2-elf-gcc
CFLAGS =  -specs=$(SPECS_FILE) -mcu=128k -mj2 -Os -g -Wall -I../minimal-lib/include
LDFLAGS = -specs=$(SPECS_FILE) -mcu=128k -L../minimal-lib -lm -lc

all: image.elf

image.elf: $(CRT_OBJS) $(OBJS)
	$(CC) $(OBJS) $(LDFLAGS) -o $@

version.c:
	@printf "char version_string[] = \"revision: $(shell hg head | head -1)\\\\nbuild: $(shell date)\\\\n\";\n" > $@

clean:
	- rm *.[oa] image.elf version.c

