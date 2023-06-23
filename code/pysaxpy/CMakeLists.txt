cmake_minimum_required(VERSION 3.15)
project(${SKBUILD_PROJECT_NAME} LANGUAGES CXX)

find_package(
  Python
  COMPONENTS Interpreter Development.Module
  REQUIRED)

find_package(saxpy 1.0.0 REQUIRED)
#find_package(saxpy_header_only 1.0.0 REQUIRED)

find_program(CYTHON "cython")

# Helper function to compute the appropriate install directory for a subpackage.
function(get_install_dir install_dir_var)
    cmake_path(RELATIVE_PATH CMAKE_CURRENT_SOURCE_DIR BASE_DIRECTORY "${PROJECT_SOURCE_DIR}"
        OUTPUT_VARIABLE install_dir)
    set(${install_dir_var} ${install_dir} PARENT_SCOPE)
endfunction()

add_subdirectory(pysaxpy)
