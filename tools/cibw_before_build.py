"""cibuildwheel setup script

Installs scipy_openblas32 version specified by command-line argument

Copies scipy_openblas32 to build-libs in project root.
"""

import os
import shutil
import subprocess
import sys


def install_openblas32(scipy_openblas32_version):
    print(f"{__file__}: Installing scipy_openblas32=={scipy_openblas32_version}")
    subprocess.run(
        [
            sys.executable,
            "-m",
            "pip",
            "install",
            "--progress-bar",
            "off",
            f"scipy_openblas32=={scipy_openblas32_version}",
        ],
        check=True,
    )


def copy_libraries():
    import scipy_openblas32

    src = scipy_openblas32.get_lib_dir()
    dst = os.path.abspath("build-libs")
    print(f"{__file__}: Copying {src} to {dst}")
    shutil.copytree(src, dst)


def main():
    version = sys.argv[1]
    install_openblas32(version)
    copy_libraries()


if __name__ == "__main__":
    main()
