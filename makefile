PROJ_NAME= linalg
CC=clang
INCLUDE_DIR=./include/
CC_FLAGS=-c -Wall -I $(INCLUDE_DIR)
CC_SOURCE=$(wildcard ./src/*.c)
CC_LIBS_SOURCE=$(wildcard ./libs/src/*.c)
LIBS_SOURCE_DIR=./libs/src/
STATIC_LIBS_DIR=./libs/static/

STATIC_LIBS:=$(patsubst $(LIBS_SOURCE_DIR)%.c, $(STATIC_LIBS_DIR)%.lib, $(CC_LIBS_SOURCE))

.PHONY: all

all: $(STATIC_LIBS)

$(STATIC_LIBS_DIR)%.lib : $(LIBS_SOURCE_DIR)%.c
	$(CC) $(CC_FLAGS) $^ -o $@

