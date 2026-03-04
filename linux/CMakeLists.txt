cmake_minimum_required(VERSION 3.20)
project(sigmaker_linux LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_definitions(
        _LIBCPP_ENABLE_CXX20_REMOVED_TYPE_TRAITS
        _LIBCPP_ENABLE_CXX17_REMOVED_FEATURES
        __LINUX__
        __IDP__
        __EA64__=1
)

add_compile_options(
        -Wno-deprecated-declarations
        -Wno-invalid-offsetof
        -D_LIBCPP_DISABLE_DEPRECATION_WARNINGS
)


set(IDA_SDK_PATH "$ENV{HOME}/Desktop/idasdk91")
if(NOT EXISTS "${IDA_SDK_PATH}/include/ida.hpp")
    message(FATAL_ERROR "IDA SDK not found at ${IDA_SDK_PATH}.")
endif()


file(GLOB sources "src/*.cpp")


add_library(sigmaker_linux SHARED ${sources}
        src/sdk_compat.hpp)

target_include_directories(sigmaker_linux PRIVATE
        "${IDA_SDK_PATH}/include"
        "${IDA_SDK_PATH}/include/pro"
)

target_compile_options(sigmaker_linux PRIVATE
        -fPIC
        -Wno-nullability-completeness
        -Wno-deprecated-declarations
        -Wno-format
        -Wno-varargs
)

target_link_options(sigmaker_linux PRIVATE
        -shared
)

set_target_properties(sigmaker_linux PROPERTIES
        SUFFIX ".so"
        PREFIX "lib"
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/output"
)
