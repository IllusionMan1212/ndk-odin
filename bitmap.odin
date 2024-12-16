package android

foreign import android "system:android"

/** AndroidBitmap functions result code. */
ABitmapResult :: enum i32 {
    SUCCESS           =  0,
    BAD_PARAMETER     = -1,
    JNI_EXCEPTION     = -2,
    ALLOCATION_FAILED = -3,
}

/** Bitmap pixel format. */
AndroidBitmapFormat :: enum i32 {
    /** No format. */
    NONE      = 0,
    /** Red: 8 bits, Green: 8 bits, Blue: 8 bits, Alpha: 8 bits. **/
    RGBA_8888 = 1,
    /** Red: 5 bits, Green: 6 bits, Blue: 5 bits. **/
    RGB_565   = 4,
    /** Deprecated in API level 13. Because of the poor quality of this configuration, it is advised to use ARGB_8888 instead. **/
    RGBA_4444 = 7,
    /** Alpha: 8 bits. */
    A_8       = 8,
    /** Each component is stored as a half float. **/
    RGBA_F16  = 9,
    /** Red: 10 bits, Green: 10 bits, Blue: 10 bits, Alpha: 2 bits. **/
    RGBA_1010102 = 10,
}

/** Bitmap alpha format */
AndroidBitmapFlagsAlpha :: enum {
    /** Pixel components are premultiplied by alpha. */
    PREMUL   = 0,
    /** Pixels are opaque. */
    OPAQUE   = 1,
    /** Pixel components are independent of alpha. */
    UNPREMUL = 2,
    /** Bit mask for BitmapInfo.flags to isolate the alpha. */
    MASK     = 0x3,
    /** Shift for BitmapInfo.flags to isolate the alpha. */
    SHIFT    = 0,
}

AndroidBitmapFlags :: enum {
    /** If this bit is set in BitmapInfo.flags, the Bitmap uses the
      * HARDWARE Config, and its {@link AHardwareBuffer} can be retrieved via
      * {@link AndroidBitmap_getHardwareBuffer}.
      */
    IS_HARDWARE = 1 << 31,
}

// Note: these values match android.graphics.Bitmap#compressFormat.

/**
 *  Specifies the formats that can be compressed to with
 *  {@link AndroidBitmap_compress}.
 */
AndroidBitmapCompressFormat :: enum i32 {
    /**
     * Compress to the JPEG format. quality of 0 means
     * compress for the smallest size. 100 means compress for max
     * visual quality.
     */
    JPEG = 0,
    /**
     * Compress to the PNG format. PNG is lossless, so quality is
     * ignored.
     */
    PNG = 1,
    /**
     * Compress to the WEBP lossy format. quality of 0 means
     * compress for the smallest size. 100 means compress for max
     * visual quality.
     */
    WEBP_LOSSY = 3,
    /**
     * Compress to the WEBP lossless format. quality refers to how
     * much effort to put into compression. A value of 0 means to
     * compress quickly, resulting in a relatively large file size.
     * 100 means to spend more time compressing, resulting in a
     * smaller file.
     */
    WEBP_LOSSLESS = 4,
}

/** Bitmap info, see AndroidBitmap_getInfo(). */
BitmapInfo :: struct {
    /** The bitmap width in pixels. */
	width: u32,
    /** The bitmap height in pixels. */
    height: u32,
    /** The number of byte per row. */
    stride: u32,
    /** The bitmap pixel format. See {@link AndroidBitmapFormat} */
    format: AndroidBitmapFormat,
    /** Bitfield containing information about the bitmap.
     *
     * <p>Two bits are used to encode alpha. Use {@link AndroidBitmapFlagsAlpha.MASK}
     * and {@link AndroidBitmapFlagsAlpha.SHIFT} to retrieve them.</p>
     *
     * <p>One bit is used to encode whether the Bitmap uses the HARDWARE Config. Use
     * {@link AndroidBitmapFlags.IS_HARDWARE} to know.</p>
     *
     * <p>These flags were introduced in API level 30.</p>
     */
    flags: u32,
}

/**
 *  User-defined function for writing the output of compression.
 *
 *  Available since API level 30.
 *
 *  @param userContext Pointer to user-defined data passed to
 *         {@link AndroidBitmap_compress}.
 *  @param data Compressed data of |size| bytes to write.
 *  @param size Length in bytes of data to write.
 *  @return Whether the operation succeeded.
 */
AndroidBitmap_CompressWriteFunc :: #type proc "c" (userContext: rawptr, data: rawptr, size: uint) -> bool


foreign android {
	/**
	 * Given a java bitmap object, fill out the {@link BitmapInfo} struct for it.
	 * If the call fails, the info parameter will be ignored.
	 */
	AndroidBitmap_getInfo :: proc(env: ^JNIEnv, jbitmap: jobject, info: ^BitmapInfo) -> ABitmapResult ---

	/**
	* Given a java bitmap object, return its {@link ADataSpace}.
	*
	* Note that {@link ADataSpace} only exposes a few values. This may return
	* {@link ADATASPACE_UNKNOWN}, even for Named ColorSpaces, if they have no
	* corresponding ADataSpace.
	*
	* Available since API level 30.
	*/
	AndroidBitmap_getDataSpace :: proc(env: ^JNIEnv, jbitmap: jobject) -> ADataSpace ---

	/**
	* Given a java bitmap object, attempt to lock the pixel address.
	* Locking will ensure that the memory for the pixels will not move
	* until the unlockPixels call, and ensure that, if the pixels had been
	* previously purged, they will have been restored.
	*
	* If this call succeeds, it must be balanced by a call to
	* AndroidBitmap_unlockPixels, after which time the address of the pixels should
	* no longer be used.
	*
	* If this succeeds, *addrPtr will be set to the pixel address. If the call
	* fails, addrPtr will be ignored.
	*/
	AndroidBitmap_lockPixels :: proc(env: ^JNIEnv, jbitmap: jobject, addrPtr: ^rawptr) -> ABitmapResult ---

	/**
	* Call this to balance a successful call to AndroidBitmap_lockPixels.
	*/
	AndroidBitmap_unlockPixels :: proc(env: ^JNIEnv, jbitmap: jobject) -> ABitmapResult ---

	/**
	*  Compress |pixels| as described by |info|.
	*
	*  Available since API level 30.
	*
	*  @param info Description of the pixels to compress.
	*  @param dataspace {@link ADataSpace} describing the color space of the
	*                   pixels.
	*  @param pixels Pointer to pixels to compress.
	*  @param format {@link AndroidBitmapCompressFormat} to compress to.
	*  @param quality Hint to the compressor, 0-100. The value is interpreted
	*                 differently depending on the
	*                 {@link AndroidBitmapCompressFormat}.
	*  @param userContext User-defined data which will be passed to the supplied
	*                     {@link AndroidBitmap_CompressWriteFunc} each time it is
	*                     called. May be null.
	*  @param fn Function that writes the compressed data. Will be called each time
	*            the compressor has compressed more data that is ready to be
	*            written. May be called more than once for each call to this method.
	*            May not be null.
	*  @return AndroidBitmap functions result code.
	*/
	AndroidBitmap_compress :: proc(
		info: ^BitmapInfo,
		dataspace: ADataSpace,
		pixels: rawptr,
		format: AndroidBitmapCompressFormat,
		quality: i32,
		userContext: rawptr,
		fn: AndroidBitmap_CompressWriteFunc) -> ABitmapResult ---

	/**
	*  Retrieve the native object associated with a HARDWARE Bitmap.
	*
	*  Client must not modify it while a Bitmap is wrapping it.
	*
	*  Available since API level 30.
	*
	*  @param env Handle to the JNI environment pointer.
	*  @param bitmap Handle to an android.graphics.Bitmap.
	*  @param outBuffer On success, is set to a pointer to the
	*         {@link AHardwareBuffer} associated with bitmap. This acquires
	*         a reference on the buffer, and the client must call
	*         {@link AHardwareBuffer_release} when finished with it.
	*  @return AndroidBitmap functions result code.
	*          {@link ANDROID_BITMAP_RESULT_BAD_PARAMETER} if bitmap is not a
	*          HARDWARE Bitmap.
	*/
	AndroidBitmap_getHardwareBuffer :: proc(env: ^JNIEnv, bitmap: jobject, outBuffer: ^^AHardwareBuffer) -> ABitmapResult ---
}

