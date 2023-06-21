from . cimport _bindings
from libc.stdint cimport uintptr_t

def saxpy(a, x, y):
    # Assume x and y are cupy arrays
    cdef const float * x_begin = <const float *> <uintptr_t> x.data.ptr
    cdef const float * x_end = <const float *> <uintptr_t> (x.data.ptr + x.size * x.dtype.itemsize)
    cdef const float * y_begin = <const float *> <uintptr_t> y.data.ptr
    cdef float * output_begin = <float *> <uintptr_t> y.data.ptr

    _bindings.saxpy(a, x_begin, x_end, y_begin, output_begin)

    return y
