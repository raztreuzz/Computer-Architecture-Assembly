#include <stdio.h>

int main() {

    int a = 10, b =4;

    asm("imull %1, %0"
        : "=r" (a)
        : "r" (b), "0"(a)
        :
    );
    printf("La multiplicación de a y b es: %d\n", a);
}