//+build android
package android

/**
 * Opaque type that provides access to a native window.
 *
 * A pointer can be obtained using {@link ANativeWindow_fromSurface()}.
 */
ANativeWindow :: struct{}

foreign import android "system:android"

foreign android {
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
}
