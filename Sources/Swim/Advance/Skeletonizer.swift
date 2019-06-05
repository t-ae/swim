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
                
                let list = [newImage[x, y-1, .gray], newImage[x+1, y-1, .gray],
                            newImage[x+1, y, .gray], newImage[x+1, y+1, .gray],
                            newImage[x, y+1, .gray], newImage[x-1, y+1, .gray],
                            newImage[x-1, y, .gray], newImage[x-1, y-1, .gray]]
                
                var list2 = list
                list2.append(list.first!)
                
                let f2t = zip(list2, list2.dropFirst()).filter { !$0.0 && $0.1 }.count
                guard f2t == 1 else {
                    continue
                }
                
                let trues = list.filter { $0 }.count
                guard 2 <= trues && trues <= 6 else {
                    continue
                }
                
                if phase {
                    guard !newImage[x, y-1, .gray] || !newImage[x+1, y, .gray] || !newImage[x, y+1, .gray] else {
                        continue
                    }
                    
                    guard !newImage[x+1, y, .gray] || !newImage[x, y+1, .gray] || !newImage[x-1, y, .gray] else {
                        continue
                    }
                } else {
                    guard !newImage[x, y-1, .gray] || !newImage[x+1, y, .gray] || !newImage[x-1, y, .gray] else {
                        continue
                    }
                    
                    guard !newImage[x, y-1, .gray] || !newImage[x, y+1, .gray] || !newImage[x-1, y, .gray] else {
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
