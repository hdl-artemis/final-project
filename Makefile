CC = iverilog
CFLAGS = -Wall

SRC = main.v

# name of the executable
EXEC = main

# Targets
all: $(EXEC)

$(EXEC): $(SRC)
	$(CC) $(CFLAGS) -o $(EXEC) $(SRC)

run: $(EXEC)
	./$(EXEC)

clean:
	rm -f $(EXEC)
