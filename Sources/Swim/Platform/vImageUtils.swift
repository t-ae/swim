
#if os(macOS) || os(iOS)
    import Accelerate
    
    public enum vImageUtils {
    }
    
    extension vImageUtils{
        // MARK: vImage_Buffer
        public static func withBuffer(_ image: inout Image<Intensity, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.withUnsafeMutableBufferPointerToData {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * Intensity.channels)
                closure(&buffer)
            }
        }

        public static func withBuffer(_ image: inout Image<RGBA, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.withUnsafeMutableBufferPointerToData {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * RGBA.channels)
                closure(&buffer)
            }
        }
        
        public static func withBuffer(_ image: inout Image<ARGB, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.withUnsafeMutableBufferPointerToData {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * ARGB.channels)
                closure(&buffer)
            }
        }
    }
    
    extension vImageUtils{
        // MARK: - AlphaBlend
        public static func alphaBlend(top: inout Image<RGBA, Float>,
                                      bottom: inout Image<RGBA, Float>) -> Image<RGBA, Float> {
            precondition(top.width == bottom.width && top.height == bottom.height)
            
            let width = top.width
            let height = top.height
            
            var memory = [Float](repeating: 0, count: width*height*ARGB.channels)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(height),
                                     width: UInt(width),
                                     rowBytes: MemoryLayout<Float>.size*width)
            
            withBuffer(&top) { (srcTop: inout vImage_Buffer) -> Void in
                withBuffer(&bottom) { (srcBottom: inout vImage_Buffer) -> Void in
                    _ = vImageAlphaBlend_ARGBFFFF(&srcTop, &srcBottom, &dest, 0)
                }
            }
            
            return Image(width: width, height: height, data: memory)
        }
        
        public static func alphaBlend(top: inout Image<ARGB, Float>,
                                      bottom: inout Image<ARGB, Float>) -> Image<ARGB, Float> {
            precondition(top.width == bottom.width && top.height == bottom.height)
            
            let width = top.width
            let height = top.height
            
            var memory = [Float](repeating: 0, count: width*height*ARGB.channels)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(height),
                                     width: UInt(width),
                                     rowBytes: MemoryLayout<Float>.size*width)
            
            withBuffer(&top) { (srcTop: inout vImage_Buffer) -> Void in
                withBuffer(&bottom) { (srcBottom: inout vImage_Buffer) -> Void in
                    _ = vImageAlphaBlend_ARGBFFFF(&srcTop, &srcBottom, &dest, 0)
                }
            }
            
            return Image(width: width, height: height, data: memory)
        }
    }

#endif
