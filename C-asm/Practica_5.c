#include <stdio.h>

int main() {
    int num1, num2, resultado, opcion;
    char continuar = 's';

    while (continuar == 's' || continuar == 'S') {
        // Solicitar los dos números enteros
        printf("Ingrese el primer número (entero con signo): ");
        scanf("%d", &num1);
        printf("Ingrese el segundo número (entero con signo): ");
        scanf("%d", &num2);

        // Menú para seleccionar la operación
        printf("Seleccione la operación a realizar:\n");
        printf("1. Suma\n");
        printf("2. Resta\n");
        printf("3. Multiplicación\n");
        printf("4. División\n");
        printf("Opción: ");
        scanf("%d", &opcion);

        // Realizar la operación seleccionada en ensamblador
        switch (opcion) {
            case 1: // Suma
                __asm__ (
                    "movl %1, %%eax;" // Mover num1 a eax
                    "movl %2, %%ebx;" // Mover num2 a ebx
                    "addl %%ebx, %%eax;" // Sumar eax y ebx
                    "movl %%eax, %0;" // Mover el resultado a la variable resultado
                    : "=r" (resultado) // Salida
                    : "r" (num1), "r" (num2) // Entradas
                    : "%eax", "%ebx" // Registros modificados
                );
                printf("Resultado de la suma: %d\n", resultado);
                break;

            case 2: // Resta
                __asm__ (
                    "movl %1, %%eax;" // Mover num1 a eax
                    "movl %2, %%ebx;" // Mover num2 a ebx
                    "subl %%ebx, %%eax;" // Restar ebx de eax
                    "movl %%eax, %0;" // Mover el resultado a la variable resultado
                    : "=r" (resultado)
                    : "r" (num1), "r" (num2)
                    : "%eax", "%ebx"
                );
                printf("Resultado de la resta: %d\n", resultado);
                break;

            case 3: // Multiplicación
                __asm__ (
                    "movl %1, %%eax;" // Mover num1 a eax
                    "movl %2, %%ebx;" // Mover num2 a ebx
                    "imull %%ebx, %%eax;" // Multiplicar eax por ebx
                    "movl %%eax, %0;" // Mover el resultado a la variable resultado
                    : "=r" (resultado)
                    : "r" (num1), "r" (num2)
                    : "%eax", "%ebx"
                );
                printf("Resultado de la multiplicación: %d\n", resultado);
                break;

            case 4: // División
                if (num2 != 0) {
                    __asm__ (
                        "movl %1, %%eax;" // Mover num1 a eax
                        "movl %2, %%ebx;" // Mover num2 a ebx
                        "cltd;" // Extender el signo de eax a edx:eax
                        "idivl %%ebx;" // Dividir edx:eax por ebx
                        "movl %%eax, %0;" // Mover el cociente a resultado
                        : "=r" (resultado)
                        : "r" (num1), "r" (num2)
                        : "%eax", "%ebx", "%edx"
                    );
                    printf("Resultado de la división: %d\n", resultado);
                } else {
                    printf("Error: No se puede dividir por cero.\n");
                }
                break;

            default:
                printf("Opción inválida.\n");
                break;
        }

        // Preguntar si desea realizar otra operación
        printf("¿Desea realizar otra operación? (s/n): ");
        scanf(" %c", &continuar); // Espacio antes de %c para evitar problemas con el buffer
    }

    printf("Saliendo del programa...\n");
    return 0;
}
