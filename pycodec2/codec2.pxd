# Synced with
# https://github.com/drowe67/codec2/commits/25014a290752fb830390ff24a612a9694319a47a/src/codec2.h
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
      unsigned char *bytes,
      short speech_in[])
  void codec2_decode(CODEC2 *codec2_state,
      short speech_out[],
      const unsigned char *bytes)
  void codec2_decode_ber(CODEC2 *codec2_state,
      short speech_out[],
      const unsigned char *bytes,
      float ber_est)
  int codec2_samples_per_frame(CODEC2 *codec2_state)
  int codec2_bits_per_frame(CODEC2 *codec2_state)
  int codec2_bytes_per_frame(CODEC2 *codec2_state);
  void codec2_set_lpc_post_filter(CODEC2 *codec2_state,
      int enable,
      int bass_boost,
      float beta,
      float gamma)
  int codec2_get_spare_bit_index(CODEC2 *codec2_state)
  int codec2_rebuild_spare_bit(CODEC2 *codec2_state, char unpacked_bits[])
  void codec2_set_natural_or_gray(CODEC2 *codec2_state, int gray)
  void codec2_set_softdec(CODEC2 *c2, float *softdec);
  float codec2_get_energy(CODEC2 *codec2_state, const unsigned char *bits);

  # support for ML and VQ experiments
  void codec2_open_mlfeat(CODEC2 *codec2_state, char *feat_filename, char *model_filename);
  void codec2_load_codebook(CODEC2 *codec2_state, int num, char *filename);
  float codec2_get_var(CODEC2 *codec2_state);
  float *codec2_enable_user_ratek(CODEC2 *codec2_state, int *K);

  # 700C post filter and equaliser
  void codec2_700c_post_filter(CODEC2 *codec2_state, int en);
  void codec2_700c_eq(CODEC2 *codec2_state, int en);
