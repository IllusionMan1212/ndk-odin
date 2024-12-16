package android

foreign import android "system:android"

/**
 * The different states of a OBB storage passed to AStorageManager_obbCallbackFunc().
 */
OBBState :: enum i32 {
    /**
     * The OBB container is now mounted and ready for use. Can be returned
     * as the status for callbacks made during asynchronous OBB actions.
     */
    MOUNTED = 1,

    /**
     * The OBB container is now unmounted and not usable. Can be returned
     * as the status for callbacks made during asynchronous OBB actions.
     */
    UNMOUNTED = 2,

    /**
     * There was an internal system error encountered while trying to
     * mount the OBB. Can be returned as the status for callbacks made
     * during asynchronous OBB actions.
     */
    ERROR_INTERNAL = 20,

    /**
     * The OBB could not be mounted by the system. Can be returned as the
     * status for callbacks made during asynchronous OBB actions.
     */
    ERROR_COULD_NOT_MOUNT = 21,

    /**
     * The OBB could not be unmounted. This most likely indicates that a
     * file is in use on the OBB. Can be returned as the status for
     * callbacks made during asynchronous OBB actions.
     */
    ERROR_COULD_NOT_UNMOUNT = 22,

    /**
     * A call was made to unmount the OBB when it was not mounted. Can be
     * returned as the status for callbacks made during asynchronous OBB
     * actions.
     */
    ERROR_NOT_MOUNTED = 23,

    /**
     * The OBB has already been mounted. Can be returned as the status for
     * callbacks made during asynchronous OBB actions.
     */
    ERROR_ALREADY_MOUNTED = 24,

    /**
     * The current application does not have permission to use this OBB.
     * This could be because the OBB indicates it's owned by a different
     * package. Can be returned as the status for callbacks made during
     * asynchronous OBB actions.
     */
    ERROR_PERMISSION_DENIED = 25,
}

/**
 * {@link AStorageManager} manages application OBB storage, a pointer
 * can be obtained with AStorageManager_new().
 */
AStorageManager :: struct{}

/**
* Callback function for asynchronous calls made on OBB files.
*
* "state" is one of the following constants:
* - {@link AOBB_STATE_MOUNTED}
* - {@link AOBB_STATE_UNMOUNTED}
* - {@link AOBB_STATE_ERROR_INTERNAL}
* - {@link AOBB_STATE_ERROR_COULD_NOT_MOUNT}
* - {@link AOBB_STATE_ERROR_COULD_NOT_UNMOUNT}
* - {@link AOBB_STATE_ERROR_NOT_MOUNTED}
* - {@link AOBB_STATE_ERROR_ALREADY_MOUNTED}
* - {@link AOBB_STATE_ERROR_PERMISSION_DENIED}
*/
AStorageManager_obbCallbackFunc :: #type proc "c" (filename: cstring, state: OBBState, data: rawptr)

foreign android {
	/**
	 * Obtains a new instance of AStorageManager.
	 */
	AStorageManager_new :: proc() -> ^AStorageManager ---

	/**
	* Release AStorageManager instance.
	*/
	AStorageManager_delete :: proc(mgr: ^AStorageManager) ---

	/**
	* Attempts to mount an OBB file. This is an asynchronous operation.
	*
	* Since API level 33, this function can only be used to mount unencrypted OBBs,
	* i.e. the {@code key} parameter must be {@code null} or an empty string. Note
	* that even before API level 33, mounting encrypted OBBs didn't work on many
	* Android device implementations. Applications should not assume any particular
	* behavior when {@code key} is nonempty.
	*/
	AStorageManager_mountObb :: proc(mgr: ^AStorageManager, filename: cstring, key: cstring, cb: AStorageManager_obbCallbackFunc, data: rawptr) ---

	/**
	* Attempts to unmount an OBB file. This is an asynchronous operation.
	*/
	AStorageManager_unmountObb :: proc(mgr: ^AStorageManager, filename: cstring, force: i32, cb: AStorageManager_obbCallbackFunc, data: rawptr) ---

	/**
	* Check whether an OBB is mounted.
	*/
	AStorageManager_isObbMounted :: proc(mgr: ^AStorageManager, filename: cstring) -> i32 ---

	/**
	* Get the mounted path for an OBB.
	*/
	AStorageManager_getMountedObbPath :: proc(mgr: ^AStorageManager, filename: cstring) -> cstring ---
}
