#include <stdio.h>

int main(void)
{

    int a = 0;
    int b = 0;
    int c = 0;

    asm("movl %1,%0\n"
        : "=g"(a)
        : "g"(1)
        : //! no hay colores
    );
};