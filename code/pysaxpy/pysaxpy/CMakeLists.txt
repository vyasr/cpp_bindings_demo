add_custom_command(
  OUTPUT pysaxpy.cxx
  DEPENDS pysaxpy.pyx
  VERBATIM
  COMMAND "${CYTHON}" "${CMAKE_CURRENT_SOURCE_DIR}/pysaxpy.pyx" --output-file
          "${CMAKE_CURRENT_BINARY_DIR}/pysaxpy.cxx")

python_add_library(pysaxpy MODULE "${CMAKE_CURRENT_BINARY_DIR}/pysaxpy.cxx")

target_link_libraries(pysaxpy PUBLIC saxpy::saxpy)

set_target_properties(
    pysaxpy
    PROPERTIES
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
    POSITION_INDEPENDENT_CODE ON
    INTERFACE_POSITION_INDEPENDENT_CODE ON
)

install(TARGETS pysaxpy DESTINATION pysaxpy)
