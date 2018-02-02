
extension Image {
    static func _concatH<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        let width = images.map { $0.width }.reduce(0, +)
        let height = images[0].height
        precondition(images.all { $0.height == height }, "All images must have same `height`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for i in images {
            let cols: CountableRange<Int> = start..<start+i.width
            image[cols: cols] = i
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
        
        precondition(images.all { $0.width == width }, "All images must have same `width`.")
        
        var image = Image<P, T>(width: width, height: height)
        
        var start = 0
        for i in images {
            let rows = start..<start+i.height
            image[rows: rows] = i
            start += i.height
        }
        
        return image
    }
    
    public static func concatV<P, T>(_ images: [Image<P, T>]) -> Image<P, T> {
        return _concatV(images)
    }
}


