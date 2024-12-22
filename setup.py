import Cython.Build
from Cython.Build import cythonize
from setuptools import Extension, setup
import numpy as np
import sys

# Extension API reference:
# https://setuptools.pypa.io/en/latest/userguide/ext_modules.html.
ext_modules = [
    Extension(
        "pycodec2.pycodec2",
        [
            "pycodec2/pycodec2.pyx",
        ],
        # We need to include the numpy headers, because we use the numpy API
        # for array types. Without this line, the build will fail.
        include_dirs=[np.get_include()],
        # This line guarantees that we do not use the numpy API
        # deprecated in 1.26.
        define_macros=[("NPY_NO_DEPRECATED_API", "NPY_1_26_API_VERSION")],
        # The list of libraries to link against.
        # Not including this line, will cause an error upon using pycodec2:
        # > ImportError: dlopen(/Users/grzesiek/Code/pycodec2-202310/build/lib.macosx-13.3-arm64-cpython-311/pycodec2.cpython-311-darwin.so, 0x0002):
        # > symbol not found in flat namespace '_codec2_700c_eq'
        library_dirs=["lib_win"] if sys.platform == "win32" else None,
        libraries=["libcodec2"] if sys.platform == "win32" else ["codec2"],
        # extra_link_args=["/VERBOSE"], # only works with MSVC
    )
]

setup(
    packages=["pycodec2"],
    ext_modules=cythonize(ext_modules),
    author="Grzegorz Milka",
    author_email="grzegorzmilka@gmail.com",
    url="https://github.com/gregorias/pycodec2",
    cmdclass={"build_ext": Cython.Build.build_ext},
    data_files=(
        [("Lib/site-packages/pycodec2", ["lib_win/libcodec2.dll", "lib_win/libgcc_s_seh-1.dll"])]
        if sys.platform == "win32"
        else None
    ),
)
