cmake_minimum_required(VERSION 3.20)
project(sigmaker_macos LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_compile_definitions(
        _LIBCPP_ENABLE_CXX20_REMOVED_TYPE_TRAITS
        _LIBCPP_ENABLE_CXX17_REMOVED_FEATURES
        __MAC__
        __IDP__
        __EA64__=1
)

add_compile_options(
        -Wno-deprecated-declarations
        -Wno-invalid-offsetof
        -D_LIBCPP_DISABLE_DEPRECATION_WARNINGS
)


#write here path for ida sdk...
set(IDA_SDK_PATH "$ENV{HOME}/Desktop/idasdk91")
if(NOT EXISTS "${IDA_SDK_PATH}/include/ida.hpp")
    message(FATAL_ERROR "IDA SDK not found at ${IDA_SDK_PATH}.")
endif()


file(GLOB sources "src/*.cpp" "src/*mm")


add_library(sigmaker_macos SHARED ${sources}
        src/sdk_compat.hpp)

target_include_directories(sigmaker_macos PRIVATE
        "${IDA_SDK_PATH}/include"
        "${IDA_SDK_PATH}/include/pro"
)

target_compile_options(sigmaker_macos PRIVATE
        -fPIC
        -Wno-nullability-completeness
        -Wno-deprecated-declarations
        -Wno-format
        -Wno-varargs
)

target_link_options(sigmaker_macos PRIVATE
        -shared
        -undefined dynamic_lookup
        -Wl
)

set_target_properties(sigmaker_macos PROPERTIES
        SUFFIX ".dylib"
        PREFIX ""
        MACOSX_RPATH ON
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/output"
)

find_library(APPKIT AppKit REQUIRED)
find_library(FOUNDATION Foundation REQUIRED)

target_link_libraries(sigmaker_macos PRIVATE
        ${APPKIT}
        ${FOUNDATION}
)