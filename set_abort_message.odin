//+build android
package android

foreign import android "system:android"

foreign android {
	/**
	 * android_set_abort_message() sets the abort message that will be shown
	 * by [debuggerd](https://source.android.com/devices/tech/debug/native-crash).
	 * This is meant for use by libraries that deliberately abort so that they can
	 * provide an explanation. It is used within bionic to implement assert() and
	 * all FORTIFY/fdsan aborts.
	 *
	 * Available since API level 21.
	 */

	android_set_abort_message :: proc(__msg: cstring) ---
}
