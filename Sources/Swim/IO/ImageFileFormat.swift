import Foundation

public protocol ImageFileFormat {
    
}

extension Gray: ImageFileFormat {}
extension GrayAlpha: ImageFileFormat {}
extension RGB: ImageFileFormat {}
extension RGBA: ImageFileFormat {}
