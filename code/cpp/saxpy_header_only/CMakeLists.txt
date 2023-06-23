cmake_minimum_required(VERSION 3.15.0 FATAL_ERROR)
# TODO: This won't work on an arbitrary system
set(CMAKE_CUDA_ARCHITECTURES 75)
set(version 1.0.0)
project(
    SAXPY_HEADER_ONLY
    VERSION ${version}
    LANGUAGES CXX CUDA
)

# Handle dependencies
find_package(CUDAToolkit REQUIRED)

find_package(Thrust REQUIRED CONFIG HINTS ${CUDAToolkit_LIBRARY_DIR}/cmake/thrust)
thrust_create_target(Thrust)

# Create the header-only saxpy library
add_library(saxpy_header_only INTERFACE)

target_include_directories(
    saxpy_header_only
    INTERFACE "$<INSTALL_INTERFACE:include>"
              "$<BUILD_INTERFACE:${SAXPY_SOURCE_DIR}/include>"
)

set_target_properties(
    saxpy_header_only
    PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS ON
    CUDA_STANDARD 17
    CUDA_STANDARD_REQUIRED ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

target_link_libraries(saxpy_header_only INTERFACE Thrust)

set(SAXPY_CUDA_FLAGS --expt-extended-lambda --expt-relaxed-constexpr)
target_compile_options(
    saxpy_header_only INTERFACE "$<$<COMPILE_LANGUAGE:CUDA>:${SAXPY_CUDA_FLAGS}>"
)

# Set up installation of the header-only target
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

install(TARGETS saxpy_header_only
    EXPORT saxpy-header-only-targets
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/
    DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(EXPORT saxpy-header-only-targets
    FILE saxpy-header-only-targets.cmake
    NAMESPACE saxpy_header_only::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy_header_only
)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/cmake/config-header-only.cmake.in
  "${CMAKE_CURRENT_BINARY_DIR}/saxpy-header-only-config.cmake"
  INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy_header_only
)

set_property(TARGET saxpy_header_only PROPERTY VERSION ${version})
set_property(TARGET saxpy_header_only PROPERTY SOVERSION ${MAJOR_VERSION})
set_property(TARGET saxpy_header_only PROPERTY INTERFACE_saxpy_header_only_MAJOR_VERSION ${MAJOR_VERSION})
set_property(TARGET saxpy_header_only APPEND PROPERTY
  COMPATIBLE_INTERFACE_STRING saxpy_header_only_MAJOR_VERSION
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/saxpy-header-only-config-version.cmake"
  VERSION "${version}"
  COMPATIBILITY AnyNewerVersion
)

install(FILES
        "${CMAKE_CURRENT_BINARY_DIR}/saxpy-header-only-config.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/saxpy-header-only-config-version.cmake"
        DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/saxpy_header_only
)
