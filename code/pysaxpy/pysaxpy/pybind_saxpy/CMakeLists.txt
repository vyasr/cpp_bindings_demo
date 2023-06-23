set(PYBIND11_NEWPYTHON ON)
add_subdirectory(extern/pybind11)

# Bindings to built library
pybind11_add_module(cpp_bindings cpp_bindings.cpp)
target_link_libraries(cpp_bindings PUBLIC saxpy::saxpy)
target_include_directories(cpp_bindings PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/extern)

get_install_dir(cpp_bindings_install_dir)
install(TARGETS cpp_bindings DESTINATION ${cpp_bindings_install_dir})

# Bindings to header-only library
find_package(CUDAToolkit REQUIRED)

find_package(Thrust REQUIRED CONFIG HINTS ${CUDAToolkit_LIBRARY_DIR}/cmake/thrust)
thrust_create_target(Thrust)

# TODO: Figure out how to get CMake to compile this correctly
#pybind11_add_module(cpp_bindings_header_only cpp_bindings_header_only.cu)
#target_link_libraries(cpp_bindings_header_only PUBLIC saxpy_header_only::saxpy_header_only)
#target_include_directories(cpp_bindings_header_only PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/extern)
#set_target_properties(cpp_bindings_header_only PROPERTIES LANGUAGE CUDA LINKER_LANGUAGE CUDA)
#
#get_install_dir(cpp_bindings_header_only_install_dir)
#install(TARGETS cpp_bindings_header_only DESTINATION ${cpp_bindings_header_only_install_dir})
#
#target_link_libraries(cpp_bindings_header_only PRIVATE Thrust CUDA::cudart)
