# SLICOT sources
include(slicot-source.cmake)

# compatibility and error handling
set(SLYCOT_FSOURCE src/ftruefalse.f src/XERBLA.f)

# f2py definitions
set(F2PYSOURCE src/_wrapper.pyf)
set(F2PYSOURCE_DEPS
  src/analysis.pyf
  src/math.pyf
  src/transform.pyf
  src/synthesis.pyf
  src/_helper.pyf)

add_custom_command(
  OUTPUT _wrappermodule.c _wrapper-f2pywrappers.f
  DEPENDS ${F2PYSOURCE_DEPS} ${F2PYSOURCE}
  VERBATIM
  COMMAND ${Python_EXECUTABLE} -m numpy.f2py --skip-empty-wrappers ${CMAKE_CURRENT_SOURCE_DIR}/${F2PYSOURCE}
)

python_add_library(
  _wrapper MODULE
  "${CMAKE_CURRENT_BINARY_DIR}/_wrappermodule.c"
  "${CMAKE_CURRENT_BINARY_DIR}/_wrapper-f2pywrappers.f"
  ${SLICOT_FSOURCE}
  ${SLYCOT_FSOURCE})

target_compile_options(_wrapper PRIVATE -cpp "@${CMAKE_CURRENT_SOURCE_DIR}/scipy-openblas-symbols/scipy-openblas-symbols.def" -ffixed-line-length-132)
target_link_libraries(_wrapper PUBLIC ${OPENBLAS_LIBRARY_FILE})
set_target_properties(_wrapper PROPERTIES INSTALL_RPATH ${OPENBLAS_DIR})

target_link_libraries(_wrapper PRIVATE fortranobject)
install(TARGETS _wrapper DESTINATION slycot)
