cmake_minimum_required(VERSION 3.15)
project(${SKBUILD_PROJECT_NAME} LANGUAGES CXX)

find_package(
  Python
  COMPONENTS Interpreter Development.Module
  REQUIRED)

find_program(CYTHON "cython")

find_package(Saxpy REQUIRED)

add_custom_command(
  OUTPUT bindings.cxx
  DEPENDS bindings.pyx
  VERBATIM
  COMMAND "${CYTHON}" "${CMAKE_CURRENT_SOURCE_DIR}/bindings.pyx" --output-file
          "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

python_add_library(bindings MODULE "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

target_link_libraries(bindings PUBLIC saxpy)

set_target_properties(
    bindings
    PROPERTIES
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

install(TARGETS bindings DESTINATION pysaxpy)
