#include <stdio.h>
#include <omp.h>

int main() {
    int num_steps = 1000000; // Number of steps for approximation
    double step = 1.0 / (double)num_steps;
    double pi = 0.0;         // Resultant value of PI
    int i;

    // Start parallel region
    #pragma omp parallel
    {
        double sum = 0.0; // Local sum for each thread

        #pragma omp for
        for (i = 0; i < num_steps; i++) {
            double x = (i + 0.5) * step;
            sum += 4.0 / (1.0 + x * x);
        }

        // Critical section to update the global variable
        #pragma omp critical
        {
            pi += sum;
        }
    }

    // Final calculation of PI
    pi *= step;

    // Print the result
    printf("Calculated value of PI: %.15f\n", pi);

    return 0;
}
