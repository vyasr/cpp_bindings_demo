#include <pybind11/pybind11.h>
#include "saxpy.hpp"

PYBIND11_MODULE(cpp_bindings, m) {
    m.doc() = "pybind11 C++ bindings"; // optional module docstring

    m.def("saxpy", &saxpy, "Compute a * x + y");
}
