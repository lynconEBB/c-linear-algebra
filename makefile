CC=clang
INCLUDE_DIR=./include/
INCLUDE_FLAG=-I $(INCLUDE_DIR)
SHARED_FLAGS=-shared -fpic $(INCLUDE_FLAG)
CC_FLAGS=-c -Wall -fpic $(INCLUDE_FLAG)

CC_SOURCE=$(wildcard ./src/*.c)
CC_LIBS_SOURCE=$(wildcard ./libs/src/*.c)

LIBS_SOURCE_DIR=./libs/src/
STATIC_LIBS_DIR=./libs/static/
SHARED_LIBS_DIR=./libs/shared/
OBJ_DIR=./objects/
SOURCE_DIR=./src/

STATIC_LIBS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(STATIC_LIBS_DIR)%.lib, $(CC_LIBS_SOURCE))
SHARED_LIBS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(SHARED_LIBS_DIR)%.dll, $(CC_LIBS_SOURCE))
LIB_OBJECTS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(OBJ_DIR)%.o, $(CC_LIBS_SOURCE))
SOURCE_OBJECTS:=$(patsubst $(SOURCE_DIR)%.c, $(OBJ_DIR)%.o, $(CC_SOURCE))

.PHONY: static simple build_static

test: $(LIB_OBJECTS)

simple: $(LIB_OBJECTS) $(SOURCE_OBJECTS)
	$(CC) $(INCLUDE_FLAG) $^ -o main
	./main

static: $(STATIC_LIBS)

build_static: $(STATIC_LIBS) $(SOURCE_OBJECTS)
	$(CC) $(INCLUDE_FLAG) $^ -o main

#Rule to create .lib from .c inside libs source folder
$(STATIC_LIBS_DIR)%.lib : $(LIBS_SOURCE_DIR)%.c $(STATIC_LIBS_DIR)
	$(CC) $(CC_FLAGS) $^ -o $@

#Rule to create .o from .c inside libs source folder
$(OBJ_DIR)%.o : $(LIBS_SOURCE_DIR)%.c $(OBJ_DIR)
	$(CC) $(CC_FLAGS) $^ -o $@

#Rule to create .o from .c inside main source folder
$(OBJ_DIR)%.o: $(SOURCE_DIR)%.c $(OBJ_DIR)
	$(CC) $(CC_FLAGS) $^ -o $@

clean: 
	rm -rf $(STATIC_LIBS_DIR) $(SHARED_LIBS_DIR) $(OBJ_DIR)
	rm -f main

$(OBJ_DIR):
	mkdir $(OBJ_DIR)

$(SHARED_LIBS_DIR):
	mkdir $(SHARED_LIBS_DIR)
	
$(STATIC_LIBS_DIR):
	mkdir $(STATIC_LIBS_DIR)