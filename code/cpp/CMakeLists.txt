cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)
set(CMAKE_CUDA_ARCHITECTURES 75)
project(
    SAXPY
    VERSION 1.0.0
    LANGUAGES CXX CUDA
)

add_library(
    saxpy SHARED
    src/saxpy.cu
)

target_include_directories(
    saxpy
    PUBLIC "$<BUILD_INTERFACE:${SAXPY_SOURCE_DIR}/include>"
    INTERFACE "$<INSTALL_INTERFACE:include>"
)

set_target_properties(
    saxpy
    PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS ON
    CUDA_STANDARD 17
    CUDA_STANDARD_REQUIRED ON
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

find_package(CUDAToolkit REQUIRED)

find_package(Thrust REQUIRED CONFIG HINTS ${CUDAToolkit_LIBRARY_DIR}/cmake/thrust)
target_link_libraries(saxpy)

set(SAXPY_CUDA_FLAGS --expt-extended-lambda --expt-relaxed-constexpr)
target_compile_options(
  saxpy PRIVATE "$<$<COMPILE_LANGUAGE:CUDA>:${SAXPY_CUDA_FLAGS}>"
)

export(TARGETS saxpy FILE "${PROJECT_BINARY_DIR}/SaxpyConfig.cmake")

# Install the library and header files
install(TARGETS saxpy
    EXPORT SaxpyTargets
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
)

install(DIRECTORY include/
    DESTINATION include
)

# Install the CMake config file
install(EXPORT SaxpyTargets
    FILE SaxpyConfig.cmake
    DESTINATION lib/cmake/saxpy
)
