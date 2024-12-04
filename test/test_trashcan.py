"""E2e test cases that encode and decodes a trashcan file."""
import io
import os.path as path
import struct
import unittest
from pathlib import Path

import numpy as np

import pycodec2

TEST_DATA_DIR = path.join(path.dirname(path.realpath(__file__)), 'data')
TRASHCAN_GOLDEN_FILES = [
    path.join(TEST_DATA_DIR, f) for f in [
        './trashcan-1200-decoded-macos.raw',
        './trashcan-1200-decoded-macos15-m3.raw',
        './trashcan-1200-decoded-ubuntu.raw'
    ]
]


def read_file(filename: str) -> bytes:
    with open(filename, 'rb') as f:
        return f.read()


class TrashcanTestCase(unittest.TestCase):

    def test_encodes_and_decodes_trashcan(self):
        c2 = pycodec2.Codec2(1200)
        with io.BytesIO() as output:
            with open(path.join(TEST_DATA_DIR, 'trashcan.raw'), 'rb') as input:
                INT16_BYTE_SIZE = 2
                PACKET_SIZE = c2.samples_per_frame() * INT16_BYTE_SIZE
                STRUCT_FORMAT = '{}h'.format(c2.samples_per_frame())
                while True:
                    packet = input.read(PACKET_SIZE)
                    if len(packet) != PACKET_SIZE:
                        break
                    packet = np.array(struct.unpack(STRUCT_FORMAT, packet),
                                      dtype=np.int16)
                    encoded = c2.encode(packet)
                    packet = c2.decode(encoded)
                    output.write(struct.pack(STRUCT_FORMAT, *packet))
            output.seek(0)

            self.assertIn(output.read(),
                          [read_file(f) for f in TRASHCAN_GOLDEN_FILES])
