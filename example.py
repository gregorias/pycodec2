# See README.md for documentation.
import struct
import sys

import numpy as np
import pycodec2

if __name__ == '__main__':
    input = sys.argv[1]
    c2 = pycodec2.Codec2(1200)
    INT16_BYTE_SIZE = 2
    PACKET_SIZE = c2.samples_per_frame() * INT16_BYTE_SIZE
    STRUCT_FORMAT = '{}h'.format(c2.samples_per_frame())

    with open(sys.argv[1], 'rb') as input,\
         open('output.raw', 'wb') as output:
        while True:
            packet = input.read(PACKET_SIZE)
            if len(packet) != PACKET_SIZE:
                break
            packet = np.array(struct.unpack(STRUCT_FORMAT, packet),
                              dtype=np.int16)
            encoded = c2.encode(packet)
            packet = c2.decode(encoded)
            output.write(struct.pack(STRUCT_FORMAT, *packet))
