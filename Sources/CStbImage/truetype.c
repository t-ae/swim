#define STB_TRUETYPE_IMPLEMENTATION
#define STBTT_STATIC
#include "stb_truetype.h"

#include "CStbImage.h"

int get_number_of_fonts(const unsigned char* bytes) {
    return stbtt_GetNumberOfFonts(bytes);
}

int init_font(stbtt_fontinfo* info, const unsigned char* bytes, int index) {
    int offset = stbtt_GetFontOffsetForIndex(bytes, index);
    
    return stbtt_InitFont(info, bytes, offset);
}

void get_vmetrics(const stbtt_fontinfo info, int* ascent, int* descent, int* lineGap) {
    stbtt_GetFontVMetrics(&info, ascent, descent, lineGap);
}

void get_hmetrics(const stbtt_fontinfo info, int codepoint, int* advanceWidth, int* leftSideBearing) {
    stbtt_GetCodepointHMetrics(&info, codepoint, advanceWidth, leftSideBearing);
}

void get_codepoint_bitmap_box(const stbtt_fontinfo info, int codepoint, float scale,
                              int* ix0, int* iy0, int* ix1, int* iy1) {
    stbtt_GetCodepointBitmapBox(&info, codepoint, scale, scale, ix0, iy0, ix1, iy1);
}

void make_codepoint_bitmap(const stbtt_fontinfo info, unsigned char * output,
                           int out_w, int out_h, int out_stride,
                           float scale, int codepoint) {
    stbtt_MakeCodepointBitmap(&info, output, out_w, out_h, out_stride, scale, scale, codepoint);
}

int get_kern(const stbtt_fontinfo info, int codepoint1, int codepoint2) {
    return stbtt_GetCodepointKernAdvance(&info, codepoint1, codepoint2);
}
