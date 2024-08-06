//+build android
package android

import "core:c"

foreign import android "system:android"

/**
 * Opaque type that provides access to an AChoreographer object.
 *
 * A pointer can be obtained using {@link AChoreographer_getInstance()}.
 */
AChoreographer :: struct{}

/**
 * The identifier of a frame timeline.
 */
AVsyncId :: i64

/**
 * Opaque type that provides access to an AChoreographerFrameCallbackData object, which contains
 * various methods to extract frame information.
 */
AChoreographerFrameCallbackData :: struct{}

/**
 * Prototype of the function that is called when a new frame is being rendered.
 * It's passed the time that the frame is being rendered as nanoseconds in the
 * CLOCK_MONOTONIC time base, as well as the data pointer provided by the
 * application that registered a callback. All callbacks that run as part of
 * rendering a frame will observe the same frame time, so it should be used
 * whenever events need to be synchronized (e.g. animations).
 */
AChoreographer_frameCallback :: #type proc "c" (frameTimeNanos: c.long, data: rawptr)

/**
 * Prototype of the function that is called when a new frame is being rendered.
 * It's passed the time that the frame is being rendered as nanoseconds in the
 * CLOCK_MONOTONIC time base, as well as the data pointer provided by the
 * application that registered a callback. All callbacks that run as part of
 * rendering a frame will observe the same frame time, so it should be used
 * whenever events need to be synchronized (e.g. animations).
 */
AChoreographer_frameCallback64 :: #type proc "c" (frameTimeNanos: i64, data: rawptr)

/**
 * Prototype of the function that is called when a new frame is being rendered.
 * It is called with \c callbackData describing multiple frame timelines, as well as the \c data
 * pointer provided by the application that registered a callback. The \c callbackData does not
 * outlive the callback.
 */
AChoreographer_vsyncCallback :: #type proc "c" (callbackData: ^AChoreographerFrameCallbackData, data: rawptr)

/**
 * Prototype of the function that is called when the display refresh rate
 * changes. It's passed the new vsync period in nanoseconds, as well as the data
 * pointer provided by the application that registered a callback.
 */
AChoreographer_refreshRateCallback :: #type proc "c" (vsyncPeriodNanos: i64, data: rawptr)


foreign android {
	/**
	 * Get the AChoreographer instance for the current thread. This must be called
	 * on an ALooper thread.
	 *
	 * Available since API level 24.
	 */
	AChoreographer_getInstance :: proc() -> ^AChoreographer ---

	/**
	* Deprecated: Use AChoreographer_postFrameCallback64 instead.
	* Deprecated since API level 29
	*/
	@(deprecated="Use AChoreographer_postFrameCallback64 instead")
	AChoreographer_postFrameCallback :: proc(choreographer: ^AChoreographer, callback: AChoreographer_frameCallback, data: rawptr) ---

	/**
	* Deprecated: Use AChoreographer_postFrameCallbackDelayed64 instead.
	* Deprecated since API level 29
	*/
	@(deprecated="Use AChoreographer_postFrameCallbackDelayed64 instead")
	AChoreographer_postFrameCallbackDelayed :: proc(choreographer: ^AChoreographer, callback: AChoreographer_frameCallback, data: rawptr, delayMillis: c.long) ---

	/**
	* Post a callback to be run on the next frame.  The data pointer provided will
	* be passed to the callback function when it's called.
	*
	* Available since API level 29.
	*/
	AChoreographer_postFrameCallback64 :: proc(choreographer: ^AChoreographer, callback: AChoreographer_frameCallback64, data: rawptr) ---

	/**
	* Post a callback to be run on the frame following the specified delay.  The
	* data pointer provided will be passed to the callback function when it's
	* called.
	*
	* Available since API level 29.
	*/
	AChoreographer_postFrameCallbackDelayed64 :: proc(choreographer: ^AChoreographer, callback: AChoreographer_frameCallback64, data: rawptr, delayMillis: u32) ---

	/**
	* Posts a callback to be run on the next frame. The data pointer provided will
	* be passed to the callback function when it's called.
	*
	* Available since API level 33.
	*/
	AChoreographer_postVsyncCallback :: proc(choreographer: ^AChoreographer, callback: AChoreographer_vsyncCallback, data: rawptr) ---

	/**
	* Registers a callback to be run when the display refresh rate changes. The
	* data pointer provided will be passed to the callback function when it's
	* called. The same callback may be registered multiple times, provided that a
	* different data pointer is provided each time.
	*
	* If an application registers a callback for this choreographer instance when
	* no new callbacks were previously registered, that callback is guaranteed to
	* be dispatched. However, if the callback and associated data pointer are
	* unregistered prior to running the callback, then the callback may be silently
	* dropped.
	*
	* This api is thread-safe. Any thread is allowed to register a new refresh
	* rate callback for the choreographer instance.
	*
	* Note that in API level 30, this api is not guaranteed to be atomic with
	* DisplayManager. That is, calling Display#getRefreshRate very soon after
	* a refresh rate callback is invoked may return a stale refresh rate. If any
	* Display properties would be required by this callback, then it is recommended
	* to listen directly to DisplayManager.DisplayListener#onDisplayChanged events
	* instead.
	*
	* As of API level 31, this api is guaranteed to have a consistent view with DisplayManager
	* Display#getRefreshRate is guaranteed to not return a stale refresh rate when invoked from this
	* callback.
	*
	* Available since API level 30.
	*/
	AChoreographer_registerRefreshRateCallback :: proc(choreographer: ^AChoreographer, callback: AChoreographer_refreshRateCallback, data: rawptr) ---

	/**
	* Unregisters a callback to be run when the display refresh rate changes, along
	* with the data pointer previously provided when registering the callback. The
	* callback is only unregistered when the data pointer matches one that was
	* previously registered.
	*
	* This api is thread-safe. Any thread is allowed to unregister an existing
	* refresh rate callback for the choreographer instance. When a refresh rate
	* callback and associated data pointer are unregistered, then there is a
	* guarantee that when the unregistration completes that that callback will not
	* be run with the data pointer passed.
	*
	* Available since API level 30.
	*/
	AChoreographer_unregisterRefreshRateCallback :: proc(choreographer: ^AChoreographer, callback: AChoreographer_refreshRateCallback, data: rawptr) ---

	/**
	* The time in nanoseconds at which the frame started being rendered.
	*
	* Note that this time should \b not be used to advance animation clocks.
	* Instead, see AChoreographerFrameCallbackData_getFrameTimelineExpectedPresentationTimeNanos().
	*/
	AChoreographerFrameCallbackData_getFrameTimeNanos :: proc(data: ^AChoreographerFrameCallbackData) -> i64 ---

	/**
	* The number of possible frame timelines.
	*/
	AChoreographerFrameCallbackData_getFrameTimelinesLength :: proc(data: ^AChoreographerFrameCallbackData) -> uint ---

	/**
	* Gets the index of the platform-preferred frame timeline.
	* The preferred frame timeline is the default
	* by which the platform scheduled the app, based on the device configuration.
	*/
	AChoreographerFrameCallbackData_getPreferredFrameTimelineIndex :: proc(data: ^AChoreographerFrameCallbackData) -> uint ---

	/**
	* Gets the token used by the platform to identify the frame timeline at the given \c index.
	*
	* \param index index of a frame timeline, in \f( [0, FrameTimelinesLength) \f). See
	* AChoreographerFrameCallbackData_getFrameTimelinesLength()
	*/
	AChoreographerFrameCallbackData_getFrameTimelineVsyncId :: proc(data: ^AChoreographerFrameCallbackData, index: uint) -> AVsyncId ---

	/**
	* Gets the time in nanoseconds at which the frame described at the given \c index is expected to
	* be presented. This time should be used to advance any animation clocks.
	*
	* \param index index of a frame timeline, in \f( [0, FrameTimelinesLength) \f). See
	* AChoreographerFrameCallbackData_getFrameTimelinesLength()
	*/
	AChoreographerFrameCallbackData_getFrameTimelineExpectedPresentationTimeNanos :: proc(data: ^AChoreographerFrameCallbackData, index: uint) -> i64 ---

	/**
	* Gets the time in nanoseconds at which the frame described at the given \c index needs to be
	* ready by in order to be presented on time.
	*
	* \param index index of a frame timeline, in \f( [0, FrameTimelinesLength) \f). See
	* AChoreographerFrameCallbackData_getFrameTimelinesLength()
	*/
	AChoreographerFrameCallbackData_getFrameTimelineDeadlineNanos :: proc(data: ^AChoreographerFrameCallbackData, index: uint) -> i64 ---
}
