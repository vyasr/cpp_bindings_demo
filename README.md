# About

This repo contains an example of how to create Python bindings for a C++ library.
The Python package is contained in the `code/` directory, with the C++ library nested in `code/bindings/cpp`.
The package is built using scikit-build-score to stitch together Python and CMake for the build.
The C++ library implements saxpy (scalar multiplication followed by vector addition) using [Thrust](https://docs.nvidia.com/cuda/thrust/index.html).
The Python package exposes a simple binding that allows saxpy to be called on a pair of [CuPy](https://cupy.dev/) arrays.

This repo contains a docker-compose configuration and a Dockerfile that can be used to build the necessary container.
It also contains a pair of (shell and Python) scripts that may be used to run the example.
Assuming docker-compose is installed, the example may be run as follows:

```bash
docker-compose build
docker-compose run cpp_bindings_demo

# Inside the container:
./demo.sh
```
