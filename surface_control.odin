package android

foreign import android "system:android"

/**
* Parameter for ASurfaceTransaction_setVisibility().
*/
SurfaceTransactionVisibility :: enum i8 {
	HIDE = 0,
	SHOW = 1,
}

/**
* Parameter for ASurfaceTransaction_setBufferTransparency().
*/
SurfaceTransactionTransparency :: enum i8 {
	TRANSPARENT = 0,
	TRANSLUCENT = 1,
	OPAQUE = 2,
}

/**
 * The SurfaceControl API can be used to provide a hierarchy of surfaces for
 * composition to the system compositor. ASurfaceControl represents a content node in
 * this hierarchy.
 */
ASurfaceControl :: struct{}

/**
* ASurfaceTransaction is a collection of updates to the surface tree that must
* be applied atomically.
*/
ASurfaceTransaction :: struct{}

/**
* An opaque handle returned during a callback that can be used to query general stats and stats for
* surfaces which were either removed or for which buffers were updated after this transaction was
* applied.
*/
ASurfaceTransactionStats :: struct{}

/**
* Since the transactions are applied asynchronously, the
* ASurfaceTransaction_OnComplete callback can be used to be notified when a frame
* including the updates in a transaction was presented.
*
* Buffers which are replaced or removed from the scene in the transaction invoking
* this callback may be reused after this point.
*
* \param context Optional context provided by the client that is passed into
* the callback.
*
* \param stats Opaque handle that can be passed to ASurfaceTransactionStats functions to query
* information about the transaction. The handle is only valid during the callback.
*
* THREADING
* The transaction completed callback can be invoked on any thread.
*
* Available since API level 29.
*/
ASurfaceTransaction_OnComplete :: #type proc "c" (_context: rawptr, stats: ^ASurfaceTransactionStats)

/**
* The ASurfaceTransaction_OnCommit callback is invoked when transaction is applied and the updates
* are ready to be presented. This callback will be invoked before the
* ASurfaceTransaction_OnComplete callback.
*
* This callback does not mean buffers have been released! It simply means that any new
* transactions applied will not overwrite the transaction for which we are receiving
* a callback and instead will be included in the next frame. If you are trying to avoid
* dropping frames (overwriting transactions), and unable to use timestamps (Which provide
* a more efficient solution), then this method provides a method to pace your transaction
* application.
*
* \param context Optional context provided by the client that is passed into the callback.
*
* \param stats Opaque handle that can be passed to ASurfaceTransactionStats functions to query
* information about the transaction. The handle is only valid during the callback.
* Present and release fences are not available for this callback. Querying them using
* ASurfaceTransactionStats_getPresentFenceFd and ASurfaceTransactionStats_getPreviousReleaseFenceFd
* will result in failure.
*
* THREADING
* The transaction committed callback can be invoked on any thread.
*
* Available since API level 31.
*/
ASurfaceTransaction_OnCommit :: #type proc "c" (_context: rawptr, stats: ^ASurfaceTransactionStats)

foreign android {
	/**
	 * Creates an ASurfaceControl with either ANativeWindow or an ASurfaceControl as its parent.
	 * \a debug_name is a debug name associated with this surface. It can be used to
	 * identify this surface in the SurfaceFlinger's layer tree. It must not be
	 * null.
	 *
	 * The caller takes ownership of the ASurfaceControl returned and must release it
	 * using ASurfaceControl_release below.
	 *
	 * Available since API level 29.
	 */
	ASurfaceControl_createFromWindow :: proc(parent: ^ANativeWindow, debug_name: cstring) -> ^ASurfaceControl ---

	/**
	* See ASurfaceControl_createFromWindow.
	*
	* Available since API level 29.
	*/
	ASurfaceControl_create :: proc(parent: ^ASurfaceControl, debug_name: cstring) -> ^ASurfaceControl ---

	/**
	* Acquires a reference on the given ASurfaceControl object.  This prevents the object
	* from being deleted until the reference is removed.
	*
	* To release the reference, use the ASurfaceControl_release function.
	*
	* Available since API level 31.
	*/
	ASurfaceControl_acquire :: proc(surface_control: ^ASurfaceControl) ---

	/**
	* Removes a reference that was previously acquired with one of the following functions:
	*   ASurfaceControl_createFromWindow
	*   ASurfaceControl_create
	*   ANativeWindow_acquire
	* The surface and its children may remain on display as long as their parent remains on display.
	*
	* Available since API level 29.
	*/
	ASurfaceControl_release :: proc(surface_control: ^ASurfaceControl) ---

	/**
	* The caller takes ownership of the transaction and must release it using
	* ASurfaceTransaction_delete() below.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_create :: proc() -> ^ASurfaceTransaction ---

	/**
	* Destroys the \a transaction object.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_delete :: proc(transaction: ^ASurfaceTransaction) ---

	/**
	* Applies the updates accumulated in \a transaction.
	*
	* Note that the transaction is guaranteed to be applied atomically. The
	* transactions which are applied on the same thread are also guaranteed to be
	* applied in order.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_apply :: proc(transaction: ^ASurfaceTransaction) ---

	/**
	* Returns the timestamp of when the frame was latched by the framework. Once a frame is
	* latched by the framework, it is presented at the following hardware vsync.
	*
	* Available since API level 29.
	*/
	ASurfaceTransactionStats_getLatchTime :: proc(surface_transaction_stats: ^ASurfaceTransactionStats) -> i64 ---

	/**
	* Returns a sync fence that signals when the transaction has been presented.
	* The recipient of the callback takes ownership of the fence and is responsible for closing
	* it. If a device does not support present fences, a -1 will be returned.
	*
	* This query is not valid for ASurfaceTransaction_OnCommit callback.
	*
	* Available since API level 29.
	*/
	ASurfaceTransactionStats_getPresentFenceFd :: proc(surface_transaction_stats: ^ASurfaceTransactionStats) -> i32 ---

	/**
	* \a outASurfaceControls returns an array of ASurfaceControl pointers that were updated during the
	* transaction. Stats for the surfaces can be queried through ASurfaceTransactionStats functions.
	* When the client is done using the array, it must release it by calling
	* ASurfaceTransactionStats_releaseASurfaceControls.
	*
	* Available since API level 29.
	*
	* \a outASurfaceControlsSize returns the size of the ASurfaceControls array.
	*/
	ASurfaceTransactionStats_getASurfaceControls :: proc(surface_transaction_stats: ^ASurfaceTransactionStats, outASurfaceControls: ^^^ASurfaceControl, outASurfaceControlsSize: ^uint) ---
	/**
	* Releases the array of ASurfaceControls that were returned by
	* ASurfaceTransactionStats_getASurfaceControls().
	*
	* Available since API level 29.
	*/
	ASurfaceTransactionStats_releaseASurfaceControls :: proc(surface_controls: ^^ASurfaceControl) ---

	/**
	* Returns the timestamp of when the CURRENT buffer was acquired. A buffer is considered
	* acquired when its acquire_fence_fd has signaled. A buffer cannot be latched or presented until
	* it is acquired. If no acquire_fence_fd was provided, this timestamp will be set to -1.
	*
	* Available since API level 29.
	*/
	ASurfaceTransactionStats_getAcquireTime :: proc(surface_transaction_stats: ^ASurfaceTransactionStats, surface_control: ^ASurfaceControl) -> i64 ---

	/**
	* The returns the fence used to signal the release of the PREVIOUS buffer set on
	* this surface. If this fence is valid (>=0), the PREVIOUS buffer has not yet been released and the
	* fence will signal when the PREVIOUS buffer has been released. If the fence is -1 , the PREVIOUS
	* buffer is already released. The recipient of the callback takes ownership of the
	* previousReleaseFenceFd and is responsible for closing it.
	*
	* Each time a buffer is set through ASurfaceTransaction_setBuffer() on a transaction
	* which is applied, the framework takes a ref on this buffer. The framework treats the
	* addition of a buffer to a particular surface as a unique ref. When a transaction updates or
	* removes a buffer from a surface, or removes the surface itself from the tree, this ref is
	* guaranteed to be released in the OnComplete callback for this transaction. The
	* ASurfaceControlStats provided in the callback for this surface may contain an optional fence
	* which must be signaled before the ref is assumed to be released.
	*
	* The client must ensure that all pending refs on a buffer are released before attempting to reuse
	* this buffer, otherwise synchronization errors may occur.
	*
	* This query is not valid for ASurfaceTransaction_OnCommit callback.
	*
	* Available since API level 29.
	*/
	ASurfaceTransactionStats_getPreviousReleaseFenceFd :: proc(surface_transaction_stats: ^ASurfaceTransactionStats, surface_control: ^ASurfaceControl) -> i32 ---

	/**
	* Sets the callback that will be invoked when the updates from this transaction
	* are presented. For details on the callback semantics and data, see the
	* comments on the ASurfaceTransaction_OnComplete declaration above.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setOnComplete :: proc(transaction: ^ASurfaceTransaction, _context: rawptr, func: ASurfaceTransaction_OnComplete) ---

	/**
	* Sets the callback that will be invoked when the updates from this transaction are applied and are
	* ready to be presented. This callback will be invoked before the ASurfaceTransaction_OnComplete
	* callback.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setOnCommit :: proc(transaction: ^ASurfaceTransaction, _context: rawptr, func: ASurfaceTransaction_OnCommit) ---

	/**
	* Reparents the \a surface_control from its old parent to the \a new_parent surface control.
	* Any children of the reparented \a surface_control will remain children of the \a surface_control.
	*
	* The \a new_parent can be null. Surface controls with a null parent do not appear on the display.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_reparent :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, new_parent: ^ASurfaceControl) ---

	/**
	* Updates the visibility of \a surface_control. If show is set to
	* ASURFACE_TRANSACTION_VISIBILITY_HIDE, the \a surface_control and all surfaces in its subtree will
	* be hidden.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setVisibility :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, visibility: SurfaceTransactionVisibility) ---

	/**
	* Updates the z order index for \a surface_control. Note that the z order for a surface
	* is relative to other surfaces which are siblings of this surface. The behavior of sibilings with
	* the same z order is undefined.
	*
	* Z orders may be from MIN_INT32 to MAX_INT32. A layer's default z order index is 0.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setZOrder :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, z_order: i32) ---

	/**
	* Updates the AHardwareBuffer displayed for \a surface_control. If not -1, the
	* acquire_fence_fd should be a file descriptor that is signaled when all pending work
	* for the buffer is complete and the buffer can be safely read.
	*
	* The frameworks takes ownership of the \a acquire_fence_fd passed and is responsible
	* for closing it.
	*
	* Note that the buffer must be allocated with AHARDWAREBUFFER_USAGE_GPU_SAMPLED_IMAGE
	* as the surface control might be composited using the GPU.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setBuffer :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, buffer: ^AHardwareBuffer, acquire_fence_fd: i32 = -1) ---

	/**
	* Updates the color for \a surface_control.  This will make the background color for the
	* ASurfaceControl visible in transparent regions of the surface.  Colors \a r, \a g,
	* and \a b must be within the range that is valid for \a dataspace.  \a dataspace and \a alpha
	* will be the dataspace and alpha set for the background color layer.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setColor :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, r: f32, g: f32, b: f32, alpha: f32, dataspace: ADataSpace) ---

	/**
	* \param source The sub-rect within the buffer's content to be rendered inside the surface's area
	* The surface's source rect is clipped by the bounds of its current buffer. The source rect's width
	* and height must be > 0.
	*
	* \param destination Specifies the rect in the parent's space where this surface will be drawn. The post
	* source rect bounds are scaled to fit the destination rect. The surface's destination rect is
	* clipped by the bounds of its parent. The destination rect's width and height must be > 0.
	*
	* \param transform The transform applied after the source rect is applied to the buffer. This parameter
	* should be set to 0 for no transform. To specify a transfrom use the NATIVE_WINDOW_TRANSFORM_*
	* enum.
	*
	* Available since API level 29.
	*
	* @deprecated Use setCrop, setPosition, setBufferTransform, and setScale instead. Those functions
	* provide well defined behavior and allows for more control by the apps. It also allows the caller
	* to set different properties at different times, instead of having to specify all the desired
	* properties at once.
	*/
	ASurfaceTransaction_setGeometry :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, source: ^ARect, destination: ^ARect, transform: ANativeWindowTransform) ---

	/**
	* Bounds the surface and its children to the bounds specified. The crop and buffer size will be
	* used to determine the bounds of the surface. If no crop is specified and the surface has no
	* buffer, the surface bounds is only constrained by the size of its parent bounds.
	*
	* \param crop The bounds of the crop to apply.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setCrop :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, crop: ^ARect) ---

	/**
	* Specifies the position in the parent's space where the surface will be drawn.
	*
	* \param x The x position to render the surface.
	* \param y The y position to render the surface.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setPosition :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, x: i32, y: i32) ---

	/**
	* \param transform The transform applied after the source rect is applied to the buffer. This
	* parameter should be set to 0 for no transform. To specify a transform use the
	* NATIVE_WINDOW_TRANSFORM_* enum.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setBufferTransform :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, transform: ANativeWindowTransform) ---

	/**
	* Sets an x and y scale of a surface with (0, 0) as the centerpoint of the scale.
	*
	* \param xScale The scale in the x direction. Must be greater than 0.
	* \param yScale The scale in the y direction. Must be greater than 0.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setScale :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, xScale: f32, yScale: f32) ---

	/**
	* Updates whether the content for the buffer associated with this surface is
	* completely opaque. If true, every pixel of content inside the buffer must be
	* opaque or visual errors can occur.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setBufferTransparency :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, transparency: SurfaceTransactionTransparency) ---

	/**
	* Updates the region for the content on this surface updated in this
	* transaction. If unspecified, the complete surface is assumed to be damaged.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setDamageRegion :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, rects: [^]ARect , count: u32) ---

	/**
	* Specifies a desiredPresentTime for the transaction. The framework will try to present
	* the transaction at or after the time specified.
	*
	* Transactions will not be presented until all of their acquire fences have signaled even if the
	* app requests an earlier present time.
	*
	* If an earlier transaction has a desired present time of x, and a later transaction has a desired
	* present time that is before x, the later transaction will not preempt the earlier transaction.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setDesiredPresentTime :: proc(transaction: ^ASurfaceTransaction, desiredPresentTime: i64) ---

	/**
	* Sets the alpha for the buffer. It uses a premultiplied blending.
	*
	* The \a alpha must be between 0.0 and 1.0.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setBufferAlpha :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, alpha: f32) ---

	/**
	* Sets the data space of the surface_control's buffers.
	*
	* If no data space is set, the surface control defaults to ADATASPACE_SRGB.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setBufferDataSpace :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, data_space: ADataSpace) ---

	/**
	* SMPTE ST 2086 "Mastering Display Color Volume" static metadata
	*
	* When \a metadata is set to null, the framework does not use any smpte2086 metadata when rendering
	* the surface's buffer.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setHdrMetadata_smpte2086 :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, metadata: ^AHdrMetadata_smpte2086) ---

	/**
	* Sets the CTA 861.3 "HDR Static Metadata Extension" static metadata on a surface.
	*
	* When \a metadata is set to null, the framework does not use any cta861.3 metadata when rendering
	* the surface's buffer.
	*
	* Available since API level 29.
	*/
	ASurfaceTransaction_setHdrMetadata_cta861_3 :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, metadata: ^AHdrMetadata_cta861_3) ---

	/**
	* Same as ASurfaceTransaction_setFrameRateWithChangeStrategy(transaction, surface_control,
	* frameRate, compatibility, ANATIVEWINDOW_CHANGE_FRAME_RATE_ONLY_IF_SEAMLESS).
	*
	* See ASurfaceTransaction_setFrameRateWithChangeStrategy().
	*
	* Available since API level 30.
	*/
	ASurfaceTransaction_setFrameRate :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility) ---

	/**
	* Sets the intended frame rate for \a surface_control.
	*
	* On devices that are capable of running the display at different refresh rates, the system may
	* choose a display refresh rate to better match this surface's frame rate. Usage of this API won't
	* directly affect the application's frame production pipeline. However, because the system may
	* change the display refresh rate, calls to this function may result in changes to Choreographer
	* callback timings, and changes to the time interval at which the system releases buffers back to
	* the application.
	*
	* You can register for changes in the refresh rate using
	* \a AChoreographer_registerRefreshRateCallback.
	*
	* \param frameRate is the intended frame rate of this surface, in frames per second. 0 is a special
	* value that indicates the app will accept the system's choice for the display frame rate, which is
	* the default behavior if this function isn't called. The frameRate param does <em>not</em> need to
	* be a valid refresh rate for this device's display - e.g., it's fine to pass 30fps to a device
	* that can only run the display at 60fps.
	*
	* \param compatibility The frame rate compatibility of this surface. The compatibility value may
	* influence the system's choice of display frame rate. To specify a compatibility use the
	* ANATIVEWINDOW_FRAME_RATE_COMPATIBILITY_* enum. This parameter is ignored when frameRate is 0.
	*
	* \param changeFrameRateStrategy Whether display refresh rate transitions caused by this
	* surface should be seamless. A seamless transition is one that doesn't have any visual
	* interruptions, such as a black screen for a second or two. See the
	* ANATIVEWINDOW_CHANGE_FRAME_RATE_* values. This parameter is ignored when frameRate is 0.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setFrameRateWithChangeStrategy :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, frameRate: f32, compatibility: ANativeWindow_FrameRateCompatibility, changeFrameRateStrategy: ANativeWindow_ChangeFrameRateStrategy) ---

	/**
	* Indicate whether to enable backpressure for buffer submission to a given SurfaceControl.
	*
	* By default backpressure is disabled, which means submitting a buffer prior to receiving
	* a callback for the previous buffer could lead to that buffer being "dropped". In cases
	* where you are selecting for latency, this may be a desirable behavior! We had a new buffer
	* ready, why shouldn't we show it?
	*
	* When back pressure is enabled, each buffer will be required to be presented
	* before it is released and the callback delivered
	* (absent the whole SurfaceControl being removed).
	*
	* Most apps are likely to have some sort of backpressure internally, e.g. you are
	* waiting on the callback from frame N-2 before starting frame N. In high refresh
	* rate scenarios there may not be much time between SurfaceFlinger completing frame
	* N-1 (and therefore releasing buffer N-2) and beginning frame N. This means
	* your app may not have enough time to respond in the callback. Using this flag
	* and pushing buffers earlier for server side queuing will be advantageous
	* in such cases.
	*
	* \param transaction The transaction in which to make the change.
	* \param surface_control The ASurfaceControl on which to control buffer backpressure behavior.
	* \param enableBackPressure Whether to enable back pressure.
	*
	* Available since API level 31.
	*/
	ASurfaceTransaction_setEnableBackPressure :: proc(transaction: ^ASurfaceTransaction, surface_control: ^ASurfaceControl, enableBackPressure: bool) ---

	/**
	* Sets the frame timeline to use in SurfaceFlinger.
	*
	* A frame timeline should be chosen based on the frame deadline the application
	* can meet when rendering the frame and the application's desired presentation time.
	* By setting a frame timeline, SurfaceFlinger tries to present the frame at the corresponding
	* expected presentation time.
	*
	* To receive frame timelines, a callback must be posted to Choreographer using
	* AChoreographer_postVsyncCallback(). The \c vsyncId can then be extracted from the
	* callback payload using AChoreographerFrameCallbackData_getFrameTimelineVsyncId().
	*
	* \param vsyncId The vsync ID received from AChoreographer, setting the frame's presentation target
	* to the corresponding expected presentation time and deadline from the frame to be rendered. A
	* stale or invalid value will be ignored.
	*
	* Available since API level 33.
	*/
	ASurfaceTransaction_setFrameTimeline :: proc(transaction: ^ASurfaceTransaction, vsyncId: AVsyncId) ---
}
