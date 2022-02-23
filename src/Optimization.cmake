macro(enable_interprocedural_optimization)
  if(CMAKE_BUILD_TYPE STREQUAL "Release" OR CMAKE_BUILD_TYPE STREQUAL "RelWithDebInfo")
    include(CheckIPOSupported)
    check_ipo_supported(RESULT result OUTPUT output)
    if(result)
      set(CMAKE_INTERPROCEDURAL_OPTIMIZATION ON)
    else()
      message(SEND_ERROR "IPO is not supported: ${output}")
    endif()
  endif()
endmacro()

macro(enable_native_optimization)
  message(STATUS "Enabling the optimizations specific to the current build machine (less portable)")
  if(MSVC)
    target_compile_options(${project_name} PRIVATE /arch:native)
  else()
    target_compile_options(${project_name} PRIVATE -march=native)
  endif()
endmacro()
