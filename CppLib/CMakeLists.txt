cmake_minimum_required(VERSION 3.26)
project(CppLib)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_STATIC_LIBRARY_PREFIX "")

add_library(${PROJECT_NAME} CppLib.cpp)

target_include_directories(${PROJECT_NAME} PUBLIC
        include
)

# run cmake function after build
add_custom_command(TARGET ${PROJECT_NAME}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND}

        # define things we will pass into the cmake script
        -DLIB_PROJECT_NAME=${PROJECT_NAME}
        -DLIB_PROJECT_DIR=${PROJECT_SOURCE_DIR}
        -DLIB_BINARY_DIR=${CMAKE_CURRENT_BINARY_DIR}

        # define script file to call
        -P ${CMAKE_SOURCE_DIR}/cmake/generate_xcframework.cmake
)
