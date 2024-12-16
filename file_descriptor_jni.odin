package android

foreign import android "system:android"

foreign android {
	/**
	 * Returns a new java.io.FileDescriptor.
	 *
	 * The FileDescriptor created represents an invalid Unix file descriptor (represented by
	 * a file descriptor value of -1).
	 *
	 * Callers of this method should be aware that it can fail, returning NULL with a pending Java
	 * exception.
	 *
	 * Available since API level 31.
	 *
	 * \param env a pointer to the JNI Native Interface of the current thread.
	 * \return a java.io.FileDescriptor on success, nullptr if insufficient heap memory is available.
	 */
	AFileDescriptor_create :: proc(env: ^JNIEnv) -> jobject ---

	/**
	* Returns the Unix file descriptor represented by the given java.io.FileDescriptor.
	*
	* A return value of -1 indicates that \a fileDescriptor represents an invalid file descriptor.
	*
	* Aborts the program if \a fileDescriptor is not a java.io.FileDescriptor instance.
	*
	* Available since API level 31.
	*
	* \param env a pointer to the JNI Native Interface of the current thread.
	* \param fileDescriptor a java.io.FileDescriptor instance.
	* \return the Unix file descriptor wrapped by \a fileDescriptor.
	*/
	AFileDescriptor_getFd :: proc(env: ^JNIEnv, fileDescriptor: jobject) -> i32 ---

	/**
	* Sets the Unix file descriptor represented by the given java.io.FileDescriptor.
	*
	* This function performs no validation of the Unix file descriptor argument, \a fd. Android uses
	* the value -1 to represent an invalid file descriptor, all other values are considered valid.
	* The validity of a file descriptor can be checked with FileDescriptor#valid().
	*
	* Aborts the program if \a fileDescriptor is not a java.io.FileDescriptor instance.
	*
	* Available since API level 31.
	*
	* \param env a pointer to the JNI Native Interface of the current thread.
	* \param fileDescriptor a java.io.FileDescriptor instance.
	* \param fd a Unix file descriptor that \a fileDescriptor will subsequently represent.
	*/
	AFileDescriptor_setFd :: proc(env: ^JNIEnv, fileDescriptor: jobject, fd: i32) ---
}
