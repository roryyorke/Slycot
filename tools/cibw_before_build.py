# todo: document me
# 1. install openblas32
# 2. find library (libraries), copy it/them to a known location

import os
import shutil
import subprocess
import sys

def install_openblas32(scipy_openblas32_version):
    print(f'{__file__}: Installing scipy_openblas32=={scipy_openblas32_version}')
    subprocess.run([sys.executable, '-m', 'pip', 'install', f'scipy_openblas32=={scipy_openblas32_version}'],
                   check=True)


def copy_libraries():
    import scipy_openblas32
    src = scipy_openblas32.get_lib_dir()
    dst = os.path.abspath('build-libs')
    print(f'{__file__}: Copying {src} to {dst}')
    shutil.copytree(src, dst)
    # todo: remove when all 3 OSs work
    print(os.listdir(dst))


def main():
    version = sys.argv[1]
    install_openblas32(version)
    copy_libraries()


if __name__ == '__main__':
    main()
