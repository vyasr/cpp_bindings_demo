#include "saxpy.hpp"

#include <thrust/device_vector.h>
#include <thrust/host_vector.h>
#include <thrust/sequence.h>
#include <thrust/execution_policy.h>

#include <iostream>

int main() {
    int const n = 10;
    int const a = 10;
    thrust::device_vector<float> x(n);
    thrust::device_vector<float> y(n);
    thrust::sequence(thrust::device, x.begin(), x.end(), 0);
    thrust::sequence(thrust::device, y.begin(), y.end(), 1);

    saxpy(a, x.data().get(), x.data().get() + x.size(), y.data().get(), y.data().get());

    thrust::host_vector<float> out = y;
    for (float const i: out) {
        std::cout << i << ' ';
    }
    std::cout << std::endl;
}

