package android

foreign import android "system:android"

/**
 * {@link ASurfaceTexture} is an opaque type to manage SurfaceTexture from native code
 *
 * {@link ASurfaceTexture} can be obtained from an android.graphics.SurfaceTexture object using
 * ASurfaceTexture_fromSurfaceTexture().
 */
ASurfaceTexture :: struct{}

foreign android {
	/**
	 * Release the reference to the native ASurfaceTexture acquired with
	 * ASurfaceTexture_fromSurfaceTexture().
	 * Failing to do so will result in leaked memory and graphic resources.
	 *
	 * Available since API level 28.
	 *
	 * \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	 */
	ASurfaceTexture_release :: proc(st: ^ASurfaceTexture) ---

	/**
	* Returns a reference to an ANativeWindow (i.e. the Producer) for this SurfaceTexture.
	* This is equivalent to Java's: Surface sur = new Surface(surfaceTexture)
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	* @return A reference to an ANativeWindow. This reference MUST BE released when no longer needed
	* using ANativeWindow_release(). Failing to do so will result in leaked resources. nullptr is
	* returned if \p st is null or if it's not an instance of android.graphics.SurfaceTexture
	*/
	ASurfaceTexture_acquireANativeWindow :: proc(st: ^ASurfaceTexture) -> ^ANativeWindow ---

	/**
	* Attach the SurfaceTexture to the OpenGL ES context that is current on the calling thread.  A
	* new OpenGL ES texture object is created and populated with the SurfaceTexture image frame
	* that was current at the time of the last call to {@link ASurfaceTexture_detachFromGLContext}.
	* This new texture is bound to the GL_TEXTURE_EXTERNAL_OES texture target.
	*
	* This can be used to access the SurfaceTexture image contents from multiple OpenGL ES
	* contexts.  Note, however, that the image contents are only accessible from one OpenGL ES
	* context at a time.
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	* \param texName The name of the OpenGL ES texture that will be created.  This texture name
	* must be unusued in the OpenGL ES context that is current on the calling thread.
	* \return 0 on success, negative posix error code otherwise (see <errno.h>)
	*/
	ASurfaceTexture_attachToGLContext :: proc(st: ^ASurfaceTexture, texName: u32) -> i32 ---

	/**
	* Detach the SurfaceTexture from the OpenGL ES context that owns the OpenGL ES texture object.
	* This call must be made with the OpenGL ES context current on the calling thread.  The OpenGL
	* ES texture object will be deleted as a result of this call.  After calling this method all
	* calls to {@link ASurfaceTexture_updateTexImage} will fail until a successful call to
	* {@link ASurfaceTexture_attachToGLContext} is made.
	*
	* This can be used to access the SurfaceTexture image contents from multiple OpenGL ES
	* contexts.  Note, however, that the image contents are only accessible from one OpenGL ES
	* context at a time.
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	* \return 0 on success, negative posix error code otherwise (see <errno.h>)
	*/
	ASurfaceTexture_detachFromGLContext :: proc(st: ^ASurfaceTexture) -> i32 ---

	/**
	* Update the texture image to the most recent frame from the image stream.  This may only be
	* called while the OpenGL ES context that owns the texture is current on the calling thread.
	* It will implicitly bind its texture to the GL_TEXTURE_EXTERNAL_OES texture target.
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	* \return 0 on success, negative posix error code otherwise (see <errno.h>)
	*/
	ASurfaceTexture_updateTexImage :: proc(st: ^ASurfaceTexture) -> i32 ---

	/**
	* Retrieve the 4x4 texture coordinate transform matrix associated with the texture image set by
	* the most recent call to updateTexImage.
	*
	* This transform matrix maps 2D homogeneous texture coordinates of the form (s, t, 0, 1) with s
	* and t in the inclusive range [0, 1] to the texture coordinate that should be used to sample
	* that location from the texture.  Sampling the texture outside of the range of this transform
	* is undefined.
	*
	* The matrix is stored in column-major order so that it may be passed directly to OpenGL ES via
	* the glLoadMatrixf or glUniformMatrix4fv functions.
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	* \param mtx the array into which the 4x4 matrix will be stored.  The array must have exactly
	*     16 elements.
	*/
	ASurfaceTexture_getTransformMatrix :: proc(st: ^ASurfaceTexture, mtx: [16]f32) ---

	/**
	* Retrieve the timestamp associated with the texture image set by the most recent call to
	* updateTexImage.
	*
	* This timestamp is in nanoseconds, and is normally monotonically increasing. The timestamp
	* should be unaffected by time-of-day adjustments, and for a camera should be strictly
	* monotonic but for a MediaPlayer may be reset when the position is set.  The
	* specific meaning and zero point of the timestamp depends on the source providing images to
	* the SurfaceTexture. Unless otherwise specified by the image source, timestamps cannot
	* generally be compared across SurfaceTexture instances, or across multiple program
	* invocations. It is mostly useful for determining time offsets between subsequent frames.
	*
	* For EGL/Vulkan producers, this timestamp is the desired present time set with the
	* EGL_ANDROID_presentation_time or VK_GOOGLE_display_timing extensions
	*
	* Available since API level 28.
	*
	* \param st A ASurfaceTexture reference acquired with ASurfaceTexture_fromSurfaceTexture()
	*/
	ASurfaceTexture_getTimestamp :: proc(st: ^ASurfaceTexture) -> i64 ---
}
