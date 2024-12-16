package android

import "core:c"

foreign import android "system:android"

/** Available access modes for opening assets with {@link AAssetManager_open} */
AssetOpenMode :: enum c.int {
    /** No specific information about how data will be accessed. **/
    UNKNOWN      = 0,
    /** Read chunks, and seek forward and backward. */
    RANDOM       = 1,
    /** Read sequentially, with an occasional forward seek. */
    STREAMING    = 2,
    /** Caller plans to ask for a read-only buffer with all data. */
    BUFFER       = 3
}

// Same as sys/linux but this is i32 instead of i16
Seek_Whence :: enum i32 {
	SET  = 0,
	CUR  = 1,
	END  = 2,
	DATA = 3,
	HOLE = 4,
}

/**
 * {@link AAssetManager} provides access to an application's raw assets by
 * creating {@link AAsset} objects.
 *
 * AAssetManager is a wrapper to the low-level native implementation
 * of the java {@link AAssetManager}, a pointer can be obtained using
 * AAssetManager_fromJava().
 *
 * The asset hierarchy may be examined like a filesystem, using
 * {@link AAssetDir} objects to peruse a single directory.
 *
 * A native {@link AAssetManager} pointer may be shared across multiple threads.
 */
AAssetManager :: struct{}

/**
 * {@link AAssetDir} provides access to a chunk of the asset hierarchy as if
 * it were a single directory. The contents are populated by the
 * {@link AAssetManager}.
 *
 * The list of files will be sorted in ascending order by ASCII value.
 */
 AAssetDir :: struct{}

/**
 * {@link AAsset} provides access to a read-only asset.
 *
 * {@link AAsset} objects are NOT thread-safe, and should not be shared across
 * threads.
 */
AAsset :: struct{}

foreign android {
	/**
	 * Open an asset.
	 *
	 * The object returned here should be freed by calling AAsset_close().
	 */
	AAssetManager_open :: proc(mgr: ^AAssetManager, filename: cstring, mode: AssetOpenMode) -> ^AAsset ---

	/**
	* Iterate over the files in an asset directory.  A NULL string is returned
	* when all the file names have been returned.
	*
	* The returned file name is suitable for passing to AAssetManager_open().
	*
	* The string returned here is owned by the AssetDir implementation and is not
	* guaranteed to remain valid if any other calls are made on this AAssetDir
	* instance.
	*/
	AAssetDir_getNextFileName :: proc(assetDir: ^AAssetDir) -> cstring ---

	/**
	* Reset the iteration state of AAssetDir_getNextFileName() to the beginning.
	*/
	AAssetDir_rewind :: proc(assetDir: ^AAssetDir) ---

	/**
	* Close an opened AAssetDir, freeing any related resources.
	*/
	AAssetDir_close :: proc(assetDir: ^AAssetDir) ---

	/**
	* Attempt to read 'count' bytes of data from the current offset.
	*
	* Returns the number of bytes read, zero on EOF, or < 0 on error.
	*/
	AAsset_read :: proc(asset: ^AAsset, buf: rawptr, count: uint) -> i32 ---

	/**
	* Seek to the specified offset within the asset data.  'whence' uses the
	* same constants as lseek()/fseek().
	*
	* Returns the new position on success, or (off_t) -1 on error.
	*/
	// TODO: should we just not bind these functions since their 64-bit counterparts are available?
	// Because according to https://android.googlesource.com/platform/bionic/+/main/docs/32-bit-abi.md
	// and the __RENAME_IF_FILE_OFFSET64() macro these functions are replaced with the 64-bit versions at
	// runtime anyway (at least for 32-bit Android).
	// off_t is replaced with off64_t too.
	// I think all Android API version <21 should explicitly be unsupported both by Odin and the bindings here since
	// this opens a can of worms that I do not like.
	AAsset_seek :: proc(asset: ^AAsset, offset: off_t, whence: Seek_Whence) -> off_t ---

	/**
	* Seek to the specified offset within the asset data.  'whence' uses the
	* same constants as lseek()/fseek().
	*
	* Uses 64-bit data type for large files as opposed to the 32-bit type used
	* by AAsset_seek.
	*
	* Returns the new position on success, or (off64_t) -1 on error.
	*/
	AAsset_seek64 :: proc(asset: ^AAsset, offset: off64_t, whence: Seek_Whence) -> off64_t ---

	/**
	* Close the asset, freeing all associated resources.
	*/
	AAsset_close :: proc(asset: ^AAsset) ---

	/**
	* Get a pointer to a buffer holding the entire contents of the assset.
	*
	* Returns NULL on failure.
	*/
	AAsset_getBuffer :: proc(asset: ^AAsset) -> rawptr ---

	/**
	* Report the total size of the asset data.
	*/
	AAsset_getLength :: proc(asset: ^AAsset) -> off_t ---

	/**
	* Report the total size of the asset data. Reports the size using a 64-bit
	* number insted of 32-bit as AAsset_getLength.
	*/
	AAsset_getLength64 :: proc(asset: ^AAsset) -> off64_t ---

	/**
	* Report the total amount of asset data that can be read from the current position.
	*/
	AAsset_getRemainingLength :: proc(asset: ^AAsset) -> off_t ---

	/**
	* Report the total amount of asset data that can be read from the current position.
	*
	* Uses a 64-bit number instead of a 32-bit number as AAsset_getRemainingLength does.
	*/
	AAsset_getRemainingLength64 :: proc(asset: ^AAsset) -> off64_t ---

	/**
	* Open a new file descriptor that can be used to read the asset data. If the
	* start or length cannot be represented by a 32-bit number, it will be
	* truncated. If the file is large, use AAsset_openFileDescriptor64 instead.
	*
	* Returns < 0 if direct fd access is not possible (for example, if the asset is
	* compressed).
	*/
	AAsset_openFileDescriptor :: proc(asset: ^AAsset, outStart: ^off_t, outLength: ^off_t) -> i32 ---

	/**
	* Open a new file descriptor that can be used to read the asset data.
	*
	* Uses a 64-bit number for the offset and length instead of 32-bit instead of
	* as AAsset_openFileDescriptor does.
	*
	* Returns < 0 if direct fd access is not possible (for example, if the asset is
	* compressed).
	*/
	AAsset_openFileDescriptor64 :: proc(asset: ^AAsset, outStart: ^off64_t, outLength: ^off64_t) -> i32 ---

	/**
	* Returns whether this asset's internal buffer is allocated in ordinary RAM (i.e. not
	* mmapped).
	*/
	AAsset_isAllocated :: proc(asset: ^AAsset) -> i32 ---
}
