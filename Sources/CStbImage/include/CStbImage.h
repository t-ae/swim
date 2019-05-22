#ifndef CStbImage_h
#define CStbImage_h

#import "stb_truetype.h"

#ifdef __cplusplus
extern "C" {
#endif
    
    // IO
    unsigned char* load_image(const char* path, int* width, int* height, int* channels, int desired_channels);
    float* load_image_float(const char* path, int* width, int* height, int* channels, int desired_channels);
    void free_image(void* pixels);
    
    int write_image_bmp(const char* path, int width, int height, int bpp, const void* data);
    int write_image_jpg(const char* path, int width, int height, int bpp, const void* data, int quality);
    int write_image_png(const char* path, int width, int height, int bpp, const void* data);

    // Text
    int init_font(stbtt_fontinfo* info, const unsigned char* bytes);
    float get_scale_for_pixel_height(const stbtt_fontinfo info, int height);
    void get_vmetrics(const stbtt_fontinfo info, int* ascent, int* descent, int* lineGap);
    void get_hmetrics(const stbtt_fontinfo info, int codepoint, int* advanceWidth, int* leftSideBearing);
    void get_codepoint_bitmap_box(const stbtt_fontinfo info, int codepoint, float scale,
                                  int* ix0, int* iy0, int* ix1, int* iy1);
    void make_codepoint_bitmap(const stbtt_fontinfo info, unsigned char * output,
                               int out_w, int out_h, int out_stride,
                               float scale, int codepoint);
    int get_kern(const stbtt_fontinfo info, int codepoint1, int codepoint2);
    
#ifdef __cplusplus
}
#endif

#endif
