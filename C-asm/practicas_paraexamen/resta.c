#include <stdio.h>

int main() {
    int a = 10, b = 5;

    asm("subl %1, %0"
        : "=r" (a)
        : "r" (b), "0"(a)
        :
    );
    printf("La resta de a y b es: %d\n", a);
}
