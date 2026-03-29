@echo on

@rem set CC=c:/mingw64/bin/gcc.exe
set FC=c:/mingw64/bin/gfortran.exe
set "SKBUILD_CONFIGURE_OPTIONS=-DBLA_VENDOR=Generic"
set "CMAKE_GENERATOR=Ninja"

%PYTHON% -m pip install -v .

if errorlevel 1 exit 1

if %ERRORLEVEL% neq 0 exit 1
