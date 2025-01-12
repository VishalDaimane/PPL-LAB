#include <stdio.h>
#include <omp.h>

int main() {
    int n = 10; // Size of the arrays
    int a[n], b[n], c[n];
    int i, chunk = 2; // Chunk size for dynamic scheduling

    // Initialize arrays
    for (i = 0; i < n; i++) {
        a[i] = i + 1;
        b[i] = (i + 1) * 2;
    }

    // Parallel addition of arrays
    #pragma omp parallel for schedule(dynamic, chunk)
    for (i = 0; i < n; i++) {
        c[i] = a[i] + b[i];
        printf("Thread %d computed c[%d] = %d\n", omp_get_thread_num(), i, c[i]);
    }

    // Print result
    printf("\nFinal array C:\n");
    for (i = 0; i < n; i++) {
        printf("%d ", c[i]);
    }
    printf("\n");

    return 0;
}
