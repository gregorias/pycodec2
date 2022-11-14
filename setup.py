import Cython.Build
from Cython.Build import cythonize
import numpy as np
from setuptools import Extension, setup

VERSION = '2.1.0'

ext_modules = [
    Extension("pycodec2",
              [
                  "pycodec2/codec2.pxd",
                  "pycodec2/pycodec2.pyx",
              ],
              include_dirs=[np.get_include()],
              # This line guarantees that we do not numpy API deprecated in
              # 1.23.
              define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_23_API_VERSION")],
              libraries=["codec2"]) # Unix-like specific
]


setup(
  name = "pycodec2",
  packages = ['pycodec2'],
  version = VERSION,
  description = 'A Cython wrapper for codec2',
  long_description = open('README.md').read(),
  long_description_content_type = 'text/markdown',
  author = 'Grzegorz Milka',
  author_email = 'grzegorzmilka@gmail.com',
  url = 'https://github.com/gregorias/pycodec2',
  keywords = ['codec2', 'audio', 'voice'],
  classifiers = ['Topic :: Multimedia :: Sound/Audio :: Speech',
                 'License :: OSI Approved :: BSD License',
                 'Programming Language :: Python :: 3',
                 'Development Status :: 5 - Production/Stable',
                 ],
  ext_modules = cythonize(ext_modules),
  cmdclass={'build_ext': Cython.Build.build_ext},
)
