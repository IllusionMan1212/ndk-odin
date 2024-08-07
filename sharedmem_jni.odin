//+build android
package android

foreign import android "system:android"

foreign android {
	/**
	 * Returns a dup'd FD from the given Java android.os.SharedMemory object. The returned file
	 * descriptor has all the same properties & capabilities as the FD returned from
	 * ASharedMemory_create(), however the protection flags will be the same as those of the
	 * android.os.SharedMemory object.
	 *
	 * Use close() to release the shared memory region.
	 *
	 * Available since API level 27.
	 *
	 * \param env The JNIEnv* pointer
	 * \param sharedMemory The Java android.os.SharedMemory object
	 * \return file descriptor that denotes the shared memory; -1 if the shared memory object is
	 *      already closed, if the JNIEnv or jobject is NULL, or if there are too many open file
	 *      descriptors (errno=EMFILE)
	 */
	ASharedMemory_dupFromJava :: proc(env: ^JNIEnv, sharedMemory: jobject) -> i32 ---
}
