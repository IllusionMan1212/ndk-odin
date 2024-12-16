package android

foreign import android "system:android"

foreign android {
	/**
	 * Create a shared memory region.
	 *
	 * Create shared memory region and returns an file descriptor.  The resulting file descriptor can be
	 * mmap'ed to process memory space with PROT_READ | PROT_WRITE | PROT_EXEC. Access to shared memory
	 * region can be restricted with {@link ASharedMemory_setProt}.
	 *
	 * Use close() to release the shared memory region.
	 *
	 * Use <a href="/reference/android/os/ParcelFileDescriptor">android.os.ParcelFileDescriptor</a>
	 * to pass the file descriptor to another process. File descriptors may also be sent to other
	 * processes over a Unix domain socket with sendmsg and SCM_RIGHTS. See sendmsg(3) and
	 * cmsg(3) man pages for more information.
	 *
	 * If you intend to share this file descriptor with a child process after
	 * calling exec(3), note that you will need to use fcntl(2) with FD_SETFD
	 * to clear the FD_CLOEXEC flag for this to work on all versions of Android.
	 *
	 * Available since API level 26.
	 *
	 * \param name an optional name.
	 * \param size size of the shared memory region
	 * \return file descriptor that denotes the shared memory
	 *         -1 and sets errno on failure, or -EINVAL if the error is that size was 0.
	 */
	ASharedMemory_create :: proc(name: cstring, size: uint) -> i32 ---

	/**
	* Get the size of the shared memory region.
	*
	* Available since API level 26.
	*
	* \param fd file descriptor of the shared memory region
	* \return size in bytes 0 if fd is not a valid shared memory file descriptor.
	*/
	ASharedMemory_getSize :: proc(fd: i32) -> uint ---

	/**
	* Restrict access of shared memory region.
	*
	* This function restricts access of a shared memory region. Access can only be removed. The effect
	* applies globally to all file descriptors in all processes across the system that refer to this
	* shared memory region. Existing memory mapped regions are not affected.
	*
	* It is a common use case to create a shared memory region, map it read/write locally to intialize
	* content, and then send the shared memory to another process with read only access. Code example
	* as below (error handling omited).
	*
	*
	*     int fd = ASharedMemory_create("memory", 128)
	*
	*     // By default it has PROT_READ | PROT_WRITE | PROT_EXEC.
	*     size_t memSize = ASharedMemory_getSize(fd)
	*     char *buffer = (char *) mmap(NULL, memSize, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0)
	*
	*     strcpy(buffer, "This is an example.") // trivially initialize content
	*
	*     // limit access to read only
	*     ASharedMemory_setProt(fd, PROT_READ)
	*
	*     // share fd with another process here and the other process can only map with PROT_READ.
	*
	* Available since API level 26.
	*
	* \param fd   file descriptor of the shared memory region.
	* \param prot any bitwise-or'ed combination of PROT_READ, PROT_WRITE, PROT_EXEC denoting
	*             updated access. Note access can only be removed, but not added back.
	* \return 0 for success, -1 and sets errno on failure.
	*/
	ASharedMemory_setProt :: proc(fd: i32, prot: i32) -> i32 ---
}
