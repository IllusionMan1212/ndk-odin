package android

foreign import android "system:android"

// TODO: move to libc or something
pid_t :: i32

/**
 * Permission check results.
 *
 * Introduced in API 31.
 */
PermissionManagerResult :: enum i32 {
    /**
     * This is returned by APermissionManager_checkPermission()
     * if the permission has been granted to the given package.
     */
    PERMISSION_GRANTED = 0,
    /**
     * This is returned by APermissionManager_checkPermission()
     * if the permission has not been granted to the given package.
     */
    PERMISSION_DENIED = -1,
}

/**
 * Permission check return status values.
 *
 * Introduced in API 31.
*/
PermissionManagerStatus :: enum i32 {
    /**
     * This is returned if the permission check completed without errors.
     * The output result is valid and contains one of {::PERMISSION_MANAGER_PERMISSION_GRANTED,
     * ::PERMISSION_MANAGER_PERMISSION_DENIED}.
     */
    OK = 0,
    /**
     * This is returned if the permission check encountered an unspecified error.
     * The output result is unmodified.
     */
    ERROR_UNKNOWN = -1,
    /**
     * This is returned if the permission check failed because the service is
     * unavailable. The output result is unmodified.
     */
    SERVICE_UNAVAILABLE = -2,
}

foreign android {
	/**
	 * Checks whether the package with the given pid/uid has been granted a permission.
	 *
	 * Note that the Java API of Context#checkPermission() is usually faster due to caching,
	 * thus is preferred over this API wherever possible.
	 *
	 * Available since API level 31
	 *
	 * @param permission the permission to be checked.
	 * @param pid the process id of the package to be checked.
	 * @param uid the uid of the package to be checked.
	 * @param outResult output of the permission check result.
	 *
	 * @return error codes if any error happened during the check.
	 */
	 APermissionManager_checkPermission :: proc(permission: cstring, pid: pid_t, uid: uid_t, outResult: ^PermissionManagerResult) -> PermissionManagerStatus ---
}
