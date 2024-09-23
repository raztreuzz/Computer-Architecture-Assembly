#include <stdio.h>

int main(void)
{

    int a = 0;  // Declaración de variables en C
    int b = 0;
    int c = 0;
    int d = 0;
    int e = 0;

    asm("mov %5, %0\n"
        "mov %6, %1\n"
        "mov %7, %2\n"
        "mov %8, %3\n"
        "mov %9, %4\n"

        : "=g"(a), "=g"(b), "=g"(c), "=g"(d), "=g"(e)
        : "g"(1), "g"(2), "g"(3), "g"(4), "g"(5)
        :);

    printf("a: %d\n", a);
    printf("b: %d\n", b);
    printf("c: %d\n", c);
    printf("d: %d\n", d);
    printf("e: %d\n", e);

    return 0;
}