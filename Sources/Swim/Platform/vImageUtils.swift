
#if os(macOS) || os(iOS)
    import Accelerate
    
    public enum vImageUtils {
    }
    
    // MARK: - vImage_Buffer
    extension vImageUtils{
        // MARK: UInt8
        public static func withBuffer(_ image: inout Image<Intensity, UInt8>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<UInt8>.size * image.width * Intensity.channels)
                closure(&buffer)
            }
        }
        
        public static func withBuffer(_ image: inout Image<RGBA, UInt8>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<UInt8>.size * image.width * RGBA.channels)
                closure(&buffer)
            }
        }
        
        public static func withBuffer(_ image: inout Image<ARGB, UInt8>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<UInt8>.size * image.width * ARGB.channels)
                closure(&buffer)
            }
        }
    
        // MARK: Float
        public static func withBuffer(_ image: inout Image<Intensity, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * Intensity.channels)
                closure(&buffer)
            }
        }

        public static func withBuffer(_ image: inout Image<RGBA, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * RGBA.channels)
                closure(&buffer)
            }
        }
        
        public static func withBuffer(_ image: inout Image<ARGB, Float>,
                                      closure: (inout vImage_Buffer)->Void) {
            image.data.withUnsafeMutableBufferPointer {
                var buffer = vImage_Buffer(data: $0.baseAddress!,
                                           height: UInt(image.height),
                                           width: UInt(image.width),
                                           rowBytes: MemoryLayout<Float>.size * image.width * ARGB.channels)
                closure(&buffer)
            }
        }
    }
    
    // MARK: - AlphaBlend
    extension vImageUtils{
        // MARK: UInt8
        public static func alphaBlend(top: inout Image<ARGB, UInt8>,
                                      bottom: inout Image<ARGB, UInt8>) -> Image<ARGB, UInt8> {
            precondition(top.width == bottom.width && top.height == bottom.height)
            
            let width = top.width
            let height = top.height
            
            var memory = [UInt8](repeating: 0, count: width*height*ARGB.channels)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(height),
                                     width: UInt(width),
                                     rowBytes: MemoryLayout<UInt8>.size*width)
            
            withBuffer(&top) { (srcTop: inout vImage_Buffer) -> Void in
                withBuffer(&bottom) { (srcBottom: inout vImage_Buffer) -> Void in
                    vImageAlphaBlend_ARGB8888(&srcTop, &srcBottom, &dest, 0)
                }
            }
            
            return Image(width: width, height: height, data: memory)
        }
        
        // MARK: Float
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
                    vImageAlphaBlend_ARGBFFFF(&srcTop, &srcBottom, &dest, 0)
                }
            }
            
            return Image(width: width, height: height, data: memory)
        }
    }
    
    // MARK: - Dilate
    extension vImageUtils {
        // MARK: UInt8
        public static func dilate(src: inout Image<Intensity, UInt8>,
                                  kernel: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return dilate(src: &src, roi: roi, kernel: kernel)
        }
        
        public static func dilate(src: inout Image<Intensity, UInt8>,
                                  roi: Rect,
                                  kernel: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
            
            var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<UInt8>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageDilate_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                     kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
        
        // MARK: Float
        public static func dilate(src: inout Image<Intensity, Float>,
                                  kernel: Image<Intensity, Float>) -> Image<Intensity, Float> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return dilate(src: &src, roi: roi, kernel: kernel)
        }
        
        public static func dilate(src: inout Image<Intensity, Float>,
                                  roi: Rect,
                                  kernel: Image<Intensity, Float>) -> Image<Intensity, Float> {
            
            var memory = [Float](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<Float>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageDilate_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                     kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
    }
    
    // MARK: - Erode
    extension vImageUtils {
        // MARK: UInt8
        public static func erode(src: inout Image<Intensity, UInt8>,
                                  kernel: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return dilate(src: &src, roi: roi, kernel: kernel)
        }
        
        public static func erode(src: inout Image<Intensity, UInt8>,
                                  roi: Rect,
                                  kernel: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
            
            var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<UInt8>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageErode_Planar8(&src, &dest, UInt(roi.x), UInt(roi.y),
                                    kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
        
        // MARK: Float
        public static func erode(src: inout Image<Intensity, Float>,
                                  kernel: Image<Intensity, Float>) -> Image<Intensity, Float> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return dilate(src: &src, roi: roi, kernel: kernel)
        }
        
        public static func erode(src: inout Image<Intensity, Float>,
                                  roi: Rect,
                                  kernel: Image<Intensity, Float>) -> Image<Intensity, Float> {
            
            var memory = [Float](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<Float>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageErode_PlanarF(&src, &dest, UInt(roi.x), UInt(roi.y),
                                    kernel.data, UInt(kernel.height), UInt(kernel.width), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
    }
    
    // MARK: - Max
    extension vImageUtils {
        // MARK: UInt8
        public static func max(src: inout Image<Intensity, UInt8>,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, UInt8> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
        }
        
        public static func max(src: inout Image<Intensity, UInt8>,
                               roi: Rect,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, UInt8> {
            
            var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<UInt8>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageMax_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                  UInt(kernelHeight), UInt(kernelWidth), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
        
        // MARK: Float
        public static func max(src: inout Image<Intensity, Float>,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, Float> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return max(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
        }
        
        public static func max(src: inout Image<Intensity, Float>,
                               roi: Rect,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, Float> {
            
            var memory = [Float](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<Float>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageMax_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                  UInt(kernelHeight), UInt(kernelWidth), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
    }

    // MARK: - Min
    extension vImageUtils {
        // MARK: UInt8
        public static func min(src: inout Image<Intensity, UInt8>,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, UInt8> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
        }
        
        public static func min(src: inout Image<Intensity, UInt8>,
                               roi: Rect,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, UInt8> {
            
            var memory = [UInt8](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<UInt8>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageMin_Planar8(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                  UInt(kernelHeight), UInt(kernelWidth), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
        
        // MARK: Float
        public static func min(src: inout Image<Intensity, Float>,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, Float> {
            let roi = Rect(x: 0, y: 0, width: src.width, height: src.height)
            return min(src: &src, roi: roi, kernelWidth: kernelWidth, kernelHeight: kernelHeight)
        }
        
        public static func min(src: inout Image<Intensity, Float>,
                               roi: Rect,
                               kernelWidth: Int,
                               kernelHeight: Int) -> Image<Intensity, Float> {
            
            var memory = [Float](repeating: 0, count: roi.width * roi.height)
            var dest = vImage_Buffer(data: &memory,
                                     height: UInt(roi.height),
                                     width: UInt(roi.width),
                                     rowBytes: MemoryLayout<Float>.size*roi.width)
            
            withBuffer(&src) { (src: inout vImage_Buffer) -> Void in
                vImageMin_PlanarF(&src, &dest, nil, UInt(roi.x), UInt(roi.y),
                                  UInt(kernelHeight), UInt(kernelWidth), 0)
            }
            
            return Image(width: roi.width, height: roi.height, data: memory)
        }
    }

#endif
