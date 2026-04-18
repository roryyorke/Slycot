@rem https://github.com/conda-forge/conda-forge-ci-setup-feedstock/blob/main/recipe/run_conda_forge_build_setup_win.bat
@rem BSD-3-Clause license
@rem Copyright (c) 2015-2022, conda-forge contributors
@rem All rights reserved.
@rem
@rem Redistribution and use in source and binary forms, with or without
@rem modification, are permitted provided that the following conditions are met:
@rem
@rem   1. Redistributions of source code must retain the above copyright notice,
@rem      this list of conditions and the following disclaimer.
@rem   2. Redistributions in binary form must reproduce the above copyright
@rem      notice, this list of conditions and the following disclaimer in the
@rem      documentation and/or other materials provided with the distribution.
@rem   3. Neither the name of the copyright holder nor the names of its
@rem      contributors may be used to endorse or promote products derived from
@rem      this software without specific prior written permission.
@rem
@rem THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
@rem AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
@rem IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
@rem ARE DISCLAIMED. IN NO EVENT SHALL THE REGENTS OR CONTRIBUTORS BE LIABLE FOR
@rem ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
@rem DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
@rem SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
@rem CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
@rem LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
@rem OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH
@rem DAMAGE.

set PYTHONUNBUFFERED=1

call conda info
conda.exe info

call conda config --set show_channel_urls true
conda.exe config --set auto_update_conda false
conda.exe config --set add_pip_as_python_dependency false
:: Otherwise packages that don't explicitly pin openssl in their requirements
:: are forced to the newest OpenSSL version, even if their dependencies don't
:: support it.
conda.exe config --env --append aggressive_update_packages ca-certificates
conda.exe config --env --remove-key aggressive_update_packages
conda.exe config --env --append aggressive_update_packages ca-certificates
conda.exe config --env --append aggressive_update_packages certifi

conda.exe config --set channel_priority strict

:: Set the conda-build working directory to a smaller path
if "%CONDA_BLD_PATH%" == "" (
    set "CONDA_BLD_PATH=C:\\bld\\"
)

call conda activate base

:: Remove some directories from PATH
set "PATH=%PATH:C:\ProgramData\Chocolatey\bin;=%"
set "PATH=%PATH:C:\Program Files (x86)\sbt\bin;=%"
set "PATH=%PATH:C:\Rust\.cargo\bin;=%"
set "PATH=%PATH:C:\Program Files\Git\usr\bin;=%"
set "PATH=%PATH:C:\Program Files\Git\cmd;=%"
set "PATH=%PATH:C:\Program Files\Git\mingw64\bin;=%"
set "PATH=%PATH:C:\Program Files (x86)\Subversion\bin;=%"
set "PATH=%PATH:C:\Program Files\CMake\bin;=%"
set "PATH=%PATH:C:\Program Files\OpenSSL\bin;=%"
set "PATH=%PATH:C:\Strawberry\c\bin;=%"
set "PATH=%PATH:C:\Strawberry\perl\bin;=%"
set "PATH=%PATH:C:\Strawberry\perl\site\bin;=%"
set "PATH=%PATH:C:\mingw64\bin;=%"
set "PATH=%PATH:c:\tools\php;=%"

:: Make paths like C:\hostedtoolcache\windows\Ruby\2.5.7\x64\bin garbage
set "PATH=%PATH:ostedtoolcache=%"
set "PATH=%PATH:xternals\git\mingw=%"

mkdir "%CONDA_PREFIX%\etc\conda\activate.d"

echo set "CONDA_BLD_PATH=%CONDA_BLD_PATH%"         > "%CONDA_PREFIX%\etc\conda\activate.d\conda-forge-ci-setup-activate.bat"
echo set "PYTHONUNBUFFERED=%PYTHONUNBUFFERED%"    >> "%CONDA_PREFIX%\etc\conda\activate.d\conda-forge-ci-setup-activate.bat"
echo set "PATH=%PATH%"                            >> "%CONDA_PREFIX%\etc\conda\activate.d\conda-forge-ci-setup-activate.bat"

set CONDA_BUILD_SKIP_TESTS=0

call activate base

@echo on
conda.exe info
conda.exe config --show-sources
conda.exe list --show-channel-urls
@echo off

conda-build.exe conda-recipe --python 3.13
