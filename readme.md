# Swim
Image library for Swift.

## Generics
```swift
Image<P: PixelType, T: DataType>
```

Supported types  
PixelType: `Intensity`, `IntensityAlpha`, `RGB`, `RGBA`, `ARGB`  
DataType: `Bool`, `UInt8`, `Int`, `Float`, `Double`  

## Save/Load image
```swift
let image = Image<RGBA, UInt8>(path: path)!
try? image.write(path: dstPath, type: .png)
```
## Subscriptions
### Pixel manipulation
```swift
let image = Image<RGBA, UInt8>(path: path)!
let px: Pixel<RGBA, UInt8> = image[0, 0]
let red: UInt8 = image[0, 0, 0] // red channel of (x: 0, y: 0)
let red2: UInt8 = image[0, 0][.red] // ditto

image[1, 0, 1] += 1
```

### Subimage
```swift
let image = Image<RGBA, UInt8>(path: path)!
let sub1: Image<RGBA, UInt8> = image[0..<100, 0..<100]
let sub2: Image<RGBA, UInt8> = image[rows: 0..<100]
image[col: 2] += 1
```

### Channel extraction
```swift
let image = Image<RGBA, UInt8>(path: path)!
let red: Image<Intensity, UInt8> = image[channel: 0] // red channel
image[channel: .blue] += 1
```

## Conversion

```swift
let image = Image<RGB, Float>(path: path)!

// to gray scale
let brightness: Image<Intensity, Float> = image.toBrightness()
let luminance: Image<Intensity, Float> = image.toLuminance()

// type conversion
let doubleImage: Image<RGB, Double> = image.typeConverted(to: Double.self)

// pixel conversion
let red0 = image.converted { px in 
    var px = px
    px[.red] = 0
    return px
}
```

## Advanced

### Correlation
```swift
let image1 = Image<Intensity, Float>(path: path1)!
let image2 = Image<Intensity, Float>(path: path2)!

let ssd = Correlation.ssd(image1, image2)
let sad = Correlation.sad(image1, image2)
let ncc = Correlation.ncc(image1, image2)
let zncc = Correlation.zncc(image1, image2)
```

### Alpha blending
```swift
var imageBase = Image<RGB, Float>(width: 100,
                                  height: 100,
                                  data: [Float](repeating: 1, count: 100*100*3))
imageBase[30..<70, 20..<60].fill(Pixel(r: 1, g: 0, b: 0))

var imageGreen = Image<RGBA, Float>(width: 100,
                                    height: 100,
                                    data: [Float](repeating: 0, count: 100*100*4))
imageGreen[20..<60, 40..<80].fill(Pixel(r: 0, g: 1, b: 0, a: 0.5))

imageBase.alphaBlend(with: imageGreen)
```

### Integral image
```swift 
let image = Image<Intensity, Float>(path: path)!
let integral = image.toIntegralImage()
```

### Convolution/Filter

```swift 
let image = Image<Intensity, Float>(path: path)!
let blur = image.convoluted(Filter.gaussian3x3)
let maximum = image.maximumFilter(kernelSize: 3)
```

Visual examples in [VisualTests.swift](https://github.com/t-ae/swim/blob/master/Tests/SwimTests/VisualTests.swift)