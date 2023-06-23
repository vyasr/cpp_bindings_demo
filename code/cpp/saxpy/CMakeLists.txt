cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)
# TODO: This won't work on an arbitrary system
set(CMAKE_CUDA_ARCHITECTURES 75)
set(version 1.0.0)
project(
    SAXPY
    VERSION ${version}
    LANGUAGES CXX CUDA
)

# Handle dependencies
find_package(CUDAToolkit REQUIRED)

find_package(Thrust REQUIRED CONFIG HINTS ${CUDAToolkit_LIBRARY_DIR}/cmake/thrust)
thrust_create_target(Thrust)

# Create the saxpy library defining the float-only function
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

target_link_libraries(saxpy PRIVATE Thrust::Thrust)

set(SAXPY_CUDA_FLAGS --expt-extended-lambda --expt-relaxed-constexpr)
target_compile_options(
    saxpy PRIVATE "$<$<COMPILE_LANGUAGE:CUDA>:${SAXPY_CUDA_FLAGS}>"
)

# Set up installation of the saxpy target
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(TARGETS saxpy
    EXPORT saxpy-targets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT saxpy-targets
    FILE saxpy-targets.cmake
    NAMESPACE saxpy::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy
)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/saxpy-config.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy
)

set_property(TARGET saxpy PROPERTY VERSION ${version})
string(REPLACE "." ";" VERSION_LIST "${version}")
list(GET VERSION_LIST 0 MAJOR_VERSION)
set_property(TARGET saxpy PROPERTY SOVERSION ${MAJOR_VERSION})
set_property(TARGET saxpy PROPERTY INTERFACE_saxpy_MAJOR_VERSION ${MAJOR_VERSION})
set_property(TARGET saxpy APPEND PROPERTY
  COMPATIBLE_INTERFACE_STRING saxpy_MAJOR_VERSION
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/saxpy-config-version.cmake"
  VERSION "${version}"
  COMPATIBILITY AnyNewerVersion
)

install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/saxpy-config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/saxpy-config-version.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy
)

# Export for the build dir
export(TARGETS saxpy FILE "${PROJECT_BINARY_DIR}/saxpy-targets.cmake")

# Build the C++ example
option(BUILD_EXAMPLE "Build the C++ sample" OFF)
if(BUILD_EXAMPLE)
    add_executable(
        example
        src/main.cu
    )

    target_include_directories(
        example
        PUBLIC "$<BUILD_INTERFACE:${SAXPY_SOURCE_DIR}/include>"
        INTERFACE "$<INSTALL_INTERFACE:include>"
    )
    target_link_libraries(example PRIVATE Thrust::Thrust saxpy)
endif()
