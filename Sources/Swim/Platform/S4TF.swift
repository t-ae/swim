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

extension Image where P == Gray, T: TensorFlowScalar {
    /// Create image from tensor.
    /// - Parameters:
    ///   - tensor: Image tensor which has shape [height, width] or [height, width, 1].
    public init(tensor: Tensor<T>) {
        precondition(tensor.rank == 2 || (tensor.rank == 3 && tensor.shape[2] == 1),
                     "Invalid tensor shape: \(tensor.shape)")
        let width = tensor.shape[1]
        let height = tensor.shape[0]
        self.init(width: width, height: height, data: tensor.scalars)
    }
}

extension Image where P == RGB, T: TensorFlowScalar {
    /// Create image from tensor.
    /// - Parameters:
    ///   - tensor: Image tensor which has shape [height, width, 3].
    public init(tensor: Tensor<T>) {
        precondition(tensor.rank == 3 && tensor.shape[2] == 3, "Invalid tensor shape: \(tensor.shape)")
        let width = tensor.shape[1]
        let height = tensor.shape[0]
        self.init(width: width, height: height, data: tensor.scalars)
    }
}

extension Image where P == RGBA, T: TensorFlowScalar {
    /// Create image from tensor.
    /// - Parameters:
    ///   - tensor: Image tensor which has shape [height, width, 4].
    public init(tensor: Tensor<T>) {
        precondition(tensor.rank == 3 && tensor.shape[2] == 4, "Invalid tensor shape: \(tensor.shape)")
        let width = tensor.shape[1]
        let height = tensor.shape[0]
        self.init(width: width, height: height, data: tensor.scalars)
    }
}

extension Image where P == ARGB, T: TensorFlowScalar {
    /// Create image from tensor.
    /// - Parameters:
    ///   - tensor: Image tensor which has shape [height, width, 3].
    public init(tensor: Tensor<T>) {
        precondition(tensor.rank == 3 && tensor.shape[2] == 4, "Invalid tensor shape: \(tensor.shape)")
        let width = tensor.shape[1]
        let height = tensor.shape[0]
        self.init(width: width, height: height, data: tensor.scalars)
    }
}

#endif
