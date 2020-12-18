#ifndef VECTOR_LIB

#define VECTOR_LIB
#include <stddef.h>

int vectorFun();

typedef enum VectorSize {
    TOW = 2,
    THREE = 3,
    FOUR = 4
} VectorSize;

typedef struct Vector
{
    VectorSize size;
    double *values;
} Vector;

#endif