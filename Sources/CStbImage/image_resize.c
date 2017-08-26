
#include "CStbImage.h"

#define STB_IMAGE_RESIZE_IMPLEMENTATION
#include "stb_image_resize.h"

int resize_uint8(const unsigned char* in, int in_w, int in_h,
                 unsigned char* out, int out_w, int out_h, int num_channels) {
    return stbir_resize_uint8(in, in_w, in_h, 0, out, out_w, out_h, 0, num_channels);
}

int resize_float(const float* in, int in_w, int in_h,
                 float* out, int out_w, int out_h, int num_channels) {
    return stbir_resize_float(in, in_w, in_h, 0, out, out_w, out_h, 0, num_channels);
}
