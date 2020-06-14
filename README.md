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

Run:

    python setup.py install

to install the library.

Use
===

## Example

`example.py` implements a basic script that uses codec2 to encode and deencode a
sample.

1. Download a sample .wav file, e.g.
[trashcan](https://freesound.org/people/InspectorJ/sounds/431158/).
1. Convert the .wav to a raw mono-channel 8kHz format, e.g.

       sox trashcan.wav -e signed-integer -b 16 trashcan.raw channels 1 rate 8000
3. Compile pycodec2

       python setup.py build_ext --inplace
3. Run `example.py`

       python example.py trashcan.raw
4. Convert `output.raw`

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

Remarks
=======

This library is considered complete. Please notify me or send a pull request on
Github if you notice any bugs.

[codec2]: http://www.rowetel.com/blog/?page_id=452
