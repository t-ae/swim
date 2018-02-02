# Swim
Image library for Swift.

## Generics
```swift
Image<P: PixelType, T: DataType>
```

Supported types  
PixelType: `Intensity`, `IntensityAlpha`, `RGB`, `RGBA`, `ARGB`  
DataType: `Bool`, `UInt8`, `Int`, `Float`, `Double`  

## Creation
```swift
let data = [UInt8](repeating: 0, count: 3*4*5)
let image = Image<RGBA, UInt8>(width: 3, height: 5, data: data)

// Can use type inference
let intensity = Image(width: 3, height: 20, intensity: data)
let rgb = Image(width: 4, height: 5, rgb: data)
let rgba = Image(width: 3, height: 5, rgba: data)
let argb = Image(width: 5, height: 3, argb: data)
```

## Save/Load image
```swift
let image = Image<RGBA, UInt8>(contentsOf: url)!
try? image.write(path: dstPath, type: .png)
```
## Subscriptions
### Pixel manipulation
```swift
let image = Image<RGBA, UInt8>(contentsOf: url)!
let px: Pixel<RGBA, UInt8> = image[0, 0]
let red: UInt8 = image[0, 0, 0] // red channel of (x: 0, y: 0)
let red2: UInt8 = image[0, 0, .red] // ditto
let red3: UInt8 = image[0, 0][.red] // ditto

image[1, 0, 1] += 1
```

### Subimage
```swift
let image = Image<RGBA, UInt8>(contentsOf: url)!
let sub1: Image<RGBA, UInt8> = image[0..<100, 0..<100]
let sub2: Image<RGBA, UInt8> = image[rows: 0..<100]
image[col: 2] += 1
```

### Channel extraction
```swift
let image = Image<RGBA, UInt8>(contentsOf: url)!
let red: Image<Intensity, UInt8> = image[channel: 0]
image[channel: .blue] += 1
```

## Conversion

```swift
let image = Image<RGB, Float>(contentsOf: url)!

// to gray scale
let brightness: Image<Intensity, Float> = image.toBrightness()
let luminance: Image<Intensity, Float> = image.toLuminance()

// type conversion
let doubleImage = image.typeConverted(to: Double.self)
let doubleImage2: Image<RGB, Double> = image.typeConverted() // type inference

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
let image1 = Image<Intensity, Float>(contentsOf: url1)!
let image2 = Image<Intensity, Float>(contentsOf: url2)!

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
let image = Image<Intensity, Float>(contentsOf: url)!
let integral = image.toIntegralImage()
```

### Convolution/Filter

```swift 
let image = Image<Intensity, Float>(contentsOf: url)!
let blur = image.convoluted(Filter.gaussian3x3)
let maximum = image.maximumFilter(kernelSize: 3)
```

[VisualTests.swift](https://github.com/t-ae/swim/blob/master/Tests/SwimTests/VisualTests.swift) contains examples.