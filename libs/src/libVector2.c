#include "libVector2.h"
#include <stddef.h>
#include <stdlib.h>

Vector* alloc(VectorSize size) {
    Vector newVector;
    Vector* vector = &newVector;
    vector->size = size;
    vector->values = malloc(size * sizeof(double));
    return vector;
}

void set(Vector* vector, size_t axis, double value){}

void scale(Vector* vector, double scalar) {}

void multiply( Vector* vectorA, Vector* vectorB) {}