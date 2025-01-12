#include <stdio.h>
#include <omp.h>

#define SIZE 1000

int main() {
    int array[SIZE], max_serial = -1, max_parallel = -1;

    // Initialize the array
    for (int i = 0; i < SIZE; i++) {
        array[i] = rand() % 10000;
    }

    // Serial computation
    for (int i = 0; i < SIZE; i++) {
        if (array[i] > max_serial) {
            max_serial = array[i];
        }
    }

    // Parallel computation
    #pragma omp parallel for
    for (int i = 0; i < SIZE; i++) {
        #pragma omp critical
        if (array[i] > max_parallel) {
            max_parallel = array[i];
        }
    }

    // Verify results
    printf("Max (Serial): %d\n", max_serial);
    printf("Max (Parallel): %d\n", max_parallel);
    printf("%s\n", (max_serial == max_parallel) ? "Results Match!" : "Mismatch!");

    return 0;
}
