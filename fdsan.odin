//+build android
package android

foreign import android "system:android"

/*
 * Error checking for close(2).
 *
 * Mishandling of file descriptor ownership is a common source of errors that
 * can be extremely difficult to diagnose. Mistakes like the following can
 * result in seemingly 'impossible' failures showing up on other threads that
 * happened to try to open a file descriptor between the buggy code's close and
 * fclose:
 *
 *     int print(int fd) {
 *         int rc;
 *         char buf[128];
 *         while ((rc = read(fd, buf, sizeof(buf))) > 0) {
 *             printf("%.*s", rc);
 *         }
 *         close(fd);
 *     }
 *
 *     int bug() {
 *         FILE* f = fopen("foo", "r");
 *         print(fileno(f));
 *         fclose(f);
 *     }
 *
 * To make it easier to find this class of bugs, bionic provides a method to
 * require that file descriptors are closed by their owners. File descriptors
 * can be associated with tags with which they must be closed. This allows
 * objects that conceptually own an fd (FILE*, unique_fd, etc.) to use their
 * own address at the tag, to enforce that closure of the fd must come as a
 * result of their own destruction (fclose, ~unique_fd, etc.)
 *
 * By default, a file descriptor's tag is 0, and close(fd) is equivalent to
 * closing fd with the tag 0.
 */

/*
 * For improved diagnostics, the type of a file descriptors owner can be
 * encoded in the most significant byte of the owner tag. Values of 0 and 0xff
 * are ignored, which allows for raw pointers to be used as owner tags without
 * modification.
 */
android_fdsan_owner_type :: enum {
  /*
   * Generic Java or native owners.
   *
   * Generic Java objects always use 255 as their type, using identityHashCode
   * as the value of the tag, leaving bits 33-56 unset. Native pointers are sign
   * extended from 48-bits of virtual address space, and so can have the MSB
   * set to 255 as well. Use the value of bits 49-56 to distinguish between
   * these cases.
   */
  GENERIC_00 = 0,
  GENERIC_FF = 255,

  /* FILE* */
  FILE = 1,

  /* DIR* */
  DIR = 2,

  /* android::base::unique_fd */
  UNIQUE_FD = 3,

  /* sqlite-owned file descriptors */
  SQLITE = 4,

  /* java.io.FileInputStream */
  FILEINPUTSTREAM = 5,

  /* java.io.FileOutputStream */
  FILEOUTPUTSTREAM = 6,

  /* java.io.RandomAccessFile */
  RANDOMACCESSFILE = 7,

  /* android.os.ParcelFileDescriptor */
  PARCELFILEDESCRIPTOR = 8,

  /* ART FdFile */
  ART_FDFILE = 9,

  /* java.net.DatagramSocketImpl */
  DATAGRAMSOCKETIMPL = 10,

  /* java.net.SocketImpl */
  SOCKETIMPL = 11,

  /* libziparchive's ZipArchive */
  ZIPARCHIVE = 12,

  /* native_handle_t */
  NATIVE_HANDLE = 13,
}

android_fdsan_error_level :: enum {
  // No errors.
  DISABLED,

  // Warn once(ish) on error, and then downgrade to ANDROID_FDSAN_ERROR_LEVEL_DISABLED.
  WARN_ONCE,

  // Warn always on error.
  WARN_ALWAYS,

  // Abort on error.
  FATAL,
}

foreign android {
	/*
	* Create an owner tag with the specified type and least significant 56 bits of tag.
	*
	* Available since API level 29.
	*/
	@(linkage="weak")
	android_fdsan_create_owner_tag :: proc(type: android_fdsan_owner_type, tag: u64) -> u64 ---

	/*
	* Exchange a file descriptor's tag.
	*
	* Logs and aborts if the fd's tag does not match expected_tag.
	*
	* Available since API level 29.
	*/
	@(linkage="weak")
	android_fdsan_exchange_owner_tag :: proc(fd: i32, expected_tag: u64, new_tag: u64) ---

	/*
	* Close a file descriptor with a tag, and resets the tag to 0.
	*
	* Logs and aborts if the tag is incorrect.
	*
	* Available since API level 29.
	*/
	@(linkage="weak")
	android_fdsan_close_with_tag :: proc(fd: i32, tag: u64) -> i32 ---

	/*
	* Get a file descriptor's current owner tag.
	*
	* Returns 0 for untagged and invalid file descriptors.
	*
	* Available since API level 29.
	*/
	android_fdsan_get_owner_tag :: proc(fd: i32) -> u64 ---

	/*
	* Get an owner tag's string representation.
	*
	* The return value points to memory with static lifetime, do not attempt to modify it.
	*
	* Available since API level 29.
	*/
	android_fdsan_get_tag_type :: proc(tag: u64) -> cstring ---

	/*
	* Get an owner tag's value, with the type masked off.
	*
	* Available since API level 29.
	*/
	android_fdsan_get_tag_value :: proc(tag: u64) -> u64 ---

	/*
	* Get the error level.
	*
	* Available since API level 29.
	*/
	@(linkage="weak")
	android_fdsan_get_error_level :: proc() -> android_fdsan_error_level ---

	/*
	* Set the error level and return the previous state.
	*
	* Error checking is automatically disabled in the child of a fork, to maintain
	* compatibility with code that forks, closes all file descriptors, and then
	* execs.
	*
	* In cases such as the zygote, where the child has no intention of calling
	* exec, call this function to reenable fdsan checks.
	*
	* This function is not thread-safe and does not synchronize with checks of the
	* value, and so should probably only be called in single-threaded contexts
	* (e.g. postfork).
	*
	* Available since API level 29.
	*/
	@(linkage="weak")
	android_fdsan_set_error_level :: proc(new_level: android_fdsan_error_level) -> android_fdsan_error_level ---


	/*
	* Set the error level to the global setting if available, or a default value.
	*
	* Available since API level 30.
	*/
	@(linkage="weak")
	android_fdsan_set_error_level_from_property :: proc(default_level: android_fdsan_error_level) -> android_fdsan_error_level ---
}

