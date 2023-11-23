cmake_minimum_required(VERSION 3.26)
project(CppLib)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_STATIC_LIBRARY_PREFIX "")

set(LIB_INCLUDE_TXT_FILE ${CMAKE_SOURCE_DIR}/output_file.txt)

# save compiler std::err log to a file, this will be used later for us to find all include files that we will move to the xcframework
set(CMAKE_CXX_COMPILER_LAUNCHER 2> ${LIB_INCLUDE_TXT_FILE})
set(CMAKE_C_COMPILER_LAUNCHER 2> ${LIB_INCLUDE_TXT_FILE})

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
        -DLIB_INCLUDE_FILE_TXT_FILE=${LIB_INCLUDE_TXT_FILE}

        # define script file to call
        -P ${CMAKE_SOURCE_DIR}/cmake/generate_xcframework.cmake
)

# print out include files used by the compiler
target_compile_options(${PROJECT_NAME} PUBLIC -H)
