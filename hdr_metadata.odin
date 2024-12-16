package android

/**
 * These structures are used to define the display's capabilities for HDR content.
 * They can be used to better tone map content to user's display.
 */

/**
 * HDR metadata standards that are supported by Android.
 */
AHdrMetadataType :: enum u32 {
    HDR10_SMPTE2086 = 1,
    HDR10_CTA861_3 = 2,
    HDR10PLUS_SEI = 3,
}

/**
 * Color is defined in CIE XYZ coordinates.
 */
AColor_xy :: struct {
	x: f32,
    y: f32,
}

/**
 * SMPTE ST 2086 "Mastering Display Color Volume" static metadata
 */
AHdrMetadata_smpte2086 :: struct {
	displayPrimaryRed: AColor_xy,
    displayPrimaryGreen: AColor_xy,
    displayPrimaryBlue: AColor_xy,
    whitePoint: AColor_xy,
    maxLuminance: f32,
    minLuminance: f32,
}

/**
 * CTA 861.3 "HDR Static Metadata Extension" static metadata
 */
AHdrMetadata_cta861_3 :: struct {
	maxContentLightLevel: f32,
    maxFrameAverageLightLevel: f32,
}

