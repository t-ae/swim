#if canImport(TensorFlow)

import TensorFlow

extension Tensor where Scalar: DataType {
    /// Create image tensor which has shape `[image.height, image.width]`.
    public init(image: Image<Gray, Scalar>) {
        self.init(shape: [image.height, image.width], scalars: image.data)
    }
    
    /// Create image tensor which has shape `[image.height, image.width, 3]`.
    public init(image: Image<RGB, Scalar>) {
        self.init(shape: [image.height, image.width, 3], scalars: image.data)
    }
    
    /// Create image tensor which has shape `[image.height, image.width, 4]`.
    public init(image: Image<RGBA, Scalar>) {
        self.init(shape: [image.height, image.width, 4], scalars: image.data)
    }
    
    /// Create image tensor which has shape `[image.height, image.width, 4]`.
    public init(image: Image<ARGB, Scalar>) {
        self.init(shape: [image.height, image.width, 4], scalars: image.data)
    }
}

#endif
