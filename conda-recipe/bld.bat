:: Uncoment following two lines for local test build
cd %RECIPE_DIR%
cd ..

:: clean old build attempts
RD /S /Q _skbuild

set BLAS_ROOT=%PREFIX%
set LAPACK_ROOT=%PREFIX%
set NUMPY_INCLUDE=%PREFIX%\Include
:: Prefer f2py.exe, if it exists; this is provided by numpy 1.16 (and, we assume, later)
if EXIST "%PREFIX%\Scripts\f2py.exe" (
  set F2PY=%PREFIX%\Scripts\f2py.exe
) ELSE (
:: Otherwise use f2py.bat, which is provided by numpy 1.15 and earlier
  set F2PY=%PREFIX%\Scripts\f2py.bat
)

"%PYTHON%" -m pip install . --no-deps --ignore-installed -vv

if errorlevel 1 exit 1

:: Add more build steps here, if they are necessary.

:: See
:: http://docs.continuum.io/conda/build.html
:: for a list of environment variables that are set during the build process.
