
#include <stdio.h>

int main(void)
{

    int a = 0;
    asm("movl %1,%%eax\n"
        "movl %%eax,%0\n"

        : "=g"(a)
        : "g"(15)
        : "%eax"
        );
    printf("a: %d\n", a);
    return 0;
}