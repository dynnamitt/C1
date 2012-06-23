
APR_CONFIG=$(shell which apr-1-config)
APU_CONFIG=$(shell which apu-1-config)

CFLAGS = $(shell ${APR_CONFIG} --cflags --cppflags --includes) \
		 $(shell ${APU_CONFIG} --includes) -Wall -g

LDFLAGS=$(shell ${APR_CONFIG} --ldflags) \
		$(shell ${APU_CONFIG} --ldflags)

LDLIBS=$(shell ${APR_CONFIG} --libs --link-ld) \
	   $(shell ${APU_CONFIG} --libs --link-ld)

BIN = t1
BIN2 = t2

.PHONY: run

run: $(BIN2)
	valgrind -q ./$(BIN2)

# Main executable
$(BIN): -lzmq

$(BIN2):

clean:
	rm -f $(BIN)
	rm -f *.o

