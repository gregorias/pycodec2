cdef extern from 'codec2/codec2.h':
  cdef enum:
    CODEC2_MODE_3200 = 0
    CODEC2_MODE_2400 = 1
    CODEC2_MODE_1600 = 2
    CODEC2_MODE_1400 = 3
    CODEC2_MODE_1300 = 4
    CODEC2_MODE_1200 = 5
    CODEC2_MODE_700C = 8
    CODEC2_MODE_450  = 10
    CODEC2_MODE_450PWB  = 11
  cdef struct CODEC2:
    pass

  CODEC2* codec2_create(int mode)
  void codec2_destroy(CODEC2* codec2_state)
  void codec2_encode(CODEC2 *codec2_state,
      unsigned char * bits,
      short speech_in[])
  void codec2_decode(CODEC2 *codec2_state,
      short speech_out[],
      const unsigned char *bits)
  void codec2_decode_ber(CODEC2 *codec2_state,
      short speech_out[],
      const unsigned char *bits,
      float ber_est)
  int codec2_samples_per_frame(CODEC2 *codec2_state)
  int codec2_bits_per_frame(CODEC2 *codec2_state)
  void codec2_set_lpc_post_filter(CODEC2 *codec2_state,
      int enable,
      int bass_boost,
      float beta,
      float gamma)
  int codec2_get_spare_bit_index(CODEC2 *codec2_state)
  int codec2_rebuild_spare_bit(CODEC2 *codec2_state, int unpacked_bits[])
  void codec2_set_natural_or_gray(CODEC2 *codec2_state, int gray)
