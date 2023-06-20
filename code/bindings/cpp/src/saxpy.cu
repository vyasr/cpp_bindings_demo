#include "saxpy.hpp"

#include <thrust/device_vector.h>
#include <thrust/execution_policy.h>
#include <thrust/transform.h>

void saxpy(float a, thrust::device_vector<float> const& x, thrust::device_vector<float> &y)
{
    thrust::transform(thrust::device, x.begin(), x.end(), y.begin(), y.begin(),
            [a] __device__ (float const x_1, float const y_1) {
            return a * x_1 + y_1;
            });
}
