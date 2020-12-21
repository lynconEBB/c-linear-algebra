CC=clang
LIB_NAME=LinAlg
INCLUDE_DIR=./libs/include/
INCLUDE_FLAG=-I $(INCLUDE_DIR)
SHARED_FLAGS=-shared
CC_FLAGS=-c -Wall $(INCLUDE_FLAG)

CC_SOURCE=$(wildcard ./src/*.c)
CC_LIBS_SOURCE=$(wildcard ./libs/src/*.c)

LIBS_SOURCE_DIR=./libs/src/
STATIC_LIBS_DIR=./libs/static/
SHARED_LIBS_DIR=./libs/shared/
LIBS_OBJ_DIR=./libs/objects/
OBJ_DIR=./objects/
SOURCE_DIR=./src/

SHARED_LIBS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(SHARED_LIBS_DIR)%.dll, $(CC_LIBS_SOURCE))
LIB_OBJECTS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(LIBS_OBJ_DIR)%.o, $(CC_LIBS_SOURCE))
SOURCE_OBJECTS:=$(patsubst $(SOURCE_DIR)%.c, $(OBJ_DIR)%.o, $(CC_SOURCE))

.PHONY: static exec_static shared exec_shared

static: $(STATIC_LIBS_DIR)lib$(LIB_NAME).a

exec_static: $(SOURCE_OBJECTS) $(STATIC_LIBS_DIR)lib$(LIB_NAME).a 
	$(CC) $(SOURCE_OBJECTS) -L$(STATIC_LIBS_DIR) -l$(LIB_NAME) -o main
	./main

shared: $(SHARED_LIBS_DIR)lib$(LIB_NAME).so

exec_shared: $(SOURCE_OBJECTS) $(SHARED_LIBS_DIR)lib$(LIB_NAME).so 
	$(CC) $(SOURCE_OBJECTS) -L$(SHARED_LIBS_DIR) -Wl,-rpath=/home/lasse/Dev/c-linear-algebra/libs/shared -l$(LIB_NAME) -o main
	./main

#Rule to create .so using objects from libs/objects
$(SHARED_LIBS_DIR)lib$(LIB_NAME).so : $(LIB_OBJECTS) $(SHARED_LIBS_DIR)
	clang $(LIB_OBJECTS) $(SHARED_FLAGS) -o $@

#Rule to create .a from .o inside libs objects folder
$(STATIC_LIBS_DIR)lib$(LIB_NAME).a : $(LIB_OBJECTS) $(STATIC_LIBS_DIR)
	ar rcs $@ $(LIB_OBJECTS)

#Rule to create .o from .c inside libs source folder
$(LIBS_OBJ_DIR)%.o : $(LIBS_SOURCE_DIR)%.c $(LIBS_OBJ_DIR)
	$(CC) $< $(CC_FLAGS) -fPIC -o $@

#Rule to create .o from .c inside main source folder
$(OBJ_DIR)%.o: $(SOURCE_DIR)%.c $(OBJ_DIR)
	$(CC) $< $(CC_FLAGS) -o $@

clean: 
	rm -rf $(STATIC_LIBS_DIR) $(SHARED_LIBS_DIR) $(OBJ_DIR) $(LIBS_OBJ_DIR)
	rm -f main

$(LIBS_OBJ_DIR):
	mkdir $(LIBS_OBJ_DIR)

$(OBJ_DIR):
	mkdir $(OBJ_DIR)

$(SHARED_LIBS_DIR):
	mkdir $(SHARED_LIBS_DIR)
	
$(STATIC_LIBS_DIR):
	mkdir $(STATIC_LIBS_DIR)