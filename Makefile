
APR_CONFIG=$(shell which apr-1-config)
APU_CONFIG=$(shell which apu-1-config)

#CFLAGS = $(shell ${APR_CONFIG} --cflags --cppflags --includes) \
#		 $(shell ${APU_CONFIG} --includes) -Wall -g

CFLAGS = -Wall -g

#LDFLAGS=$(shell ${APR_CONFIG} --ldflags) \
#		$(shell ${APU_CONFIG} --ldflags)

#LDLIBS=$(shell ${APR_CONFIG} --libs --link-ld) \
#	   $(shell ${APU_CONFIG} --libs --link-ld)

BIN = t1
BIN2 = t2
PARSER_BIN = parser

.PHONY: run

run: $(BIN2)
	valgrind -q ./$(BIN2)


$(PARSER_BIN): scanner.c utils.o level.o parser-support.o

level.o : utils.h

utils.o : utils.h

parser-support.o : utils.h level.h parser-support.h

scanner.c: scanner.l parser.y level.h utils.h parser-support.h
	bison -d $(PARSER_BIN).y
	flex -o$@ $(subst .c,.l,$@) 


# Main executable
$(BIN): -lzmq

$(BIN2):

clean:
	rm -f $(BIN) $(BIN2)
	rm -f *.o
	rm -f $(PARSER_BIN) $(PARSER_BIN).tab.*
	rm -f scanner.c

