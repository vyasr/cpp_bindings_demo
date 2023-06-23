#include <thrust/execution_policy.h>
#include <thrust/transform.h>

template <typename T>
struct SaxpyFunctor {
    SaxpyFunctor(T const a) : a(a) {}
    __device__ T operator()(const T x, const T y) const {
        return a * x + y;
    }

    T const a;
};

template <typename Scalar, typename InputIterator, typename OutputIterator>
void saxpy_template(Scalar a, InputIterator x_begin, InputIterator x_end, InputIterator y_begin, OutputIterator output_begin) {
    thrust::transform(thrust::device, x_begin, x_end, y_begin, output_begin, SaxpyFunctor{a});
}
