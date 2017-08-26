#ifndef CStbImage_h
#define CStbImage_h

#ifdef __cplusplus
extern "C" {
#endif
    
    // IO
    unsigned char* load_image(const char* path, int* width, int* height, int* bpp, int desired_bpp);
    void free_image(unsigned char* pixels);
    
    int write_image_bmp(const char* path, int width, int height, int bpp, const void* data);
    int write_image_jpg(const char* path, int width, int height, int bpp, const void* data);
    int write_image_png(const char* path, int width, int height, int bpp, const void* data);
    
    // Resize
    int resize_uint8(const unsigned char* in, int in_w, int in_h,
                     unsigned char* out, int out_w, int out_h, int num_channels);
    int resize_float(const float* in, int in_w, int in_h,
                     float* out, int out_w, int out_h, int num_channels);

#ifdef __cplusplus
}
#endif

#endif
