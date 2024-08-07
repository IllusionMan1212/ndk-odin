//+build android
package android

foreign import android "system:android"

/** Flag for an obb file, returned by AObbInfo_getFlags(). */
ObbFlags :: enum i32 {
    OVERLAY = 0x0001,
}

/** {@link AObbInfo} is an opaque type representing information for obb storage. */
AObbInfo :: struct{}

foreign android {
	/**
	 * Scan an OBB and get information about it.
	 */
	AObbScanner_getObbInfo :: proc(filename: cstring) -> ^AObbInfo ---

	/**
	* Destroy the AObbInfo object. You must call this when finished with the object.
	*/
	AObbInfo_delete :: proc(obbInfo: ^AObbInfo) ---

	/**
	* Get the package name for the OBB.
	*/
	AObbInfo_getPackageName :: proc(obbInfo: ^AObbInfo) -> cstring ---

	/**
	* Get the version of an OBB file.
	*/
	AObbInfo_getVersion :: proc(obbInfo: ^AObbInfo) -> i32 ---

	/**
	* Get the flags of an OBB file.
	*/
	AObbInfo_getFlags :: proc(obbInfo: ^AObbInfo) -> ObbFlags ---
}
