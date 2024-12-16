package mediandk

import "../"

foreign import mediandk "system:mediandk"

AMediaDataSource :: struct{}

/*
 * AMediaDataSource's callbacks will be invoked on an implementation-defined thread
 * or thread pool. No guarantees are provided about which thread(s) will be used for
 * callbacks. For example, |close| can be invoked from a different thread than the
 * thread invoking |readAt|. As such, the Implementations of AMediaDataSource callbacks
 * must be threadsafe.
 */

/**
 * Called to request data from the given |offset|.
 *
 * Implementations should should write up to |size| bytes into
 * |buffer|, and return the number of bytes written.
 *
 * Return 0 if size is zero (thus no bytes are read).
 *
 * Return -1 to indicate that end of stream is reached.
 */
AMediaDataSourceReadAt :: #type proc "c" (userdata: rawptr, offset: android.off64_t, buffer: rawptr, size: uint) -> int

/**
 * Called to get the size of the data source.
 *
 * Return the size of data source in bytes, or -1 if the size is unknown.
 */
AMediaDataSourceGetSize :: #type proc "c" (userdata: rawptr) -> int

/**
 * Called to close the data source, unblock reads, and release associated
 * resources.
 *
 * The NDK media framework guarantees that after the first |close| is
 * called, no future callbacks will be invoked on the data source except
 * for |close| itself.
 *
 * Closing a data source allows readAt calls that were blocked waiting
 * for I/O data to return promptly.
 *
 * When using AMediaDataSource as input to AMediaExtractor, closing
 * has the effect of unblocking slow reads inside of setDataSource
 * and readSampleData.
 */
AMediaDataSourceClose :: #type proc "c" (userdata: rawptr)

/**
 * Called to get an estimate of the number of bytes that can be read from this data source
 * starting at |offset| without blocking for I/O.
 *
 * Return -1 when such an estimate is not possible.
 */
AMediaDataSourceGetAvailableSize :: #type proc "c" (userdata: rawptr, offset: android.off64_t) -> int


foreign mediandk {
	/**
	 * Create new media data source. Returns NULL if memory allocation
	 * for the new data source object fails.
	 *
	 * Available since API level 28.
	 */
	AMediaDataSource_new :: proc() -> ^AMediaDataSource ---

	/**
	* Create new media data source. Returns NULL if memory allocation
	* for the new data source object fails.
	*
	* Set the |uri| from which the data source will read,
	* plus additional http headers when initiating the request.
	*
	* Headers will contain corresponding items from |key_values|
	* in the following fashion:
	*
	* key_values[0]:key_values[1]
	* key_values[2]:key_values[3]
	* ...
	* key_values[(numheaders - 1) * 2]:key_values[(numheaders - 1) * 2 + 1]
	*
	* Available since API level 29.
	*/
	AMediaDataSource_newUri :: proc(uri: cstring, numheaders: i32, key_values: ^[^]u8) -> ^AMediaDataSource ---

	/**
	* Delete a previously created media data source.
	*
	* Available since API level 28.
	*/
	AMediaDataSource_delete :: proc(ds: ^AMediaDataSource) ---

	/**
	* Set an user provided opaque handle. This opaque handle is passed as
	* the first argument to the data source callbacks.
	*
	* Available since API level 28.
	*/
	AMediaDataSource_setUserdata :: proc(ds: ^AMediaDataSource, userdata: rawptr) ---

	/**
	* Set a custom callback for supplying random access media data to the
	* NDK media framework.
	*
	* Implement this if your app has special requirements for the way media
	* data is obtained, or if you need a callback when data is read by the
	* NDK media framework.
	*
	* Please refer to the definition of AMediaDataSourceReadAt for
	* additional details.
	*
	* Available since API level 28.
	*/
	AMediaDataSource_setReadAt :: proc(ds: ^AMediaDataSource, cb: AMediaDataSourceReadAt) ---

	/**
	* Set a custom callback for supplying the size of the data source to the
	* NDK media framework.
	*
	* Please refer to the definition of AMediaDataSourceGetSize for
	* additional details.
	*
	* Available since API level 28.
	*/
	AMediaDataSource_setGetSize :: proc(ds: ^AMediaDataSource, cb: AMediaDataSourceGetSize) ---

	/**
	* Set a custom callback to receive signal from the NDK media framework
	* when the data source is closed.
	*
	* Please refer to the definition of AMediaDataSourceClose for
	* additional details.
	*
	* Available since API level 28.
	*/
	AMediaDataSource_setClose :: proc(ds: ^AMediaDataSource, cb: AMediaDataSourceClose) ---

	/**
	* Close the data source, unblock reads, and release associated resources.
	*
	* Please refer to the definition of AMediaDataSourceClose for
	* additional details.
	*
	* Available since API level 29.
	*/
	AMediaDataSource_close :: proc(ds: ^AMediaDataSource) ---

	/**
	* Set a custom callback for supplying the estimated number of bytes
	* that can be read from this data source starting at an offset without
	* blocking for I/O.
	*
	* Please refer to the definition of AMediaDataSourceGetAvailableSize
	* for additional details.
	*
	* Available since API level 29.
	*/
	AMediaDataSource_setGetAvailableSize :: proc(ds: ^AMediaDataSource, cb: AMediaDataSourceGetAvailableSize) ---
}
