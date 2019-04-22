#include "CStbImage.h"

#define STB_IMAGE_IMPLEMENTATION
#include "stb_image.h"
#define STB_IMAGE_WRITE_IMPLEMENTATION
#include "stb_image_write.h"

unsigned char* load_image(const char* path, int* width, int* height, int* channels, int desired_channels){
    stbi_uc* pixels = stbi_load(path, width, height, channels, desired_channels);
    return pixels;
}

void free_image(void* pixels){
    stbi_image_free(pixels);
}

int write_image_bmp(const char* path, int width, int height, int bpp, const void* data) {
    return stbi_write_bmp(path, width, height, bpp, data);
}

int write_image_jpg(const char* path, int width, int height, int bpp, const void* data, int quality) {
    return stbi_write_jpg(path, width, height, bpp, data, quality);
}

int write_image_png(const char* path, int width, int height, int bpp, const void* data) {
    return stbi_write_png(path, width, height, bpp, data, width*bpp);
}
