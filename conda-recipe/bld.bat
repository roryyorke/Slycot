@echo on

echo "bld.bat"

echo SKBUILD_CMAKE_ARGS is - %SKBUILD_CMAKE_ARGS% -
set CMAKE_MSVC_DEBUG_INFORMATION_FORMAT="\"\""

echo CMAKE_MSVC_DEBUG_INFORMATION_FORMAT is %CMAKE_MSVC_DEBUG_INFORMATION_FORMAT%

%PYTHON% -m pip install --no-deps --no-build-isolation -vv .
if %ERRORLEVEL% neq 0 exit 1

rem set BLAS_ROOT=%PREFIX%
rem set LAPACK_ROOT=%PREFIX%

rem set "SKBUILD_CONFIGURE_OPTIONS=-DBLA_VENDOR=Generic"
rem set "SKBUILD_CMAKE_ARGS=-G Ninja"
rem "%PYTHON%" -m pip install -v .

rem if errorlevel 1 exit 1
