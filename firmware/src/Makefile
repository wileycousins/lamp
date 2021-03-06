# simple AVR Makefile
#
# written by michael cousins (github.com/mcous)
# released to the public domain

# Makefile
#
# targets:
#   all:    compiles the source code
#   test:   tests the isp connection to the mcu
#   flash:  writes compiled hex file to the mcu's flash memory
#   fuse:   writes the fuse bytes to the MCU
#   disasm: disassembles the code for debugging
#   clean:  removes all .elf, and .o files in the obj and exe directories

# parameters (change this stuff accordingly)
# project name
PRJ = lamp
# avr mcu
MCU = atmega328p
# mcu clock frequency
CLK = 14745600 
# avr programmer (and port if necessary)
#PRG = avrispv2 -P usb -b 115200 -vvv
PRG = avrisp -P /dev/tty.usbmodem411 -b 19200
# fuse bit values for v0.1 pcb
# use external crystal oscillator with no clock division and slowest available startup
# enable SPI programming
# brownout detection at 2.7 V
LFU = 0xFF
HFU = 0xDD
EFU = 0x05
# program source files
SRC = $(PRJ).cpp
# where to look for included libraries (consisting of .c/.cpp files and .h files)
# e.g. INC = ../../EyeToSee ../../YouSART
INC = 
# any defines to send the compiler
DEF = F_CPU=$(CLK)
# directories
OBJDIR = ../bin/obj
EXEDIR = ../bin/exe
MAPDIR = ../bin/map

#################################################################################################
# \/ stuff nobody needs to worry about until such time that worrying about it is appropriate \/ #
#################################################################################################

# include path
INCLUDES := $(addprefix -I,$(INC))
# defines
DEFINES  := $(addprefix -D,$(DEF))
# c flags
CFLAGS    = -Wall -Os -funsigned-char $(DEFINES) -mmcu=$(MCU) $(INCLUDES)
# any aditional flags for c++
CPPFLAGS  = -fno-exceptions
# linker flags
LDFLAGS   = -Wl,-Map=$(MAPDIR)/$(PRJ).map,--cref

# executables
AVRDUDE = avrdude -c $(PRG) -p $(MCU)
OBJCOPY = avr-objcopy
OBJDUMP = avr-objdump
SIZE    = avr-size --format=avr --mcu=$(MCU)
CC      = avr-gcc

# generate list of objects
CFILES   := $(filter %.c, $(SRC)) $(foreach dir, $(INC), $(wildcard $(dir)/*.c))
CPPFILES := $(filter %.cpp, $(SRC)) $(foreach dir, $(INC), $(wildcard $(dir)/*.cpp))
OBJDEPS  := $(CFILES:.c=.o) $(CPPFILES:.cpp=.o)
OBJ      := $(addprefix $(OBJDIR)/,$(notdir $(OBJDEPS)))

# user targets
# compile all files
all: $(EXEDIR)/$(PRJ).hex

# test programmer connectivity
testflash:
	$(AVRDUDE) -v

# flash program to mcu
flash: all
	$(AVRDUDE) -U flash:w:$(EXEDIR)/$(PRJ).hex:i

# write fuses to mcu
fuse:
	$(AVRDUDE) -U lfuse:w:$(LFU):m -U hfuse:w:$(HFU):m -U efuse:w:$(EFU):m

# generate disassembly files for debugging
disasm: $(EXEDIR)/$(PRJ).elf
	$(OBJDUMP) -d $(EXEDIR)/$(PRJ).elf

# remove compiled files
clean:
	rm -f $(EXEDIR)/$(PRJ).elf $(OBJ)

# link the objects into an elf
$(EXEDIR)/$(PRJ).elf: $(OBJDEPS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $(EXEDIR)/$(PRJ).elf $(OBJ)

# create a hex from the elf
$(EXEDIR)/$(PRJ).hex: $(EXEDIR)/$(PRJ).elf
	rm -f $(EXEDIR)/$(PRJ).hex
	$(OBJCOPY) -j .text -j .data -O ihex $(EXEDIR)/$(PRJ).elf $(EXEDIR)/$(PRJ).hex
	$(SIZE) $(EXEDIR)/$(PRJ).elf

$(OBJDEPS): | $(OBJDIR) $(EXEDIR) $(MAPDIR)

$(OBJDIR):
	mkdir -p $(OBJDIR)

$(EXEDIR):
	mkdir -p $(EXEDIR)

$(MAPDIR):
	mkdir -p $(MAPDIR)

# pattern matching for object files
# objects from c files
%.o : %.c 
	$(CC) $(CFLAGS) -c $< -o $(OBJDIR)/$(notdir $@)

# objects from c++ files
%.o : %.cpp 
	$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $(OBJDIR)/$(notdir $@)
