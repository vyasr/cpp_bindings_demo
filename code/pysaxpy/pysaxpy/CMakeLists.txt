add_custom_command(
  OUTPUT bindings.cxx
  DEPENDS bindings.pyx
  VERBATIM
  COMMAND "${CYTHON}" "${CMAKE_CURRENT_SOURCE_DIR}/bindings.pyx" --output-file
          "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

python_add_library(bindings MODULE "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

target_link_libraries(bindings PUBLIC saxpy::saxpy)

set_target_properties(
    bindings
    PROPERTIES
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

install(TARGETS bindings DESTINATION pysaxpy)
