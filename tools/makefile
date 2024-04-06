CC=Tools/ccmix/ccmix.exe
CFLAGS=--create --lmd --game=ra2
MIX_FOLDER=MIX

MIX_DIRS=$(patsubst %,%,$(notdir $(wildcard $(MIX_FOLDER)/*)))
MIX_ARCS=$(patsubst %,%.mix,$(notdir $(wildcard $(MIX_FOLDER)/*)))

# Functions and command testing
# tmp=$(patsubst %,%,$(notdir $(wildcard $(MIX_FOLDER)/$(patsubst %.mix,%,$(MIX_ARCS))/*)))
# info types text to the console
# $(info $(tmp))

.PHONY: all
all: $(MIX_ARCS)

# Rule to compile
%.mix: 
	$(CC) $(CFLAGS) --dir "./$(MIX_FOLDER)/$(basename $@)" --mix ./$@
