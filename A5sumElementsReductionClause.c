#include <stdio.h>
#include <omp.h>

int main() {
    int n = 10; // Size of the array
    int a[n], i, sum = 0;

    // Initialize the array
    for (i = 0; i < n; i++) {
        a[i] = i + 1; // Array a: 1, 2, 3, ...
    }

    // Parallel sum using reduction
    #pragma omp parallel for reduction(+:sum)
    for (i = 0; i < n; i++) {
        sum += a[i];
        printf("Thread %d processed a[%d] = %d\n", omp_get_thread_num(), i, a[i]);
    }

    // Print the final sum
    printf("\nSum of array elements: %d\n", sum);

    return 0;
}
