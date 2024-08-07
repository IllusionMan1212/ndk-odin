//+build android
package android

/**
 * Legacy window pixel format names, kept for backwards compatibility.
 * New code and APIs should use AHARDWAREBUFFER_FORMAT_*.
 */
ANativeWindow_LegacyFormat :: enum u32 {
    // NOTE: these values must match the values from graphics/common/x.x/types.hal

    /** Red: 8 bits, Green: 8 bits, Blue: 8 bits, Alpha: 8 bits. **/
    RGBA_8888          = u32(AHardwareBuffer_Format.R8G8B8A8_UNORM),
    /** Red: 8 bits, Green: 8 bits, Blue: 8 bits, Unused: 8 bits. **/
    RGBX_8888          = u32(AHardwareBuffer_Format.R8G8B8X8_UNORM),
    /** Red: 5 bits, Green: 6 bits, Blue: 5 bits. **/
    RGB_565            = u32(AHardwareBuffer_Format.R5G6B5_UNORM),
}

/**
 * Transforms that can be applied to buffers as they are displayed to a window.
 *
 * Supported transforms are any combination of horizontal mirror, vertical
 * mirror, and clockwise 90 degree rotation, in that order. Rotations of 180
 * and 270 degrees are made up of those basic transforms.
 */
ANativeWindowTransform :: enum i32 {
    IDENTITY            = 0x00,
    MIRROR_HORIZONTAL   = 0x01,
    MIRROR_VERTICAL     = 0x02,
    ROTATE_90           = 0x04,

    ROTATE_180          = MIRROR_HORIZONTAL | MIRROR_VERTICAL,
    ROTATE_270          = ROTATE_180 | ROTATE_90,
}

/** Compatibility value for ANativeWindow_setFrameRate. */
ANativeWindow_FrameRateCompatibility :: enum i8 {
	/**
	* There are no inherent restrictions on the frame rate of this window. When
	* the system selects a frame rate other than what the app requested, the
	* app will be able to run at the system frame rate without requiring pull
	* down. This value should be used when displaying game content, UIs, and
	* anything that isn't video.
	*/
	DEFAULT = 0,
	/**
	* This window is being used to display content with an inherently fixed
	* frame rate, e.g.\ a video that has a specific frame rate. When the system
	* selects a frame rate other than what the app requested, the app will need
	* to do pull down or use some other technique to adapt to the system's
	* frame rate. The user experience is likely to be worse (e.g. more frame
	* stuttering) than it would be if the system had chosen the app's requested
	* frame rate. This value should be used for video content.
	*/
	FIXED_SOURCE = 1
}

/** Change frame rate strategy value for ANativeWindow_setFrameRate. */
// Available since API level 31.
ANativeWindow_ChangeFrameRateStrategy :: enum i8 {
	/**
	* Change the frame rate only if the transition is going to be seamless.
	*/
	ONLY_IF_SEAMLESS = 0,
	/**
	* Change the frame rate even if the transition is going to be non-seamless,
	* i.e. with visual interruptions for the user.
	*/
	ALWAYS = 1
}

/**
 * Opaque type that provides access to a native window.
 *
 * A pointer can be obtained using {@link ANativeWindow_fromSurface()}.
 */
ANativeWindow :: struct{}

/**
 * Struct that represents a windows buffer.
 *
 * A pointer can be obtained using {@link ANativeWindow_lock()}.
 */
ANativeWindow_Buffer :: struct {
    /// The number of pixels that are shown horizontally.
	width: i32,

    /// The number of pixels that are shown vertically.
    height: i32,

    /// The number of *pixels* that a line in the buffer takes in
    /// memory. This may be >= width.
    stride: i32,

    /// The format of the buffer. One of AHardwareBuffer_Format.
    format: AHardwareBuffer_Format,

    /// The actual bits.
    bits: rawptr,

    /// Do not touch.
    reserved: [6]u32,
}

foreign import android "system:android"

foreign android {
	/**
	* Acquire a reference on the given {@link ANativeWindow} object. This prevents the object
	* from being deleted until the reference is removed.
	*/
	ANativeWindow_acquire :: proc(window: ^ANativeWindow) ---

	/**
	* Remove a reference that was previously acquired with {@link ANativeWindow_acquire()}.
	*/
	ANativeWindow_release :: proc(window: ^ANativeWindow) ---

	/**
	* Return the current width in pixels of the window surface.
	*
	* \return negative value on error.
	*/
	ANativeWindow_getWidth :: proc(window: ^ANativeWindow) -> i32 ---

	/**
	* Return the current height in pixels of the window surface.
	*
	* \return a negative value on error.
	*/
	ANativeWindow_getHeight :: proc(window: ^ANativeWindow) -> i32 ---

	/**
	* Return the current pixel format (AHARDWAREBUFFER_FORMAT_*) of the window surface.
	*
	* \return a negative value on error.
	*/
	ANativeWindow_getFormat :: proc(window: ^ANativeWindow) -> AHardwareBuffer_Format ---

	/**
	* Change the format and size of the window buffers.
	*
	* The width and height control the number of pixels in the buffers, not the
	* dimensions of the window on screen. If these are different than the
	* window's physical size, then its buffer will be scaled to match that size
	* when compositing it to the screen. The width and height must be either both zero
	* or both non-zero.
	*
	* For all of these parameters, if 0 is supplied then the window's base
	* value will come back in force.
	*
	* \param window pointer to an ANativeWindow object.
	* \param width width of the buffers in pixels.
	* \param height height of the buffers in pixels.
	* \param format one of the AHardwareBuffer_Format constants.
	* \return 0 for success, or a negative value on error.
	*/
	ANativeWindow_setBuffersGeometry :: proc(window: ^ANativeWindow, width: i32, height: i32, format: i32) -> i32 ---

	/**
	* Lock the window's next drawing surface for writing.
	* inOutDirtyBounds is used as an in/out parameter, upon entering the
	* function, it contains the dirty region, that is, the region the caller
	* intends to redraw. When the function returns, inOutDirtyBounds is updated
	* with the actual area the caller needs to redraw -- this region is often
	* extended by {@link ANativeWindow_lock}.
	*
	* \return 0 for success, or a negative value on error.
	*/
	ANativeWindow_lock :: proc(window: ^ANativeWindow, outBuffer: ^ANativeWindow_Buffer, inOutDirtyBounds: ^ARect) -> i32 ---

	/**
	* Unlock the window's drawing surface after previously locking it,
	* posting the new buffer to the display.
	*
	* \return 0 for success, or a negative value on error.
	*/
	ANativeWindow_unlockAndPost :: proc(window: ^ANativeWindow) -> i32 ---

	/**
	* Set a transform that will be applied to future buffers posted to the window.
	*
	* Available since API level 26.
	*
	* \param window pointer to an ANativeWindow object.
	* \param transform combination of {@link ANativeWindowTransform} flags
	* \return 0 for success, or -EINVAL if \p transform is invalid
	*/
	ANativeWindow_setBuffersTransform :: proc(window: ^ANativeWindow, transform: ANativeWindowTransform) -> i32 ---

	/**
	* All buffers queued after this call will be associated with the dataSpace
	* parameter specified.
	*
	* dataSpace specifies additional information about the buffer.
	* For example, it can be used to convey the color space of the image data in
	* the buffer, or it can be used to indicate that the buffers contain depth
	* measurement data instead of color images. The default dataSpace is 0,
	* ADATASPACE_UNKNOWN, unless it has been overridden by the producer.
	*
	* Available since API level 28.
	*
	* \param window pointer to an ANativeWindow object.
	* \param dataSpace data space of all buffers queued after this call.
	* \return 0 for success, -EINVAL if window is invalid or the dataspace is not
	* supported.
	*/
	ANativeWindow_setBuffersDataSpace :: proc(window: ^ANativeWindow, dataSpace: ADataSpace) -> i32 ---

	/**
	* Get the dataspace of the buffers in window.
	*
	* Available since API level 28.
	*
	* \return the dataspace of buffers in window, ADATASPACE_UNKNOWN is returned if
	* dataspace is unknown, or -EINVAL if window is invalid.
	*/
	ANativeWindow_getBuffersDataSpace :: proc(window: ^ANativeWindow) -> ADataSpace ---

	/**
	* Same as ANativeWindow_setFrameRateWithChangeStrategy(window, frameRate, compatibility,
	* ANATIVEWINDOW_CHANGE_FRAME_RATE_ONLY_IF_SEAMLESS).
	*
	* See ANativeWindow_setFrameRateWithChangeStrategy().
	*
	* Available since API level 30.
	*/
	ANativeWindow_setFrameRate :: proc(window: ^ANativeWindow, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility) -> i32 ---

	/**
	* Provides a hint to the window that buffers should be preallocated ahead of
	* time. Note that the window implementation is not guaranteed to preallocate
	* any buffers, for instance if an implementation disallows allocation of new
	* buffers, or if there is insufficient memory in the system to preallocate
	* additional buffers
	*
	* Available since API level 30.
	*/
	ANativeWindow_tryAllocateBuffers :: proc(window: ^ANativeWindow) ---

	/**
	* Sets the intended frame rate for this window.
	*
	* On devices that are capable of running the display at different refresh
	* rates, the system may choose a display refresh rate to better match this
	* window's frame rate. Usage of this API won't introduce frame rate throttling,
	* or affect other aspects of the application's frame production
	* pipeline. However, because the system may change the display refresh rate,
	* calls to this function may result in changes to Choreographer callback
	* timings, and changes to the time interval at which the system releases
	* buffers back to the application.
	*
	* Note that this only has an effect for windows presented on the display. If
	* this ANativeWindow is consumed by something other than the system compositor,
	* e.g. a media codec, this call has no effect.
	*
	* You can register for changes in the refresh rate using
	* \a AChoreographer_registerRefreshRateCallback.
	*
	* Available since API level 31.
	*
	* \param window pointer to an ANativeWindow object.
	*
	* \param frameRate The intended frame rate of this window, in frames per
	* second. 0 is a special value that indicates the app will accept the system's
	* choice for the display frame rate, which is the default behavior if this
	* function isn't called. The frameRate param does <em>not</em> need to be a
	* valid refresh rate for this device's display - e.g., it's fine to pass 30fps
	* to a device that can only run the display at 60fps.
	*
	* \param compatibility The frame rate compatibility of this window. The
	* compatibility value may influence the system's choice of display refresh
	* rate. See the ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_* values for more info.
	* This parameter is ignored when frameRate is 0.
	*
	* \param changeFrameRateStrategy Whether display refresh rate transitions caused by this
	* window should be seamless.
	* A seamless transition is one that doesn't have any visual interruptions, such as a black
	* screen for a second or two. See the ANATIVEWINDOW_CHANGE_FRAME_RATE_* values.
	* This parameter is ignored when frameRate is 0.
	*
	* \return 0 for success, -EINVAL if the window, frame rate, or compatibility
	* value are invalid.
	*/
	ANativeWindow_setFrameRateWithChangeStrategy :: proc(window: ^ANativeWindow, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility, changeFrameRateStrategy: ANativeWindow_ChangeFrameRateStrategy) -> i32 ---
}
