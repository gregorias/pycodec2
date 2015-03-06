from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext

ext_modules=[
    Extension("pycodec2",
              ["pycodec2/pycodec2.pyx"],
              libraries=["codec2"]) # Unix-like specific
]

setup(
  name = "Pycodec2",
  cmdclass = {"build_ext": build_ext},
  ext_modules = ext_modules
)
