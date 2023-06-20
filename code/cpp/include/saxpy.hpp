#include <thrust/device_vector.h>

void saxpy(float a, thrust::device_vector<float> const& x, thrust::device_vector<float> &y);
