cmake_minimum_required(VERSION 3.17.2...3.29)

project(slycot LANGUAGES C Fortran)

set(SLYCOT_BUNDLE_OPENBLAS OFF CACHE BOOL "Bundle libraries from scipy-openblas32 in built wheel")

find_package(
  Python
  COMPONENTS Interpreter Development.Module NumPy
  REQUIRED)

execute_process(
  COMMAND "${PYTHON_EXECUTABLE}" -c
          "import numpy.f2py; print(numpy.f2py.get_include())"
  OUTPUT_VARIABLE F2PY_INCLUDE_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE)

cmake_path(CONVERT ${F2PY_INCLUDE_DIR} TO_CMAKE_PATH_LIST F2PY_INCLUDE_DIR)

if(SLYCOT_BUNDLE_OPENBLAS)
  find_program(SLYCOT_OBJCOPY objcopy)

  execute_process(
    COMMAND "${PYTHON_EXECUTABLE}" -c
    "import scipy_openblas32; import os.path; print(scipy_openblas32.get_lib_dir())"
    OUTPUT_VARIABLE OPENBLAS_DIR
    OUTPUT_STRIP_TRAILING_WHITESPACE
    COMMAND_ERROR_IS_FATAL ANY)

  cmake_path(CONVERT ${OPENBLAS_DIR} TO_CMAKE_PATH_LIST OPENBLAS_DIR)

  execute_process(
    COMMAND "${PYTHON_EXECUTABLE}" -c
    "import scipy_openblas32; import os.path; print(scipy_openblas32.get_library(fullname=True))"
    OUTPUT_VARIABLE OPENBLAS_LIBRARY_FILE
    OUTPUT_STRIP_TRAILING_WHITESPACE
    COMMAND_ERROR_IS_FATAL ANY)

  cmake_path(APPEND OPENBLAS_DIR ${OPENBLAS_LIBRARY_FILE} OUTPUT_VARIABLE OPENBLAS_LIBRARY_FILE)
else()
  find_package(LAPACK REQUIRED)
endif()

add_library(fortranobject OBJECT "${F2PY_INCLUDE_DIR}/fortranobject.c")
target_link_libraries(fortranobject PUBLIC Python::NumPy)
target_include_directories(fortranobject PUBLIC "${F2PY_INCLUDE_DIR}")
set_property(TARGET fortranobject PROPERTY POSITION_INDEPENDENT_CODE ON)

add_subdirectory(slycot)
