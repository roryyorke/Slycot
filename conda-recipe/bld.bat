@echo on

set FC=%BUILD_PREFIX%\Library\bin\flang.exe
set BLAS_ROOT=%PREFIX%
set LAPACK_ROOT=%PREFIX%

set "SKBUILD_CONFIGURE_OPTIONS=-DBLA_VENDOR=Generic"
set SKBUILD_BUILD_VERBOSE=true
set "CMAKE_GENERATOR=Ninja"

%PYTHON% -m pip install --no-build-isolation -vv .

if errorlevel 1 exit 1
