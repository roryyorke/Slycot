"""Slycot: a wrapper for the SLICOT control and systems library

Slycot wraps the SLICOT library which is used for control and systems analysis.
"""

DOCLINES = __doc__.split("\n")

CLASSIFIERS = """\
Development Status :: 3 - Alpha
Intended Audience :: Science/Research
Intended Audience :: Developers
License :: OSI Approved
Programming Language :: C
Programming Language :: Python
Programming Language :: Python :: 3
Topic :: Software Development
Topic :: Scientific/Engineering
Operating System :: Microsoft :: Windows
Operating System :: POSIX
Operating System :: Unix
Operating System :: MacOS
"""

import setuptools

from numpy.distutils.core import setup
from numpy.distutils.core import Extension
from numpy.distutils.system_info import get_info

from glob import glob

lapack_opts = get_info('lapack_opt',2)

# not sure if this is good practise
FORTRAN_FILES=glob('slycot/src/*.f')

PYF_FILES=[
# the other .pyf files are included by _wrapper.pyf
    'slycot/src/_wrapper.pyf',
]

wrapper = Extension(name = 'slycot._wrapper',
                     sources = FORTRAN_FILES + PYF_FILES,
                     **lapack_opts)

setup(name = 'slycot',
      description       = DOCLINES[0],
      long_description="\n".join(DOCLINES[2:]),
      url='https://github.com/python-control/Slycot',
      author='Enrico Avventi et al.',
      license='GPLv2',
      ext_modules = [wrapper],
      packages = ['slycot'],
      classifiers=[_f for _f in CLASSIFIERS.split('\n') if _f],
      platforms=["Windows", "Linux", "Mac OS-X"],
      version = '0.3.2',
)
