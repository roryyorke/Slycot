# CMakeLists.txt file for Slycot
# use in conjunction with scikit-build
#
# RvP, 180710

include(slicot-sources.cmake)

set(FSOURCES
  ${SLICOT_SOURCES}
  src/SLCT_DLATZM.f
  src/SLCT_ZLATZM.f
  src/ftruefalse.f
  src/XERBLA.f
)

set(F2PYSOURCE src/_wrapper.pyf)
set(F2PYSOURCE_DEPS
  src/analysis.pyf src/math.pyf
  src/transform.pyf src/synthesis.pyf
  src/_helper.pyf)

configure_file(version.py.in version.py @ONLY)

set(PYSOURCE

  __init__.py  examples.py exceptions.py
  analysis.py math.py synthesis.py transform.py
  ${CMAKE_CURRENT_BINARY_DIR}/version.py)

set(SLYCOT_MODULE "_wrapper")

set(GENERATED_MODULE
  ${CMAKE_CURRENT_BINARY_DIR}/${SLYCOT_MODULE}${PYTHON_EXTENSION_MODULE_SUFFIX})


set(CMAKE_Fortran_FLAGS )

add_custom_target(wrapper ALL DEPENDS ${FSOURCES})
add_custom_command(
  OUTPUT _wrappermodule.c _wrapper-f2pywrappers.f
  COMMAND ${F2PY_EXECUTABLE} -m SLYCOT
  ${CMAKE_CURRENT_SOURCE_DIR}/${F2PYSOURCE}
  DEPENDS ${F2PYSOURCE_DEPS} ${F2PYSOURCE}
)

add_library(
  ${SLYCOT_MODULE} MODULE
  _wrappermodule.c
  ${F2PY_INCLUDE_DIR}/fortranobject.c
  _wrapper-f2pywrappers.f
  ${FSOURCES})

target_link_libraries(${SLYCOT_MODULE}
  ${LAPACK_LIBRARIES})

target_include_directories(
  ${SLYCOT_MODULE} PUBLIC
  ${F2PY_INCLUDE_DIRS}
  ${PYTHON_INCLUDE_DIRS}
  )

if (UNIX)
  if (APPLE)
    set_target_properties(${SLYCOT_MODULE} PROPERTIES
      LINK_FLAGS  '-Wl,-dylib,-undefined,dynamic_lookup')
  else()
    set_target_properties(${SLYCOT_MODULE} PROPERTIES
      LINK_FLAGS  '-Wl,--allow-shlib-undefined')
  endif()
endif()

python_extension_module(${SLYCOT_MODULE})

install(TARGETS ${SLYCOT_MODULE} LIBRARY DESTINATION slycot)
install(FILES ${PYSOURCE} DESTINATION slycot)

add_subdirectory(tests)
