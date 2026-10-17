cmake_minimum_required(VERSION 3.17)
project(test_spirv_tools_internal_package LANGUAGES CXX)

find_package(SPIRV-Tools-opt CONFIG REQUIRED)
find_path(SPIRV_TOOLS_PRIVATE_INCLUDE_DIR source/opt/build_module.h
  PATH_SUFFIXES spirv-tools-private REQUIRED)

add_executable(test-spirv-tools-internal main.cpp)
target_compile_features(test-spirv-tools-internal PRIVATE cxx_std_17)
target_include_directories(test-spirv-tools-internal PRIVATE ${SPIRV_TOOLS_PRIVATE_INCLUDE_DIR})
target_link_libraries(test-spirv-tools-internal PRIVATE SPIRV-Tools-opt)
