CFLAGS = -Wall -g
BIN = t1

.PHONY: run

run: $(BIN)
	valgrind -q ./$(BIN)

# Main executable
$(BIN): -lzmq

clean:
	rm -f $(BIN)
	rm -f *.o

