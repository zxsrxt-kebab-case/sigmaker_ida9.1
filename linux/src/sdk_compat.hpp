#ifndef SIGMAKER_MACOS_SDK_COMPAT_HPP
#define SIGMAKER_MACOS_SDK_COMPAT_HPP

#if __cplusplus >= 202302L
namespace std {
    template<class T> struct is_pod {
        static constexpr bool value = __is_pod(T);
    };
}
#endif

#include <ida.hpp>
#include <expected>

#endif //SIGMAKER_MACOS_SDK_COMPAT_HPP
