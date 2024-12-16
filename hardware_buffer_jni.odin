package android

foreign import android "system:android"

foreign android {
	/**
	 * Return the AHardwareBuffer wrapped by a Java HardwareBuffer object.
	 *
	 * This method does not acquire any additional reference to the AHardwareBuffer
	 * that is returned. To keep the AHardwareBuffer alive after the Java
	 * HardwareBuffer object is closed, explicitly or by the garbage collector, be
	 * sure to use AHardwareBuffer_acquire() to acquire an additional reference.
	 *
	 * Available since API level 26.
	 */
	AHardwareBuffer_fromHardwareBuffer :: proc(env: ^JNIEnv, hardwareBufferObj: jobject) -> ^AHardwareBuffer ---

	/**
	* Return a new Java HardwareBuffer object that wraps the passed native
	* AHardwareBuffer object. The Java HardwareBuffer will acquire a reference to
	* the internal buffer and manage its lifetime. For example:
	*
	* <pre><code>
	* AHardwareBuffer* buffer
	* AHardwareBuffer_allocate(..., &buffer)  // `buffer` has reference count 1
	* jobject java_result = AHardwareBuffer_toHardwareBuffer(buffer)  // `buffer` has reference count 2.
	* AHardwareBuffer_release(buffer) // `buffer` has reference count 1
	* return result  // The underlying buffer is kept alive by `java_result` and
	*                 // will be set to 0 when it is closed on the Java side with
	*                 // HardwareBuffer::close().
	* </code></pre>
	*
	* Available since API level 26.
	*/
	AHardwareBuffer_toHardwareBuffer :: proc(env: ^JNIEnv, hardwareBuffer: ^AHardwareBuffer) -> jobject ---
}
