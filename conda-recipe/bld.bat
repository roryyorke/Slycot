@echo on

%PYTHON% -m pip install --no-deps --no-build-isolation -vv .
if %ERRORLEVEL% neq 0 exit 1

rem set BLAS_ROOT=%PREFIX%
rem set LAPACK_ROOT=%PREFIX%

rem set "SKBUILD_CONFIGURE_OPTIONS=-DBLA_VENDOR=Generic"
rem set "SKBUILD_CMAKE_ARGS=-G Ninja"
rem "%PYTHON%" -m pip install -v .

rem if errorlevel 1 exit 1
