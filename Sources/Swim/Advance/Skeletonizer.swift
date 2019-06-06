import Foundation

public enum Skeletonizer {
    /// Skeletonize binary image with Zhang-Suen algorithm.
    @inlinable
    public static func skeletonize(image: Image<Gray, Bool>) -> Image<Gray, Bool> {
        var newImage = image.withPadding(1, edgeMode: .constant(value: false))
        
        var phase = true
        while true {
            var removeTable = Image.full(value: true, like: newImage)
            
            for pixel in newImage.pixels(in: 1..<newImage.width-1, 1..<newImage.height-1) {
                guard pixel[.gray] else {
                    continue
                }
                
                let (x, y) = (pixel.x, pixel.y)
                
                // 701
                // 6*2
                // 543
                let neighbors = [newImage[x, y-1, .gray], newImage[x+1, y-1, .gray],
                                 newImage[x+1, y, .gray], newImage[x+1, y+1, .gray],
                                 newImage[x, y+1, .gray], newImage[x-1, y+1, .gray],
                                 newImage[x-1, y, .gray], newImage[x-1, y-1, .gray]]
                
                let trues = neighbors.filter { $0 }.count
                guard 2 <= trues && trues <= 6 else {
                    continue
                }
                
                var list = neighbors
                list.append(neighbors.first!)
                
                let f2t = zip(list, list.dropFirst()).filter { !$0.0 && $0.1 }.count
                guard f2t == 1 else {
                    continue
                }
                
                if phase {
                    guard !neighbors[0] || !neighbors[2] || !neighbors[4] else {
                        continue
                    }
                    
                    guard !neighbors[2] || !neighbors[4] || !neighbors[6] else {
                        continue
                    }
                } else {
                    guard !neighbors[0] || !neighbors[2] || !neighbors[6] else {
                        continue
                    }
                    
                    guard !neighbors[0] || !neighbors[4] || !neighbors[6] else {
                        continue
                    }
                }
                
                removeTable[x, y, .gray] = false
            }
            
            newImage &= removeTable
            phase.toggle()
            
            guard removeTable.hasFalse() else {
                break
            }
        }
        
        return newImage[1..<newImage.width-1, 1..<newImage.height-1]
    }
}
