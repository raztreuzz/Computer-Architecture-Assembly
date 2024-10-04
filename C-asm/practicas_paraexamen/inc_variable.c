#include <stdio.h>

int main()
{
    int a = 5;
    asm("incl %0"
        : "=g"(a)
        : "0"(a));
    printf("Incrementando: %d\n", a);
    return 0;
}