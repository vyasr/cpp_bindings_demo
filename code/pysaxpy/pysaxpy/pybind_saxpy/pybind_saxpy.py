from . import cpp_bindings
from . import cpp_bindings_header_only


def saxpy(a, x, y):
    # Assume x and y are cupy arrays
    x_begin = x.data.ptr
    x_end = x.data.ptr + x.size * x.dtype.itemsize
    y_begin = y.data.ptr
    output_begin = y.data.ptr

    cpp_bindings.saxpy(a, x_begin, x_end, y_begin, output_begin)

    return y

def saxpy_template(a, x, y):
    # Assume x and y are cupy arrays
    x_begin = x.data.ptr
    x_end = x.data.ptr + x.size * x.dtype.itemsize
    y_begin = y.data.ptr
    output_begin = y.data.ptr

    cpp_bindings_header_only.saxpy_template(a, x_begin, x_end, y_begin, output_begin)

    return y
