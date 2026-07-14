cmake_minimum_required(VERSION 3.17)
project(test_spirv_tools_package NONE)

find_package(SPIRV-Tools CONFIG REQUIRED)
find_package(SPIRV-Tools-opt CONFIG REQUIRED)

if(NOT TARGET SPIRV-Tools)
  message(FATAL_ERROR "The SPIRV-Tools package does not export the SPIRV-Tools target")
endif()

if(NOT TARGET SPIRV-Tools-opt)
  message(FATAL_ERROR "The SPIRV-Tools-opt package does not export the SPIRV-Tools-opt target")
endif()
