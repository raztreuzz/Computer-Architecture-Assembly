#include <stdio.h>

int main() {
    int a = 10;

    asm("decl %0"
        : "=g" (a)
        : "0" (a));
        
    printf("Decrementando: %d\n", a);
    return 0;
}