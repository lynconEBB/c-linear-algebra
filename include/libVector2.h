#ifndef VECTOR_2_LIB

#define VECTOR_2_LIB
#include <stddef.h>

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