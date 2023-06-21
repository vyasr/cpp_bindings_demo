add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../cpp" "${CMAKE_CURRENT_BINARY_DIR}/cpp")

add_custom_command(
  OUTPUT bindings.cxx
  DEPENDS bindings.pyx
  VERBATIM
  COMMAND "${CYTHON}" "${CMAKE_CURRENT_SOURCE_DIR}/bindings.pyx" --output-file
          "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

python_add_library(pysaxpy MODULE "${CMAKE_CURRENT_BINARY_DIR}/bindings.cxx")

target_link_libraries(pysaxpy PUBLIC saxpy)

set_target_properties(
    pysaxpy
    PROPERTIES
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

install(TARGETS saxpy DESTINATION pysaxpy)
install(TARGETS pysaxpy DESTINATION pysaxpy)
