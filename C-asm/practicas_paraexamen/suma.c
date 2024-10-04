#include <stdio.h>


int main() {

    int a= 10, b = 5;

    asm("addl %1, %0"
        : "=r" (a)
        : "r" (b), "0"(a)
        :
    );
    printf("La suma de a y b es: %d\n", a);
    return 0;
}