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

    typedef void write_func(void *context, void *data, int size);
    int write_image_bmp_to_func(write_func* func, void* context, int width, int height, int bpp, const void* data);
    int write_image_jpg_to_func(write_func* func, void* context, int width, int height, int bpp, const void* data, int quality);
    int write_image_png_to_func(write_func* func, void* context, int width, int height, int bpp, const void* data);

    // Text
    int get_number_of_fonts(const unsigned char* bytes);
    int init_font(stbtt_fontinfo* info, const unsigned char* bytes, int index);
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
