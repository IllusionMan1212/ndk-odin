package android

foreign import android "system:android"

foreign android {
	/**
	 * Get a reference to the native ASurfaceTexture from the corresponding java object.
	 *
	 * The caller must keep a reference to the Java SurfaceTexture during the lifetime of the returned
	 * ASurfaceTexture. Failing to do so could result in the ASurfaceTexture to stop functioning
	 * properly once the Java object gets finalized.
	 * However, this will not result in program termination.
	 *
	 * Available since API level 28.
	 *
	 * \param env JNI environment
	 * \param surfacetexture Instance of Java SurfaceTexture object
	 * \return native ASurfaceTexture reference or nullptr if the java object is not a SurfaceTexture.
	 *         The returned reference MUST BE released when it's no longer needed using
	 *         ASurfaceTexture_release().
	 */
	ASurfaceTexture_fromSurfaceTexture :: proc(env: ^JNIEnv, surfacetexture: jobject) -> ^ASurfaceTexture ---
}
