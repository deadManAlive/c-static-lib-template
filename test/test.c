#include <stdio.h>
#include <assert.h>

#include <stuff.h>

int main(void) {
    int x = 19;
    int y = 45;

    flip(&x, &y);

    assert(x == 45);
    assert(y == 19);

    return 0;
}
