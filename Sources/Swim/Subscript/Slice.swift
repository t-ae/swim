
extension Image {
    public subscript(xRange: CountableRange<Int>, yRange: CountableRange<Int>) -> ImageSlice<P, T> {
        let x = xRange.lowerBound
        let y = yRange.lowerBound
        let width = xRange.upperBound - x
        let height = yRange.upperBound - y
        
        return ImageSlice(image: self, x: x, y: y, width: width, height: height)
    }
}

extension Image {
    public subscript(rows rows: CountableRange<Int>) -> ImageSlice<P, T> {
        return self[0..<width, rows]
    }
    
    public subscript(cols cols: CountableRange<Int>) -> ImageSlice<P, T> {
        return self[cols, 0..<height]
    }
}
