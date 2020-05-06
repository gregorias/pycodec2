from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np 

VERSION = '1.0.2'

ext_modules = [
    Extension("pycodec2",
              [
                  "pycodec2/codec2.pxd",
                  "pycodec2/pycodec2.pyx",
              ],
              include_dirs=[np.get_include()],
              libraries=["codec2"]) # Unix-like specific
]

setup(
  name = "pycodec2",
  packages = ['pycodec2'],
  version = VERSION,
  description = 'Cython wrapper for codec2',
  author = 'Grzegorz Milka',
  author_email = 'grzegorzmilka@gmail.com',
  url = 'https://github.com/gregorias/pycodec2',
  download_url = 'https://github.com/gregorias/pycodec2/tarball/' + VERSION,
  keywords = ['codec2', 'audio', 'voice'],
  classifiers = ['Topic :: Multimedia :: Sound/Audio :: Speech',
                 'License :: OSI Approved :: BSD License',
                 'Programming Language :: Python :: 2',
                 'Programming Language :: Python :: 3',
                 'Development Status :: 5 - Production/Stable',
                 ],
  cmdclass = {"build_ext": build_ext},
  ext_modules = ext_modules
)
