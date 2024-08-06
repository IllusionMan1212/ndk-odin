//+build android
package android

foreign import android "system:android"

	foreign android {
	/**
	 * Return the ANativeWindow associated with a Java Surface object,
	 * for interacting with it through native code.  This acquires a reference
	 * on the ANativeWindow that is returned be sure to use ANativeWindow_release()
	 * when done with it so that it doesn't leak.
	 */
	ANativeWindow_fromSurface :: proc(env: ^JNIEnv, surface: jobject) -> ^ANativeWindow ---

	/**
	 * Return a Java Surface object derived from the ANativeWindow, for interacting
	 * with it through Java code. The returned Java object acquires a reference on
	 * the ANativeWindow maintains it through general Java object's life cycle;
	 * and will automatically release the reference when the Java object gets garbage
	 * collected.
	 *
	 * Available since API level 26.
	 */
	ANativeWindow_toSurface :: proc(env: ^JNIEnv, window: ^ANativeWindow) -> jobject ---
}
