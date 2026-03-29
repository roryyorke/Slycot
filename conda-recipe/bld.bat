@echo on

echo "--conda-recipe bld.bat"

set FC=%BUILD_PREFIX%\Library\bin\flang.exe
set "SKBUILD_CONFIGURE_OPTIONS=-DBLA_VENDOR=Generic"
set SKBUILD_BUILD_VERBOSE=true
set "CMAKE_GENERATOR=Ninja"

%PYTHON% -m pip install -vv .

if errorlevel 1 exit 1

if %ERRORLEVEL% neq 0 exit 1
