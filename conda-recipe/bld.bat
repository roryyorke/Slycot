@echo on

set FC=%BUILD_PREFIX%\Library\bin\flang.exe
set BLAS_ROOT=%PREFIX%
set LAPACK_ROOT=%PREFIX%

set "SKBUILD_CMAKE_ARGS=-G Ninja;-DBLA_VENDOR=Generic"

"%PYTHON%" -m pip install . -vv --config-settings=build.verbose=true --config-settings=logging.level=INFO

if errorlevel 1 exit 1
