
#if os(macOS) || os(iOS)

    import CoreGraphics
    
    extension Image where P == RGBA, T == UInt8 {
        public init?(cgImage: CGImage) {
            
            let width = cgImage.width
            let height = cgImage.height
            
            var data = [UInt8](repeating: 0, count: cgImage.bytesPerRow*height)
            let context = CGContext(data: &data,
                                    width: width,
                                    height: height,
                                    bitsPerComponent: 8,
                                    bytesPerRow: width*P.channels,
                                    space: CGColorSpaceCreateDeviceRGB(),
                                    bitmapInfo: CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue).rawValue)!
            context.clear(CGRect(x: 0, y: 0, width: width, height: height))
            context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
            
            self.init(width: cgImage.width, height: cgImage.height, data: data)
            
            // cancel premultiplication
            _unsafeConvert { x, y, px in
                let alpha = Int(px[P.alpha.rawValue])
                if alpha == 0 { return }
                for c in [P.red.rawValue, P.green.rawValue, P.blue.rawValue] {
                    px[c] = UInt8(255*Int(px[c]) / alpha)
                }
            }
        }
        
        public func cgImage() -> CGImage {
            
            let bitsPerComponent = MemoryLayout<T>.size * 8
            let bitsPerPixel = P.channels * bitsPerComponent
            let bytesPerRow = width * bitsPerPixel / 8
            
            let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue)
            
            let data = premultipliedImage()._data
            let cfData = CFDataCreate(nil, data, data.count)!
            let dataProvider = CGDataProvider(data: cfData)!
            
            return CGImage(width: width,
                           height: height,
                           bitsPerComponent: bitsPerComponent,
                           bitsPerPixel: bitsPerPixel,
                           bytesPerRow: bytesPerRow,
                           space: CGColorSpaceCreateDeviceRGB(),
                           bitmapInfo: bitmapInfo,
                           provider: dataProvider,
                           decode: nil,
                           shouldInterpolate: false,
                           intent: .defaultIntent)!
        }
        
        private func premultipliedImage() -> Image<P, T> {
            var newImage = self
            newImage._unsafeConvert { x, y, px in
                let alpha = Int(px[P.alpha.rawValue])
                for c in [P.red.rawValue, P.green.rawValue, P.blue.rawValue] {
                    px[c] = UInt8(Int(px[c]) * alpha / 255)
                }
            }
            return newImage
        }
    }
    
#endif
