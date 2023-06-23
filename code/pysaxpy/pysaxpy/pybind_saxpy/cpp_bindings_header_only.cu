#include <pybind11/pybind11.h>
#include "saxpy_header_only.hpp"

PYBIND11_MODULE(cpp_bindings, m) {
    m.doc() = "pybind11 C++ bindings"; // optional module docstring

    m.def("saxpy_template", [](float a, long x_begin, long x_end, long y_begin, long output_begin){
            saxpy_template(a, reinterpret_cast<float const*>(x_begin), reinterpret_cast<float const*>(x_end), reinterpret_cast<float const*>(y_begin), reinterpret_cast<float *>(output_begin));
            }, "Compute a * x + y");
}
