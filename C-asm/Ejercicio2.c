#include <stdio.h>

int main(void){

    int a = 0;
    asm("movl %[valor],%[variable]\n"
        : [variable] "=g"(a)    
        : [valor] "g"(7)
        :
        );

    printf("a: %d\n", a);
    return 0;
}