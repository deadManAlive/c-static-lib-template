#include "stuff.h"

void flip(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}
