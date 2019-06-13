# Swim
Cross platform image library for Swift.

## API

### Generic `Image` type
```swift
struct Image<P: PixelType, T: DataType>
```

#### Supported types
`PixelType`: `Gray`, `GrayAlpha`, `RGB`, `RGBA`, `ARGB`  
`DataType`: `Bool`, `UInt8`, `Int`, `Float`, `Double`  

Some functions assume pixel values are:
- in  [0, 255] range if `DataType` is integer.
- in [0, 1] range if `DataType` is floating point.

### Creation
```swift
let image = Image<RGBA, UInt8>(width: 3, height: 5, data: uint8Array)

// Can use type inference
let gray = Image(width: 3, height: 20, gray: intArray)
let rgb = Image(width: 4, height: 5, rgb: floatArray)
let rgba = Image(width: 3, height: 5, rgba: doubleArray)
let argb = Image(width: 5, height: 3, argb: uint8Array)

// Filled with values/colors
let zero = Image<RGBA, Double>(width: 3, height: 4, value: 0)
let red = Image<RGBA, Double>(width: 3, height: 5, color: Color(r: 1, g: 0, b: 0, a: 1))
```

### Save/Load image
```swift
let image = try Image<RGBA, UInt8>(contentsOf: url)
try image.write(path: dstPath)
```

For reading and writing image, Swim uses [stb_image.h](https://github.com/nothings/stb/blob/master/stb_image.h) and [stb_image_write.h](https://github.com/nothings/stb/blob/master/stb_image_write.h).

### Convertible from/to CoreGraphics image types
```swift
let image = try! Image<RGBA, UInt8>(contentsOf: url)

// on macOS
let nsImage = image.nsImage()
let imageFromNS = Image<RGBA, UInt8>(nsImage: nsImage)!

// on iOS
let uiImage = image.uiImage()
let imageFromUI = Image<RGBA, UInt8>(uiImage: uiImage)!
```

### Subscriptions
#### Pixel manipulation
```swift
let image = try Image<RGBA, UInt8>(contentsOf: url)
let color: Color<RGBA, UInt8> = image[0, 0]
let red: UInt8 = image[0, 0, 0] // red channel of (x: 0, y: 0)
let red2: UInt8 = image[0, 0, .red] // ditto
let red3: UInt8 = image[0, 0][.red] // ditto

image[1, 0] += 1 // Add 1 for each channel
image[1, 0, .green] += 1 // Add 1 for Green channel
```

#### Subimage
```swift
let image = try Image<RGBA, UInt8>(contentsOf: url)
let sub1: Image<RGBA, UInt8> = image[0..<100, 0..<100]
let sub2: Image<RGBA, UInt8> = image[rows: 0..<100]
image[col: 2] += 1
```

#### Channel extraction
```swift
let image = try Image<RGBA, UInt8>(contentsOf: url)
let red: Image<Gray, UInt8> = image[channel: 0]
image[channel: .blue] += 1
```

### Conversion

```swift
let image = try Image<RGB, Float>(contentsOf: url)

// to gray scale
let gray1: Image<Gray, Float> = image.toGray() // with default weights
let gray2: Image<Gray, Float> = image.toGray(wr: 1/3, wg: 1/3, wb: 1/3) // with specified weights

// type conversion
let doubleImage1: Image<RGB, Double> = image.cast()
let doubleImage2 = image.cast(to: Double.self) // ditto

// pixel conversion
let redOnlyRGBA: Image<RGBA, Float> = image.pixelwiseConverted { src, dst in 
    dst[.red] = src[.red]
    dst[.green] = 0
    dst[.blue] = 0
    dst[.alpha] = 1
}
```

### Drawing

```swift
var image = try Image<RGB, Float>(contentsOf: url)

image.drawLine((0, 0), (100, 120), color: Color(r: 1, g: 0, b: 0))
image.drawRect(10..<20, 30..<50, color: .green)
image.drawCircle(center: (50, 50), radius: 30, color: .blue)

image.drawImage(origin: (80, 80), rgbImage) // simply overwrites
image.drawImage(origin: (200, 200), rgbaImage) // with alpha blending

let font = try! TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), 
                             fontSize: 30)
image.drawText(origin: (100, 100),
               text: "TEXT DRAWING", 
               font: font, 
               color: .black)
```

For font rendering, Swim uses [stb_truetype.h](https://github.com/nothings/stb/blob/master/stb_truetype.h).

### Resize
```swift 
let image = try Image<RGB, Float>(contentsOf: url)
let resizedBL = image.resize(width: 512, height: 512) // default .bilinear
let resizedNN = image.resize(width: 512, height: 512, method: .nearestNeighbor)
let resizedBC = image.resize(width: 512, height: 512, method: .bicubic)
let resizedAA = image.resize(width: 512, height: 512, method: .areaAverage)
```

[Example: NearestNeighbor / Bilinear / Bicubic / Lanczos2 / Lanczos3 / Area Average](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/ResizeVisualTests.swift#L29-L49)

![resize](https://user-images.githubusercontent.com/12446914/58522331-c2b59d00-81fa-11e9-9d13-801c9e28c6c3.png)

### Warp
```swift
let image = try Image<RGBA, Double>(contentsOf: url)
let affine = AffineTransformation<Double>(scale: (1, 1.5), rotation: .pi/6. translation: (100, 120))
// `edgeMode` specifies how to fill pixels outside the base image.
let interpolator = BilinearInterpolator<RGBA, Double>(edgeMode: .edge)
let warpedImage = image.warp(transformation: affine, outputSize: (500, 500), interpolator: interpolator)
```

[Example: NN+Wrap / BL+Constant / BC+Reflect / Lanczos2+Edge / Lanczos3+Symmetric](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/WarpVisualTests.swift#L216-L258)

![warp](https://user-images.githubusercontent.com/12446914/58522375-09a39280-81fb-11e9-9229-3478797c26e8.png)

### Correlation
```swift
let image1 = try Image<Gray, Float>(contentsOf: url1)
let image2 = try Image<Gray, Float>(contentsOf: url2)

let ssd = Correlation.ssd(image1, image2)
let sad = Correlation.sad(image1, image2)
let ncc = Correlation.ncc(image1, image2)
let zncc = Correlation.zncc(image1, image2)
```

### Blending
```swift
var bottomImage = try Image<RGB, Float>(contentsOf: url1)
let topimage = try Image<RGB, Float>(contentsOf: url2)

bottomImage(image: topImage, mode: .multiply)
bottomImage(image: topImage, mode: .additive)
bottomImage(image: topImage, mode: .screen)
bottomImage(image: topImage, mode: .overlay)
```

[Example: Multiply / Additive / Screen / Overlay](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/BlendVisualTests.swift#L10-L25)

![blend](https://user-images.githubusercontent.com/12446914/58079157-54198380-7beb-11e9-93dd-ac5dac2b12d3.png)

### Integral image
```swift 
let image = try Image<Gray, Float>(contentsOf: url)
let integral = IntegralImageConverter.convert(image: image)
```

### Convolution/Filter

```swift 
let image = try Image<Gray, Float>(contentsOf: url)
let blur = image.convoluted(Filter.gaussian3x3)
let maximum = image.rankFilter(.maximum, windowSize: 3)
let bilateral = image.bilateralFilter(windowSize: 5, distanceSigma: 1, valueSigma: 0.1)
let nlmean = image.nonLocalMeanFilter(windowSize: 5, distance: 2, sigma: 0.1)
```

[Example: Gaussian x10 / Bilateral x5 / Emboss / Sobel(Horizontal) / Laplacian](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/FilterVisualTests.swift#L133-L163)

![filter](https://user-images.githubusercontent.com/12446914/58389904-4b043880-8069-11e9-8555-c84be376da9b.png)

### Fast Fourier transformation

```swift
let image = try Image<Gray, Double>(contentsOf: url)
// image size must be power of 2
let transformed: Image<GrayAlpha, Double> = FourierTransformer.fft(image: image)
let inverted: Image<Gray, Double> = FourierTransformer.ifft(image: transformed)
```

[Example: Spectrum and inverted image / Low-pass filtered / High-pass filtered](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/FourierTransformerVisualTests.swift#L10-L74)

![fft](https://user-images.githubusercontent.com/12446914/57998357-109c1800-7b0c-11e9-818b-600f75485794.png)


### Histogram equalization

```swift
var image = try Image<Gray, Double>(contentsOf: url)
Histograms.equalize(image: &image)
```

[Example: Before / After](https://github.com/t-ae/swim/blob/fc1cac179d957f0ce0190ef8af9a50a3aa03c2da/Tests/VisualTests/HistogramsVisualTests.swift#L18-L36)

![hist](https://user-images.githubusercontent.com/12446914/58690827-6d79b700-83c5-11e9-9602-a3c8ea4a0fe1.png)


### Bayer filter
```swift 
let image = try Image<RGB, Float>(contentsOf: url)
let converter = BayerConverter(pattern: .bggr)
let bayer = converter.convert(image: image)
let reconstruct = converter.demosaic(image: bayer)
```

[Example: Base / Bayer format / Reconstructed](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/BayerVisualTests.swift#L12-L28)

![bayer_bggr](https://user-images.githubusercontent.com/12446914/56634959-cce5f800-669e-11e9-89a2-ce49121a44bc.png)

## Application exapmles

- [Template matching](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/ApplicationVisualTests.swift#L340-L414)
- [Canny edge detection](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/ApplicationVisualTests.swift#L226-L338)
- [Dithering](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/ApplicationVisualTests.swift#L416-L456)
- [Color quantization using k-means](https://github.com/t-ae/swim/blob/99e7be2655057190b62426cdb85fe56b130d7126/Tests/VisualTests/ApplicationVisualTests.swift#L481-L556)

[VisualTests](https://github.com/t-ae/swim/blob/master/Tests/VisualTests) contains more examples (works only on macOS).

## License

[The MIT License](https://github.com/t-ae/swim/blob/master/LICENSE)
