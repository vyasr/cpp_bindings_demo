set(PYBIND11_NEWPYTHON ON)
add_subdirectory(extern/pybind11)

pybind11_add_module(cpp_bindings cpp_bindings.cpp)
target_link_libraries(cpp_bindings PUBLIC saxpy::saxpy)
target_include_directories(cpp_bindings PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/extern)

get_install_dir(cpp_bindings_install_dir)
install(TARGETS cpp_bindings DESTINATION ${cpp_bindings_install_dir})
