#include <stdio.h>

int main() {
    int a = 10, b = 5,resultado = 0;

        __asm__ (
                        "movl %1, %%eax;" // Mover num1 a eax
                        "movl %2, %%ebx;" // Mover num2 a ebx
                        "cltd;" // Extender el signo de eax a edx:eax
                        "idivl %%ebx;" // Dividir edx:eax por ebx
                        "movl %%eax, %0;" // Mover el cociente a resultado
                        : "=r" (resultado)
                        : "r" (a), "r" (b)
                        : "%eax", "%ebx", "%edx"
                    );
                    printf("Resultado de la división: %d\n", resultado);


    return 0;
}