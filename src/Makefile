CC=dmd
CFLAGS=-O 
TARGET=ASIC_Netlist_Parser

#INC = -Ipath ../inc

OBJS = 	parser.o \
	design.o \
	abstractDesignObject.o \
	designObject.o \
	main.o

%.o: %.d
	$(CC) $(INC) $(CFLAGS) -c $<

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(INC) $(CFLAGS) -of$@ $^

clean:
	rm -f *.o $(TARGET) *~
test:
	./$(TARGET) ../data/counter.v
