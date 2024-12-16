package android

foreign import android "system:android"

/* Fences indicate the status of an asynchronous task. They are initially
 * in unsignaled state (0), and make a one-time transition to either signaled
 * (1) or error (< 0) state. A sync file is a collection of one or more fences;
 * the sync file's status is error if any of its fences are in error state,
 * signaled if all of the child fences are signaled, or unsignaled otherwise.
 *
 * Sync files are created by various device APIs in response to submitting
 * tasks to the device. Standard file descriptor lifetime syscalls like dup()
 * and close() are used to manage sync file lifetime.
 *
 * The poll(), ppoll(), or select() syscalls can be used to wait for the sync
 * file to change status, or (with a timeout of zero) to check its status.
 *
 * The functions below provide a few additional sync-specific operations.
 */

// TODO: move to sys/linux or sys/android or something idk.
sync_fence_info :: struct {
	obj_name: [32]u8,
	driver_name: [32]u8,
	status: i32,
	flags: u32,
	timestamp_ns: u64,
}

sync_file_info :: struct {
	name: [32]u8,
	status: i32,
	flags: u32,
	num_fences: u32,
	pad: u32,
	sync_fence_info: u64,
}


/**
* Get the array of fence infos from the sync file's info.
*
* The returned array is owned by the parent sync file info, and has
* info->num_fences entries.
*
* Available since API level 26.
*/
sync_get_fence_info :: #force_inline proc(info: ^sync_file_info) -> ^sync_fence_info {
	return cast(^sync_fence_info)(uintptr(info.sync_fence_info))
}

foreign android {
	/**
	 * Merge two sync files.
	 *
	 * This produces a new sync file with the given name which has the union of the
	 * two original sync file's fences redundant fences may be removed.
	 *
	 * If one of the input sync files is signaled or invalid, then this function
	 * may behave like dup(): the new file descriptor refers to the valid/unsignaled
	 * sync file with its original name, rather than a new sync file.
	 *
	 * The original fences remain valid, and the caller is responsible for closing
	 * them.
	 *
	 * Available since API level 26.
	 */
	sync_merge :: proc(name: cstring, fd1: i32, fd2: i32) -> i32 ---

	/**
	* Retrieve detailed information about a sync file and its fences.
	*
	* The returned sync_file_info must be freed by calling sync_file_info_free().
	*
	* Available since API level 26.
	*/
	@(link_name="sync_file_info")
	_sync_file_info :: proc(fd: i32) -> ^sync_file_info ---

	/**
	* Free a struct sync_file_info structure
	*
	* Available since API level 26.
	*/
	sync_file_info_free :: proc(info: ^sync_file_info) ---
}
