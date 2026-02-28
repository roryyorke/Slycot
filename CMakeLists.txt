cmake_minimum_required(VERSION 3.17.2...3.29)

project(slycot LANGUAGES C Fortran)

find_package(
  Python
  COMPONENTS Interpreter Development.Module NumPy
  REQUIRED)

execute_process(
  COMMAND "${PYTHON_EXECUTABLE}" -c
          "import scipy_openblas32; import os.path; print(scipy_openblas32.get_lib_dir())"
  OUTPUT_VARIABLE OPENBLAS_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE
  COMMAND_ERROR_IS_FATAL ANY)

cmake_path(CONVERT ${OPENBLAS_DIR} TO_CMAKE_PATH_LIST OPENBLAS_DIR)

message(STATUS "OpenBlas directory: ${OPENBLAS_DIR}")

execute_process(
  COMMAND "${PYTHON_EXECUTABLE}" -c
          "import scipy_openblas32; import os.path; print(scipy_openblas32.get_library(fullname=True))"
  OUTPUT_VARIABLE OPENBLAS_LIBRARY_FILE
  OUTPUT_STRIP_TRAILING_WHITESPACE
  COMMAND_ERROR_IS_FATAL ANY)

message(STATUS "OpenBlas library file: ${OPENBLAS_LIBRARY_FILE}")

cmake_path(APPEND OPENBLAS_DIR ${OPENBLAS_LIBRARY_FILE} OUTPUT_VARIABLE OPENBLAS_LIBRARY_FILE)

message(STATUS "OpenBlas library file 2: ${OPENBLAS_LIBRARY_FILE}")

# build f2py support contained in NumPy
execute_process(
  COMMAND "${PYTHON_EXECUTABLE}" -c
          "import numpy.f2py; print(numpy.f2py.get_include())"
  OUTPUT_VARIABLE F2PY_INCLUDE_DIR
  OUTPUT_STRIP_TRAILING_WHITESPACE)

add_library(fortranobject OBJECT "${F2PY_INCLUDE_DIR}/fortranobject.c")
target_link_libraries(fortranobject PUBLIC Python::NumPy)
target_include_directories(fortranobject PUBLIC "${F2PY_INCLUDE_DIR}")
set_property(TARGET fortranobject PROPERTY POSITION_INDEPENDENT_CODE ON)

add_subdirectory(slycot)
