#include <stdio.h>

int main() {
    int notas[] = {25, 30, 56, 60, 70};
    int alumnos = sizeof(notas) / sizeof(notas[0]);
    int suma = 0, promedio = 0, i = 0;

    // Calcular la suma de las notas
    for (i = 0; i < alumnos; i++) {
        asm volatile(
            "addl %1, %0"
            : "=g"(suma)          // Salida
            : "g"(notas[i]), "0"(suma) // Entrada
        );
    }

    // Calcular el promedio
    asm volatile(
        "movl %1, %%eax \n\t"  // Mover suma a eax
        "cltd \n\t"            // Extender eax a edx:eax
        "idivl %2"             // Dividir edx:eax por alumnos
        : "=a"(promedio)       // Guardar el resultado en promedio
        : "r"(suma), "r"(alumnos) // Entradas
        : "%edx"               // %edx se modifica
    );

    printf("El promedio es: %d\n", promedio);

    // Comparar notas con el promedio
    for (i = 0; i < alumnos; i++) {
        int mayorpromedio;

        asm volatile(
            "movl %1, %%eax \n\t"  // Mover nota a eax
            "cmpl %2, %%eax \n\t"  // Comparar con el promedio
            "setg %%al \n\t"       // Establecer al en 1 si eax > promedio
            "movzbl %%al, %0"      // Mover el resultado a mayorpromedio
            : "=r"(mayorpromedio)  // Salida
            : "r"(notas[i]), "r"(promedio) // Entradas
            : "%eax"               // %eax se modifica
        );

        if (mayorpromedio) {
            printf("El alumno %d es mayor al promedio.\n", i + 1);
        }
    }

    return 0;
}


