#cython: language_level=3
# The language level specification is needed. I don't have it in my build file,
# so I use it per-module.
from .codec2 cimport *

import math

import numpy as np
cimport numpy as cnp
ctypedef cnp.int8_t CHAR_DTYPE_t
ctypedef cnp.int16_t SHORT_DTYPE_t
ctypedef cnp.int_t INT_DTYPE_t

_modes = {
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
    codec2_encode(self._c_codec2_state, bits, <short*>cnp.PyArray_DATA(speech_in))
    return bits

  def decode(self, bytes frames):
    '''Decode a byte array into an ndarray of samples'''
    assert len(frames) >= self.bytes_per_frame()
    cdef cnp.ndarray[SHORT_DTYPE_t, ndim=1] speech_out
    frame_count = int(math.floor(len(frames) / self.bytes_per_frame()))
    sample_count = frame_count * self.samples_per_frame()
    speech_out = np.empty(sample_count, dtype=np.int16, order='C')
    codec2_decode(self._c_codec2_state, <short *>(cnp.PyArray_DATA(speech_out)), frames)
    return speech_out

  def decode_ber(self, bytes frames, float ber_est):
    assert len(frames) >= self.bytes_per_frame()
    cdef cnp.ndarray[SHORT_DTYPE_t, ndim=1] speech_out
    frame_count = len(frames) // self.bytes_per_frame()
    sample_count = frame_count * self.samples_per_frame()
    speech_out = np.empty(sample_count, dtype=np.int16, order='C')
    codec2_decode_ber(self._c_codec2_state,
        <short *>(cnp.PyArray_DATA(speech_out)),
        frames,
        ber_est)
    return speech_out

  def samples_per_frame(self):
    return codec2_samples_per_frame(self._c_codec2_state)

  def bits_per_frame(self):
    return codec2_bits_per_frame(self._c_codec2_state)

  def bytes_per_frame(self):
    return codec2_bytes_per_frame(self._c_codec2_state)

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

  def rebuild_spare_bit(self, cnp.ndarray[char, ndim=1] unpacked_bits):
    return codec2_rebuild_spare_bit(self._c_codec2_state, <char *>cnp.PyArray_DATA(unpacked_bits))

  def set_natural_or_gray(self, int gray):
    codec2_set_natural_or_gray(self._c_codec2_state, gray)

  def set_softdec(self, float softdec):
    codec2_set_softdec(self._c_codec2_state, &softdec)

  def get_energy(self,  cnp.ndarray[unsigned char, ndim=1] bits):
      return codec2_get_energy(self._c_codec2_state, <unsigned char*>(cnp.PyArray_DATA(bits)))

  # support for ML and VQ experiments
  def open_mlfeat(self, bytearray feat_filename, bytearray model_filename):
      codec2_open_mlfeat(self._c_codec2_state, feat_filename, model_filename)

  def load_codebook(self, bytearray feat_filename, int num, bytearray filename):
      codec2_load_codebook(self._c_codec2_state, num, filename)

  def get_var(self):
      return codec2_get_var(self._c_codec2_state)

  def enable_user_ratek(self):
      cdef int K
      cdef float *user_rate_k = codec2_enable_user_ratek(self._c_codec2_state, &K)
      return (user_rate_k[0], K)

  # 700C post filter and equaliser
  def post_filter_700c(self, int en):
      codec2_700c_post_filter(self._c_codec2_state, en)

  def eq_700c(self, int en):
      codec2_700c_eq(self._c_codec2_state, en)
