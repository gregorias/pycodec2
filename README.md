# Pycodec2

Pycodec2 is a Cython wrapper for [Codec 2][codec2].

In other words, Pycodec2 allows using the Codec 2 C library from Python.

## Installation

### Prerequisites

Pycodec2 requires [Codec 2][codec2].

On Linux, I recommend using the distro's package-manager, e.g., on
Arch/Manjaro: `pacman -Syuu codec2`, so that Codec2's assets land in standard
searchable directories for `python setup.py` to use.

On macOS, you may use [the Homebrew
formula](https://formulae.brew.sh/formula/codec2#default).

### Instructions

You can install the library using PyPI (the easiest option) or from source.

#### From PyPI

To install the library from PyPI, run:

```bash
pip install pycodec2
```

### From Source

To install the library from source, see building instructions in `DEV.md`. You
can then install the wheel with:

```bash
pip install dist/*.whl
```

### Codec 2 Compatibility

Current source is compatible with Codec 2 1.2.\*.

Pycodec2 2.\* is compatible with Codec 2 1.0.\*.

Pycodec2 1.0.\* is compatible with Codec 2 at 0.9.2+ versions.

If your Codec 2 version is older than 0.9.2, then try
[pycodec2-old](https://pypi.org/project/pycodec2-old/) package.

For more information on potential compatibility problems, check out [this
issue](https://github.com/gregorias/pycodec2/issues/8).

## Usage

### Example

`example.py` implements a basic script that uses Codec 2 to encode and deencode
a sample. Use the following steps to run an end-2-end scenario (dev/rune2etest
implements steps 2-5).

1. Download a sample .wav file, e.g., [trashcan](https://freesound.org/people/InspectorJ/sounds/431158/).

2. Convert the .wav to a raw mono-channel 8kHz format, e.g.,

   sox trashcan.wav -e signed-integer -b 16 trashcan.raw channels 1 rate 8000

3. Compile pycodec2

   python setup.py build_ext --inplace

4. Run `example.py`

   python example.py trashcan.raw

5. Convert `output.raw`

   sox -r 8000 -e signed-integer -b 16 output.raw output.wav

Now you can listen to `output.wav`.

### Expected Input Format

[Codec 2][codec2] assumes that input files use:

* 8kHz bitrate,
* 16-bit width samples,
* a single channel.

### Available Modes

For a list of currently supported modes, look for `_modes` in
`pycodec2/pycodec2.pyx`.

## Remarks

This library is considered complete. Please notify me or send a pull request on
GitHub if you notice any bugs.

[codec2]: http://www.rowetel.com/blog/?page_id=452
