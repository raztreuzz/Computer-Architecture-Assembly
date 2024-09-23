
#include <stdio.h>

int main(void) {
    int a = 0;
    int b = 0;
    int c = 0;
    int d = 0;
    int e = 0;

    asm("movl %[valora],%[a]\n"
        "movl %[valorb],%[b]\n"
        "movl %[valorc],%[c]\n"
        "movl %[valord],%[d]\n"
        "movl %[valore],%[e]\n"
        : [a] "=g"(a), [b] "=g"(b), [c] "=g"(c), [d] "=g"(d), [e] "=g"(e)
        : [valora] "g"(1), [valorb] "g"(2), [valorc] "g"(3), [valord] "g"(4), [valore] "g"(5)
        :
        
    );
    printf("a: %d\n", a);
    printf("b: %d\n", b);
    printf("c: %d\n", c);
    printf("d: %d\n", d);
    printf("e: %d\n", e);

    return 0;


}