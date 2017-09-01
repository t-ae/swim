
import Foundation

struct Template<T: DataType> {
    let image: Image<Intensity, T>
    let mask: Image<Intensity, Bool>
    
    init(image: Image<Intensity, T>, mask: Image<Intensity, Bool>) {
        self.image = image
        self.mask = mask
    }
    
    init(image: Image<Intensity, T>) {
        let mask = Image<Intensity, Bool>(width: image.width,
                                          height: image.height,
                                          data: [Bool](repeating: true, count: image.data.count))
        self.init(image: image, mask: mask)
    }
}
