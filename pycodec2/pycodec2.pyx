from codec2 cimport *

import math

import numpy as np
cimport numpy as cnp
ctypedef cnp.int16_t SHORT_DTYPE_t
ctypedef cnp.int_t INT_DTYPE_t

_modes = {
    450  : CODEC2_MODE_450,
    451  : CODEC2_MODE_450PWB, #Decode only! Encode with 450, decode with 451 to use
    700  : CODEC2_MODE_700C,
    1200 : CODEC2_MODE_1200,
    1300 : CODEC2_MODE_1300,
    1400 : CODEC2_MODE_1400,
    1600 : CODEC2_MODE_1600,
    2400 : CODEC2_MODE_2400,
    3200 : CODEC2_MODE_3200,
    }

cdef class Codec2:
  '''Wrapper for codec2 state and its functions.

  Initialization method expects an integer defining expected bitrate per
  second.'''
  cdef CODEC2 *_c_codec2_state

  def __cinit__(self, mode):
    self._c_codec2_state = codec2_create(_modes[mode])
    if self._c_codec2_state is NULL:
      raise MemoryError()

  def __dealloc__(self):
    if self._c_codec2_state is not NULL:
      codec2_destroy(self._c_codec2_state)

  def encode(self, cnp.ndarray[SHORT_DTYPE_t, ndim=1] speech_in):
    '''Encode samples with codec2.

    Encode the given ndarray of samples to bits represented as a byte array.'''
    assert len(speech_in) % self.samples_per_frame() == 0
    frames = len(speech_in) // self.samples_per_frame()
    bit_count = frames * self.bits_per_frame()
    bits = b'\x00' * int(math.ceil(bit_count / 8.0))
    codec2_encode(self._c_codec2_state, bits, <short *>speech_in.data)
    return bits

  def decode(self, bytes bits):
    '''Decode a byte array into an ndarray of samples'''
    assert (len(bits) * 8) >= self.bits_per_frame()
    cdef cnp.ndarray[SHORT_DTYPE_t, ndim=1] speech_out
    frames = int(math.floor((len(bits) * 8.0) / self.bits_per_frame()))
    sample_count = frames * self.samples_per_frame()
    speech_out = np.empty(sample_count, dtype=np.int16, order='C')
    codec2_decode(self._c_codec2_state, <short *>speech_out.data, bits)
    return speech_out

  def decode_ber(self, bytes bits, float ber_est):
    assert (len(bits) * 8) >= self.bits_per_frame()
    cdef cnp.ndarray[SHORT_DTYPE_t, ndim=1] speech_out
    frames = (len(bits) * 8) // self.bits_per_frame()
    sample_count = frames * self.samples_per_frame()
    speech_out = np.empty(sample_count, dtype=np.int16, order='C')
    codec2_decode_ber(self._c_codec2_state,
        <short *>speech_out.data,
        bits,
        ber_est)
    return speech_out

  def samples_per_frame(self):
    return codec2_samples_per_frame(self._c_codec2_state)

  def bits_per_frame(self):
    return codec2_bits_per_frame(self._c_codec2_state)

  def set_lpc_post_filter(self,
      int enable,
      int bass_boost,
      float beta,
      float gamma):
    codec2_set_lpc_post_filter(self._c_codec2_state,
        enable,
        bass_boost,
        beta,
        gamma)

  def get_spare_bit_index(self):
    return codec2_get_spare_bit_index(self._c_codec2_state)

  def rebuild_spare_bit(self, cnp.ndarray[INT_DTYPE_t, ndim=1] unpacked_bits):
    return codec2_rebuild_spare_bit(self._c_codec2_state,
        <int *>unpacked_bits.data)

  def set_natural_or_gray(self, int gray):
    codec2_set_natural_or_gray(self._c_codec2_state, gray)

