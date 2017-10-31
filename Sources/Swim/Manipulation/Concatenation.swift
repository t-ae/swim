
extension Image {
    static func _concatH<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        let width = images.map { $0.width }.reduce(0, +)
        let height = images[0].height
        precondition(!images.contains { $0.height != height }, "Images must have same `height`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for i in images {
            image[cols: start..<start+i.width] = i
            start += i.width
        }
        
        return image
    }
    
    public static func concatH<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        return _concatH(images)
    }
}

extension Image {
    static func _concatV<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        let width = images[0].width
        let height = images.map { $0.height }.reduce(0, +)
        precondition(!images.contains { $0.width != width }, "Images must have same `width`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for i in images {
            image[rows: start..<start+i.height] = i
            start += i.height
        }
        
        return image
    }
    
    public static func concatV<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        return _concatV(images)
    }
}


