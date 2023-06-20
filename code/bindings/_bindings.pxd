cdef extern from "saxpy.hpp" nogil:
    cdef void saxpy(
        float a,
        const float* x_begin,
        const float* x_end,
        const float* y_begin,
        float* output_begin
    )
