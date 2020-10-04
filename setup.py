from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
import numpy as np

VERSION = '1.0.5'

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
  name = "pycodec2-old",
  packages = ['pycodec2'],
  version = VERSION,
  description = 'A Cython wrapper for codec2',
  long_description = 'A fork of pycodec2 that is compatible with 0.7, 0.8 codec2 versions',
  author = 'Grzegorz Milka',
  author_email = 'grzegorzmilka@gmail.com',
  url = 'https://github.com/gregorias/pycodec2',
  keywords = ['codec2', 'audio', 'voice'],
  classifiers = ['Topic :: Multimedia :: Sound/Audio :: Speech',
                 'License :: OSI Approved :: BSD License',
                 'Programming Language :: Python :: 3',
                 'Development Status :: 5 - Production/Stable',
                 ],
  cmdclass = {"build_ext": build_ext},
  ext_modules = ext_modules
)
