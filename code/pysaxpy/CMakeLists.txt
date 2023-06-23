cmake_minimum_required(VERSION 3.15)
project(${SKBUILD_PROJECT_NAME} LANGUAGES CXX)

find_package(
  Python
  COMPONENTS Interpreter Development.Module
  REQUIRED)

find_package(saxpy 1.0.0 REQUIRED)

find_program(CYTHON "cython")

add_subdirectory(pysaxpy)
