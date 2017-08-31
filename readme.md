# Swim
Image library for Swift.

## Generics
```swift
Image<P: PixelType, T: DataType>
```

Supported types  
PixelType: `Intensity`, `RGB`, `RGBA`, `ARGB`  
DataType: `UInt8`, `Int`, `Float`, `Double`  

## Save/Load image
```swift
let image = Image<RGBA, UInt8>(path: path)!
try? image.write(path: dstPath, type: .png)
```

## Pixel manipulation
```swift
let image = Image<RGBA, UInt8>(path: path)!
image[0, 0] // Pixel<RGBA, UInt8> of (x: 0, y: 0)
image[0, 0, 0] // red channel of (x: 0, y: 0)
image[0, 0][.red] // ditto

image[1, 0, 1] += 1
```

## Subimage
```swift
let image = Image<RGBA, UInt8>(path: path)!
image[0..<100, 0..<100]
image[rows: 0..<100]
image[col: 2] += 1
```

## Channel extraction
```swift
let image = Image<RGBA, UInt8>(path: path)!
image[channel: 0] // Image<Intensity, UInt8> of red channel
image[channel: .blue] += 1
```