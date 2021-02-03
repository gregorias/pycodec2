Overview
========

Pycodec2 is a Cython wrapper for [Codec2][codec2].

In other words, Pycodec2 allows using Codec2 C library from Python.

Installation
============

## Prerequisites

Pycodec2 requires [Codec2][codec2]. The easiest way to install codec2 on Linux
is to use the distro's package-manager, e.g. on Arch/Manjaro: `pacman -Syuu
codec2` so that Codec2's assets land in standard, searchable directories for
`python setup.py` to use.

## Instructions

You can install the library using PyPI (the easiest option) or from source.

### From PyPI

To install the library from PyPI, run:

    pip install pycodec2

### From Source

To install the library from Source, run:

    python setup.py install

### Codec2 Compatibility

pycodec2 is compatible with codec2 at 0.9.2+ versions. If your codec2 version is older than 0.9.2, then try [pycodec2-old](https://pypi.org/project/pycodec2-old/) package.

For more information on potential compatibility problems, check out [this issue](https://github.com/gregorias/pycodec2/issues/8).

Use
===

## Example

`example.py` implements a basic script that uses codec2 to encode and deencode a
sample. Use the following steps to run an end-2-end scenario (dev/rune2etest
implements steps 2-5).

1. Download a sample .wav file, e.g.
[trashcan](https://freesound.org/people/InspectorJ/sounds/431158/).
2. Convert the .wav to a raw mono-channel 8kHz format, e.g.

       sox trashcan.wav -e signed-integer -b 16 trashcan.raw channels 1 rate 8000
3. Compile pycodec2

       python setup.py build_ext --inplace
4. Run `example.py`

       python example.py trashcan.raw
5. Convert `output.raw`

       sox -r 8000 -e signed-integer -b 16 output.raw output.wav

Now you can listen to `output.wav`.

## Expected Input Format

[Codec2][codec2] assumes that input files:
* use 8kHz bitrate,
* 16-bit width samples, and
* a single channel.

## Available Modes

For a list of currently supported modes, look for `_modes` in
`pycodec2/pycodec2.pyx`.

For Developers
==============

## How to Upload to PyPI

1. [Run `build_ext`](https://stackoverflow.com/a/4515279/915552)

       python setup.py build_ext
2. [Build a wheel](https://packaging.python.org/guides/distributing-packages-using-setuptools/#pure-python-wheels)

       python setup.py sdist
3. [Upload](https://packaging.python.org/guides/distributing-packages-using-setuptools/#uploading-your-project-to-pypi)

       twine upload dist/pycodec2.*tar.gz

Remarks
=======

This library is considered complete. Please notify me or send a pull request on
Github if you notice any bugs.

[codec2]: http://www.rowetel.com/blog/?page_id=452
