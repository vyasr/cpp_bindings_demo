add_custom_command(
  OUTPUT cython_saxpy.cxx
  DEPENDS cython_saxpy.pyx
  VERBATIM
  COMMAND "${CYTHON}" "${CMAKE_CURRENT_SOURCE_DIR}/cython_saxpy.pyx" --output-file
          "${CMAKE_CURRENT_BINARY_DIR}/cython_saxpy.cxx")

python_add_library(cython_saxpy MODULE "${CMAKE_CURRENT_BINARY_DIR}/cython_saxpy.cxx")

target_link_libraries(cython_saxpy PUBLIC saxpy::saxpy)

set_target_properties(
    cython_saxpy
    PROPERTIES
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

get_install_dir(cython_saxpy_install_dir)
install(TARGETS cython_saxpy DESTINATION ${cython_saxpy_install_dir})
