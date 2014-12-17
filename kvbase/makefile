CC = g++
CFLAGS = -std=c++11 -c -Wall -DDEBUG -g
LDFLAGS =

COMMON_SOURCES = kvserver.cpp
TARGET_SOURCES = kvbase.cpp

COMMON_OBJECTS = $(COMMON_SOURCES:.cpp=.o)
TARGET_OBJECTS = $(TARGET_SOURCES:.cpp=.o)

EXECUTABLE = kvexplore

all: target

target: $(EXECUTABLE)

$(EXECUTABLE): $(COMMON_OBJECTS) $(TARGET_OBJECTS)
	$(CC) $(LDFLAGS) $^ -o $@

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@
 
clean:
	rm -f $(EXECUTABLE) *.o
