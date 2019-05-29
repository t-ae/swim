import XCTest
@testable import SwimTests

XCTMain([
    // AdvanceTests
    testCase(BayerTests.allTests),
    testCase(CorrelationTests.allTests),
    testCase(Im2colTests.allTests),
    testCase(IntegralImageTests.allTests),
    // ArithmeticTests
    testCase(ImageArithmeticTests.allTests),
    testCase(PixelRefArithmeticTests.allTests),
    testCase(ColorArithmeticTests.allTests),
    // BooleanTests
    testCase(BitOperationsTests.allTests),
    // ConversionTests
    testCase(ChannelCompositionTests.allTests),
    testCase(ChannelwiseConversionTests.allTests),
    testCase(DataTypeConversionTests.allTests),
    testCase(PixelTypeConversionTests.allTests),
    testCase(PixelwiseConversion.allTests),
    // CoreTests
    testCase(ImageTests.allTests),
    testCase(LikeInitializerTests.allTests),
    testCase(PixelIteratorTests.allTests),
    // DrawTests
    testCase(DrawRectTests.allTests),
    // FilterTests
    testCase(ConvolutionTests.allTests),
    testCase(FilterTests.allTests),
    // IOTests
    testCase(ImageIOTests.allTests),
    // InterpolationTests
    testCase(BicubicInterpolationTests.allTests),
    testCase(BilinearInterpolationTests.allTests),
    testCase(NearestNeighborInterpolatorTests.allTests),
    // ManipulationTests
    testCase(AbsTests.allTests),
    testCase(ClipTests.allTests),
    testCase(PowerTests.allTests),
    testCase(RoundingTests.allTests),
    // SubscriptTests
    testCase(ChannelSubscriptTests.allTests),
    testCase(PixelSubscriptTests.allTests),
    testCase(SubimageSubscriptTests.allTests),
    // TransformationTests
    testCase(AffineTransformationTests.allTests),
    testCase(EdgeModeTests.allTests),
    testCase(PaddingTests.allTests),
    testCase(ProjectiveTransformationTests.allTests),
    testCase(ResizeTests.allTests),
    testCase(TransformationTests.allTests),
    testCase(TransformationTests.allTests),
    // UtilityTests
    testCase(ClampTests.allTests),
])
