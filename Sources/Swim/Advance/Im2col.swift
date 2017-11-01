
public enum Padding<T: DataType> {
    case nearest
    case constant(T)
}

extension Image where P == Intensity {
    func _im2col(patchWidth: Int,
                 patchHeight: Int,
                 padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        
        var ret: [T] = []
        ret.reserveCapacity(width*height)
        
        let padTop = (patchHeight-1) / 2
        let padLeft = (patchWidth-1) / 2
        
        for dy in 0..<patchHeight {
            for dx in 0..<patchWidth {
                for y in 0..<height {
                    let yy = y + dy - padTop
                    for x in 0..<width {
                        let xx = x + dx - padLeft
                        if 0..<width ~= xx && 0..<height ~= yy {
                            ret.append(self[xx, yy])
                        } else {
                            switch padding {
                            case .nearest:
                                let xx = min(max(xx, 0), width-1)
                                let yy = min(max(yy, 0), height-1)
                                ret.append(self[xx, yy])
                            case .constant(let v):
                                ret.append(v)
                            }
                        }
                    }
                }
            }
        }
        
        return (patchWidth*patchHeight, width*height, ret)
    }
    
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}
