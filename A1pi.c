#include <stdio.h>
#include <omp.h>

int main() {
    int n = 1000000; // Number of iterations
    double pi = 0.0;
    int i;

    // Calculate PI using the Leibniz formula with critical section
    #pragma omp parallel for
    for (i = 0; i < n; i++) {
        double x = ((i % 2 == 0) ? 1.0 : -1.0) / (2 * i + 1);  // Leibniz formula part
        
        #pragma omp critical
        pi += x;  // Critical section to update pi
    }

    pi *= 4; // Final calculation of PI

    // Print the calculated value of PI
    printf("Estimated value of PI: %lf\n", pi);

    return 0;
}
