import pysaxpy
import cupy

x = cupy.array([1, 2, 3])
y = cupy.array([4, 5, 6])
pysaxpy.cython_saxpy.saxpy(10, x, y)

print(y)

x = cupy.array([1, 2, 3])
y = cupy.array([4, 5, 6])
pysaxpy.pybind_saxpy.saxpy(10, x, y)

print(y)
