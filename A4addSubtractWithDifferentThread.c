#include <stdio.h>
#include <omp.h>

int main() {
    int n = 10; // Size of the arrays
    int a[n], b[n], sum[n], diff[n];
    int i;

    // Initialize arrays
    for (i = 0; i < n; i++) {
        a[i] = i + 1;       // Array a: 1, 2, 3, ...
        b[i] = (i + 1) * 2; // Array b: 2, 4, 6, ...
    }

    // Parallel sections for addition and subtraction
    #pragma omp parallel sections
    {
        // Section for addition
        #pragma omp section
        {
            for (i = 0; i < n; i++) {
                sum[i] = a[i] + b[i];
                printf("Thread %d computed sum[%d] = %d\n", omp_get_thread_num(), i, sum[i]);
            }
        }

        // Section for subtraction
        #pragma omp section
        {
            for (i = 0; i < n; i++) {
                diff[i] = a[i] - b[i];
                printf("Thread %d computed diff[%d] = %d\n", omp_get_thread_num(), i, diff[i]);
            }
        }
    }

    // Print results
    printf("\nFinal Sum Array:\n");
    for (i = 0; i < n; i++) {
        printf("%d ", sum[i]);
    }

    printf("\n\nFinal Difference Array:\n");
    for (i = 0; i < n; i++) {
        printf("%d ", diff[i]);
    }
    printf("\n");

    return 0;
}
