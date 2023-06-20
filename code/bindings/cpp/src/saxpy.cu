#include "saxpy.hpp"

#include <thrust/execution_policy.h>
#include <thrust/transform.h>

void saxpy(float a, float const* x_begin, float const* x_end, float const* y_begin, float * output_begin) {
    thrust::transform(thrust::device, x_begin, x_end, y_begin, output_begin,
            [a] __device__ (float const x_1, float const y_1) {
            return a * x_1 + y_1;
            });
}
