#include  <string.h>
#include  <stdio.h>


int main(void)
{

    int a = 0;
    asm("movl%1,%0\n"

        : "=g"(a)
        : "g"(10)
        :);
    printf("a = %d\n", a);
    return 0;
}