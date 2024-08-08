//+build android
package camerandk

foreign import camerandk "system:camera2ndk"

/// Enum for describing error reason in {@link ACameraCaptureFailure}
CaptureFailureReason :: enum i32 {
    /**
     * The capture session has dropped this frame due to an
     * {@link ACameraCaptureSession_abortCaptures} call.
     */
    FLUSHED = 0,

    /**
     * The capture session has dropped this frame due to an error in the framework.
     */
    ERROR
}

CaptureSequenceId :: enum i32 {
    NONE = -1
}

/**
 * ACameraCaptureSession is an opaque type that manages frame captures of a camera device.
 *
 * A pointer can be obtained using {@link ACameraDevice_createCaptureSession} method.
 */
ACameraCaptureSession :: struct{}


/**
 * Capture session state callbacks used in {@link ACameraDevice_createCaptureSession} and
 * {@link ACameraDevice_createCaptureSessionWithSessionParameters}
 */
ACameraCaptureSession_stateCallbacks :: struct {
    /// optional application context.
	_context: rawptr,

    /**
     * This callback is called when the session is closed and deleted from memory.
     *
     * <p>A session is closed when {@link ACameraCaptureSession_close} is called, a new session
     * is created by the parent camera device,
     * or when the parent camera device is closed (either by the user closing the device,
     * or due to a camera device disconnection or fatal error).</p>
     *
     * <p>Once this callback is called, all access to this ACameraCaptureSession object will cause
     * a crash.</p>
     */
    onClosed: ACameraCaptureSession_stateCallback,

    /**
     * This callback is called every time the session has no more capture requests to process.
     *
     * <p>This callback will be invoked any time the session finishes processing
     * all of its active capture requests, and no repeating request or burst is set up.</p>
     */
    onReady: ACameraCaptureSession_stateCallback,

    /**
     * This callback is called when the session starts actively processing capture requests.
     *
     * <p>If the session runs out of capture requests to process and calls {@link onReady},
     * then this callback will be invoked again once new requests are submitted for capture.</p>
     */
    onActive: ACameraCaptureSession_stateCallback,
}

/// Struct to describe a capture failure
ACameraCaptureFailure :: struct {
    /**
     * The frame number associated with this failed capture.
     *
     * <p>Whenever a request has been processed, regardless of failed capture or success,
     * it gets a unique frame number assigned to its future result/failed capture.</p>
     *
     * <p>This value monotonically increments, starting with 0,
     * for every new result or failure, and the scope is the lifetime of the
     * {@link ACameraDevice}.</p>
     */
	frameNumber: i64,

    /**
     * Determine why the request was dropped, whether due to an error or to a user
     * action.
     *
     * @see CAPTURE_FAILURE_REASON_ERROR
     * @see CAPTURE_FAILURE_REASON_FLUSHED
     */
    reason: CaptureFailureReason,

    /**
     * The sequence ID for this failed capture that was returned by the
     * {@link ACameraCaptureSession_capture} or {@link ACameraCaptureSession_setRepeatingRequest}.
     *
     * <p>The sequence ID is a unique monotonically increasing value starting from 0,
     * incremented every time a new group of requests is submitted to the ACameraDevice.</p>
     */
    sequenceId: i32,

    /**
     * Determine if the image was captured from the camera.
     *
     * <p>If the image was not captured, no image buffers will be available.
     * If the image was captured, then image buffers may be available.</p>
     *
     */
    wasImageCaptured: bool,
}

/**
 * ACaptureCaptureSession_captureCallbacks structure used in
 * {@link ACameraCaptureSession_capture} and {@link ACameraCaptureSession_setRepeatingRequest}.
 */
ACameraCaptureSession_captureCallbacks :: struct {
    /// optional application context.
	_context: rawptr,

    /**
     * This callback is called when the camera device has started capturing
     * the output image for the request, at the beginning of image exposure.
     *
     * <p>This callback is invoked right as
     * the capture of a frame begins, so it is the most appropriate time
     * for playing a shutter sound, or triggering UI indicators of capture.</p>
     *
     * <p>The request that is being used for this capture is provided, along
     * with the actual timestamp for the start of exposure.
     * This timestamp matches the timestamps that will be
     * included in {@link ACAMERA_SENSOR_TIMESTAMP} of the {@link ACameraMetadata} in
     * {@link onCaptureCompleted} callback,
     * and in the buffers sent to each output ANativeWindow. These buffer
     * timestamps are accessible through, for example,
     * {@link AImage_getTimestamp} or
     * <a href="http://developer.android.com/reference/android/graphics/SurfaceTexture.html#getTimestamp()">
     * android.graphics.SurfaceTexture#getTimestamp()</a>.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     *
     */
    onCaptureStarted: ACameraCaptureSession_captureCallback_start,

    /**
     * This callback is called when an image capture makes partial forward progress, some
     * (but not all) results from an image capture are available.
     *
     * <p>The result provided here will contain some subset of the fields of
     * a full result. Multiple {@link onCaptureProgressed} calls may happen per
     * capture, a given result field will only be present in one partial
     * capture at most. The final {@link onCaptureCompleted} call will always
     * contain all the fields (in particular, the union of all the fields of all
     * the partial results composing the total result).</p>
     *
     * <p>For each request, some result data might be available earlier than others. The typical
     * delay between each partial result (per request) is a single frame interval.
     * For performance-oriented use-cases, applications should query the metadata they need
     * to make forward progress from the partial results and avoid waiting for the completed
     * result.</p>
     *
     * <p>For a particular request, {@link onCaptureProgressed} may happen before or after
     * {@link onCaptureStarted}.</p>
     *
     * <p>Each request will generate at least `1` partial results, and at most
     * {@link ACAMERA_REQUEST_PARTIAL_RESULT_COUNT} partial results.</p>
     *
     * <p>Depending on the request settings, the number of partial results per request
     * will vary, although typically the partial count could be the same as long as the
     * camera device subsystems enabled stay the same.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     */
    onCaptureProgressed: ACameraCaptureSession_captureCallback_result,

    /**
     * This callback is called when an image capture has fully completed and all the
     * result metadata is available.
     *
     * <p>This callback will always fire after the last {@link onCaptureProgressed},
     * in other words, no more partial results will be delivered once the completed result
     * is available.</p>
     *
     * <p>For performance-intensive use-cases where latency is a factor, consider
     * using {@link onCaptureProgressed} instead.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     */
    onCaptureCompleted: ACameraCaptureSession_captureCallback_result,

    /**
     * This callback is called instead of {@link onCaptureCompleted} when the
     * camera device failed to produce a capture result for the
     * request.
     *
     * <p>Other requests are unaffected, and some or all image buffers from
     * the capture may have been pushed to their respective output
     * streams.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     *
     * @see ACameraCaptureFailure
     */
    onCaptureFailed: ACameraCaptureSession_captureCallback_failed,

    /**
     * This callback is called independently of the others in {@link ACameraCaptureSession_captureCallbacks},
     * when a capture sequence finishes and all capture result
     * or capture failure for it have been returned via this {@link ACameraCaptureSession_captureCallbacks}.
     *
     * <p>In total, there will be at least one result/failure returned by this listener
     * before this callback is invoked. If the capture sequence is aborted before any
     * requests have been processed, {@link onCaptureSequenceAborted} is invoked instead.</p>
     */
    onCaptureSequenceCompleted: ACameraCaptureSession_captureCallback_sequenceEnd,

    /**
     * This callback is called independently of the others in {@link ACameraCaptureSession_captureCallbacks},
     * when a capture sequence aborts before any capture result
     * or capture failure for it have been returned via this {@link ACameraCaptureSession_captureCallbacks}.
     *
     * <p>Due to the asynchronous nature of the camera device, not all submitted captures
     * are immediately processed. It is possible to clear out the pending requests
     * by a variety of operations such as {@link ACameraCaptureSession_stopRepeating} or
     * {@link ACameraCaptureSession_abortCaptures}. When such an event happens,
     * {@link onCaptureSequenceCompleted} will not be called.</p>
     */
    onCaptureSequenceAborted: ACameraCaptureSession_captureCallback_sequenceAbort,

    /**
     * This callback is called if a single buffer for a capture could not be sent to its
     * destination ANativeWindow.
     *
     * <p>If the whole capture failed, then {@link onCaptureFailed} will be called instead. If
     * some but not all buffers were captured but the result metadata will not be available,
     * then onCaptureFailed will be invoked with {@link ACameraCaptureFailure#wasImageCaptured}
     * returning true, along with one or more calls to {@link onCaptureBufferLost} for the
     * failed outputs.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.
     * The ANativeWindow pointer will always match what application submitted in
     * {@link ACameraDevice_createCaptureSession}</p>
     *
     */
    onCaptureBufferLost: ACameraCaptureSession_captureCallback_bufferLost,
}

/**
 * Opaque object for capture session output, use {@link ACaptureSessionOutput_create} or
 * {@link ACaptureSessionSharedOutput_create} to create an instance.
 */
ACaptureSessionOutput :: struct{}

/// Struct to describe a logical camera capture failure
ALogicalCameraCaptureFailure :: struct {
    /**
     * The {@link ACameraCaptureFailure} contains information about regular logical device capture
     * failure.
     */
	captureFailure: ACameraCaptureFailure,

    /**
     * The physical camera device ID in case the capture failure comes from a capture request
     * with configured physical camera streams for a logical camera. physicalCameraId will be set
     * to NULL in case the capture request has no associated physical camera device.
     *
     */
    physicalCameraId: cstring,
}

/**
 * This has the same functionality as ACameraCaptureSession_captureCallbacks,
 * with the exception that an onLogicalCameraCaptureCompleted callback is
 * used, instead of onCaptureCompleted, to support logical multi-camera.
 */
ACameraCaptureSession_logicalCamera_captureCallbacks :: struct {
    /**
     * Same as ACameraCaptureSession_captureCallbacks
     */
	_context: rawptr,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureStarted}.
     */
    onCaptureStarted: ACameraCaptureSession_captureCallback_start,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureProgressed}.
     */
    onCaptureProgressed: ACameraCaptureSession_captureCallback_result,

    /**
     * This callback is called when an image capture has fully completed and all the
     * result metadata is available. For a logical multi-camera, this callback
     * also returns the result metadata for all physical cameras being
     * explicitly requested on.
     *
     * <p>This callback will always fire after the last {@link onCaptureProgressed},
     * in other words, no more partial results will be delivered once the completed result
     * is available.</p>
     *
     * <p>For performance-intensive use-cases where latency is a factor, consider
     * using {@link onCaptureProgressed} instead.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     */
    onLogicalCameraCaptureCompleted: ACameraCaptureSession_logicalCamera_captureCallback_result,

    /**
     * This callback is called instead of {@link onLogicalCameraCaptureCompleted} when the
     * camera device failed to produce a capture result for the
     * request.
     *
     * <p>Other requests are unaffected, and some or all image buffers from
     * the capture may have been pushed to their respective output
     * streams.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     *
     * @see ALogicalCameraCaptureFailure
     */
    onLogicalCameraCaptureFailed: ACameraCaptureSession_logicalCamera_captureCallback_failed,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceCompleted}.
     */
    onCaptureSequenceCompleted: ACameraCaptureSession_captureCallback_sequenceEnd,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceAborted}.
     */
    onCaptureSequenceAborted: ACameraCaptureSession_captureCallback_sequenceAbort,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureBufferLost}.
     */
    onCaptureBufferLost: ACameraCaptureSession_captureCallback_bufferLost,
}

/**
 * This has the same functionality as ACameraCaptureSession_captureCallbacks,
 * with the exception that captureCallback_startV2 callback is
 * used, instead of captureCallback_start, to support retrieving the frame number.
 */
ACameraCaptureSession_captureCallbacksV2 :: struct {
    /**
     * Same as ACameraCaptureSession_captureCallbacks
     */
	_context: rawptr,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureStarted},
     * except that it has the frame number of the capture added in the parameter
     * list.
     */
    onCaptureStarted: ACameraCaptureSession_captureCallback_startV2,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureProgressed}.
     */
    onCaptureProgressed: ACameraCaptureSession_captureCallback_result,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureCompleted}.
     */
    onCaptureCompleted: ACameraCaptureSession_captureCallback_result,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureFailed}.
     */
    onCaptureFailed: ACameraCaptureSession_captureCallback_failed,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceCompleted}.
     */
    onCaptureSequenceCompleted: ACameraCaptureSession_captureCallback_sequenceEnd,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceAborted}.
     */
    onCaptureSequenceAborted: ACameraCaptureSession_captureCallback_sequenceAbort,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureBufferLost}.
     */
    onCaptureBufferLost: ACameraCaptureSession_captureCallback_bufferLost,
}

/**
 * This has the same functionality as ACameraCaptureSession_logicalCamera_captureCallbacks,
 * with the exception that an captureCallback_startV2 callback is
 * used, instead of captureCallback_start, to support retrieving frame number.
 */
ACameraCaptureSession_logicalCamera_captureCallbacksV2 :: struct {
    /**
     * Same as ACameraCaptureSession_captureCallbacks
     */
	_context: rawptr,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureStarted},
     * except that it has the frame number of the capture added in the parameter
     * list.
     */
    onCaptureStarted: ACameraCaptureSession_captureCallback_startV2,


    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureProgressed}.
     */
    onCaptureProgressed: ACameraCaptureSession_captureCallback_result,

    /**
     * Same as
     * {@link ACameraCaptureSession_logicalCamera_captureCallbacks#onLogicalCaptureCompleted}.
     */
    onLogicalCameraCaptureCompleted: ACameraCaptureSession_logicalCamera_captureCallback_result,

    /**
     * This callback is called instead of {@link onLogicalCameraCaptureCompleted} when the
     * camera device failed to produce a capture result for the
     * request.
     *
     * <p>Other requests are unaffected, and some or all image buffers from
     * the capture may have been pushed to their respective output
     * streams.</p>
     *
     * <p>Note that the ACaptureRequest pointer in the callback will not match what application has
     * submitted, but the contents the ACaptureRequest will match what application submitted.</p>
     *
     * @see ALogicalCameraCaptureFailure
     */
    onLogicalCameraCaptureFailed: ACameraCaptureSession_logicalCamera_captureCallback_failed,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceCompleted}.
     */
    onCaptureSequenceCompleted: ACameraCaptureSession_captureCallback_sequenceEnd,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceAborted}.
     */
    onCaptureSequenceAborted: ACameraCaptureSession_captureCallback_sequenceAbort,

    /**
     * Same as {@link ACameraCaptureSession_captureCallbacks#onCaptureBufferLost}.
     */
    onCaptureBufferLost: ACameraCaptureSession_captureCallback_bufferLost,
}

/**
 * The definition of camera capture session state callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_stateCallbacks}.
 * @param session The camera capture session whose state is changing.
 */
ACameraCaptureSession_stateCallback :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession)

/**
 * The definition of camera capture start callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request that is starting. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param timestamp The timestamp when the capture is started. This timestmap will match
 *                  {@link ACAMERA_SENSOR_TIMESTAMP} of the {@link ACameraMetadata} in
 *                  {@link ACameraCaptureSession_captureCallbacks#onCaptureCompleted} callback.
 */
ACameraCaptureSession_captureCallback_start :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, timestamp: i64)

/**
 * The definition of camera capture progress/result callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request of interest. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param result The capture result metadata reported by camera device. The memory is managed by
 *                camera framework. Do not access this pointer after this callback returns.
 */
ACameraCaptureSession_captureCallback_result :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, result: ^ACameraMetadata)

/**
 * The definition of camera capture failure callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request of interest. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param failure The {@link ACameraCaptureFailure} desribes the capture failure. The memory is
 *                managed by camera framework. Do not access this pointer after this callback
 *                returns.
 */
ACameraCaptureSession_captureCallback_failed :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, failure: ^ACameraCaptureFailure)

/**
 * The definition of camera sequence end callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param sequenceId The capture sequence ID of the finished sequence.
 * @param frameNumber The frame number of the last frame of this sequence.
 */
ACameraCaptureSession_captureCallback_sequenceEnd :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, sequenceId: i32, frameNumber: i64)

/**
 * The definition of camera sequence aborted callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param sequenceId The capture sequence ID of the aborted sequence.
 */
ACameraCaptureSession_captureCallback_sequenceAbort :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, sequenceId: i32)

/**
 * The definition of camera buffer lost callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request of interest. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param window The {@link ANativeWindow} that the lost buffer would have been sent to.
 * @param frameNumber The frame number of the lost buffer.
 */
ACameraCaptureSession_captureCallback_bufferLost :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, window: ^ACameraWindowType, frameNumber: i64)

/**
 * The definition of final capture result callback with logical multi-camera support.
 *
 * This has the same functionality as final ACameraCaptureSession_captureCallback_result, with
 * added ability to return physical camera result metadata within a logical multi-camera.
 *
 * For a logical multi-camera, this function will be called with the Id and result metadata
 * of the underlying physical cameras, which the corresponding capture request contains targets for.
 * If the capture request doesn't contain targets specific to any physical camera, or the current
 * camera device isn't a logical multi-camera, physicalResultCount will be 0.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request of interest. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param result The capture result metadata reported by camera device. The memory is managed by
 *                camera framework. Do not access this pointer after this callback returns.
 * @param physicalResultCount The number of physical camera result metadata
 * @param physicalCameraIds The array of physical camera IDs on which the
 *                physical result metadata are reported.
 * @param physicalResults The array of capture result metadata reported by the
 *                physical camera devices.
 */
ACameraCaptureSession_logicalCamera_captureCallback_result :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, result: ^ACameraMetadata, physicalResultCount: uint, physicalCameraIds: [^]cstring, physicalResults: [^]ACameraMetadata)

/**
 * The definition of logical camera capture failure callback.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request of interest. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param failure The {@link ALogicalCameraCaptureFailure} desribes the capture failure. The memory
 *                is managed by camera framework. Do not access this pointer after this callback
 *                returns.
 */
ACameraCaptureSession_logicalCamera_captureCallback_failed :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, failure: ^ALogicalCameraCaptureFailure)

/**
 * The definition of camera capture start callback. The same as
 * {@link ACameraCaptureSession_captureCallbacks#onCaptureStarted}, except that
 * it has the frame number of the capture as well.
 *
 * @param context The optional application context provided by user in
 *                {@link ACameraCaptureSession_captureCallbacks}.
 * @param session The camera capture session of interest.
 * @param request The capture request that is starting. Note that this pointer points to a copy of
 *                capture request sent by application, so the address is different to what
 *                application sent but the content will match. This request will be freed by
 *                framework immediately after this callback returns.
 * @param timestamp The timestamp when the capture is started. This timestamp will match
 *                  {@link ACAMERA_SENSOR_TIMESTAMP} of the {@link ACameraMetadata} in
 *                  {@link ACameraCaptureSession_captureCallbacks#onCaptureCompleted} callback.
 * @param frameNumber the frame number of the capture started
 */
ACameraCaptureSession_captureCallback_startV2 :: #type proc "c" (_context: rawptr, session: ^ACameraCaptureSession, request: ^ACaptureRequest, timestamp: i64, frameNumber: i64)

foreign camerandk {
	/**
	 * Close this capture session.
	 *
	 * <p>Closing a session frees up the target output Surfaces of the session for reuse with either
	 * a new session, or to other APIs that can draw to Surfaces.</p>
	 *
	 * <p>Note that creating a new capture session with {@link ACameraDevice_createCaptureSession}
	 * will close any existing capture session automatically, and call the older session listener's
	 * {@link ACameraCaptureSession_stateCallbacks#onClosed} callback. Using
	 * {@link ACameraDevice_createCaptureSession} directly without closing is the recommended approach
	 * for quickly switching to a new session, since unchanged target outputs can be reused more
	 * efficiently.</p>
	 *
	 * <p>After a session is closed and before {@link ACameraCaptureSession_stateCallbacks#onClosed}
	 * is called, all methods invoked on the session will return {@link ACAMERA_ERROR_SESSION_CLOSED},
	 * and any repeating requests are stopped (as if {@link ACameraCaptureSession_stopRepeating} was
	 * called). However, any in-progress capture requests submitted to the session will be completed as
	 * normal once all captures have completed and the session has been torn down,
	 * {@link ACameraCaptureSession_stateCallbacks#onClosed} callback will be called and the seesion
	 * will be removed from memory.</p>
	 *
	 * <p>Closing a session is idempotent closing more than once has no effect.</p>
	 *
	 * @param session the capture session of interest
	 */
	ACameraCaptureSession_close :: proc(session: ^ACameraCaptureSession) ---

	/**
	* Get the ACameraDevice pointer associated with this capture session in the device argument
	* if the method succeeds.
	*
	* @param session the capture session of interest
	* @param device the {@link ACameraDevice} associated with session. Will be set to NULL
	*        if the session is closed or this method fails.
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method call succeeds. The {@link ACameraDevice}
	*                                will be stored in device argument</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session or device is NULL</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons</li></ul>
	*
	*/
	ACameraCaptureSession_getDevice :: proc(session: ^ACameraCaptureSession, device: ^^ACameraDevice) -> CameraStatus ---

	/**
	* Submit an array of requests to be captured in sequence as a burst in the minimum of time possible.
	*
	* <p>The burst will be captured in the minimum amount of time possible, and will not be
	* interleaved with requests submitted by other capture or repeat calls.</p>
	*
	* <p>Each capture produces one {@link ACameraMetadata} as a capture result and image buffers for
	* one or more target {@link ANativeWindow}s. The target ANativeWindows (set with
	* {@link ACaptureRequest_addTarget}) must be a subset of the ANativeWindow provided when
	* this capture session was created.</p>
	*
	* @param session the capture session of interest
	* @param callbacks the {@link ACameraCaptureSession_captureCallbacks} to be associated this capture
	*        sequence. No capture callback will be fired if this is set to NULL.
	* @param numRequests number of requests in requests argument. Must be at least 1.
	* @param requests an array of {@link ACaptureRequest} to be captured. Length must be at least
	*        numRequests.
	* @param captureSequenceId the capture sequence ID associated with this capture method invocation
	*        will be stored here if this argument is not NULL and the method call succeeds.
	*        When this argument is set to NULL, the capture sequence ID will not be returned.
	*
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method succeeds. captureSequenceId will be filled
	*             if it is not NULL.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session or requests is NULL, or
	*             if numRequests < 1</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if the camera device is closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DEVICE} if the camera device encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_SERVICE} if the camera service encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons</li></ul>
	*/
	ACameraCaptureSession_capture :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_captureCallbacks, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* Request endlessly repeating capture of a sequence of images by this capture session.
	*
	* <p>With this method, the camera device will continually capture images,
	* cycling through the settings in the provided list of
	* {@link ACaptureRequest}, at the maximum rate possible.</p>
	*
	* <p>If a request is submitted through {@link ACameraCaptureSession_capture},
	* the current repetition of the request list will be
	* completed before the higher-priority request is handled. This guarantees
	* that the application always receives a complete repeat burst captured in
	* minimal time, instead of bursts interleaved with higher-priority
	* captures, or incomplete captures.</p>
	*
	* <p>Repeating burst requests are a simple way for an application to
	* maintain a preview or other continuous stream of frames where each
	* request is different in a predicatable way, without having to continually
	* submit requests through {@link ACameraCaptureSession_capture}.</p>
	*
	* <p>To stop the repeating capture, call {@link ACameraCaptureSession_stopRepeating}. Any
	* ongoing burst will still be completed, however. Calling
	* {@link ACameraCaptureSession_abortCaptures} will also clear the request.</p>
	*
	* <p>Calling this method will replace a previously-set repeating requests
	* set up by this method, although any in-progress burst will be completed before the new repeat
	* burst will be used.</p>
	*
	* @param session the capture session of interest
	* @param callbacks the {@link ACameraCaptureSession_captureCallbacks} to be associated with this
	*        capture sequence. No capture callback will be fired if callbacks is set to NULL.
	* @param numRequests number of requests in requests array. Must be at least 1.
	* @param requests an array of {@link ACaptureRequest} to be captured. Length must be at least
	*        numRequests.
	* @param captureSequenceId the capture sequence ID associated with this capture method invocation
	*        will be stored here if this argument is not NULL and the method call succeeds.
	*        When this argument is set to NULL, the capture sequence ID will not be returned.
	*
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method succeeds. captureSequenceId will be filled
	*             if it is not NULL.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session or requests is NULL, or
	*             if numRequests < 1</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if the camera device is closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DEVICE} if the camera device encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_SERVICE} if the camera service encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for  some other reasons</li></ul>
	*/
	ACameraCaptureSession_setRepeatingRequest :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_captureCallbacks, numRequests: i32, requests: [^]^ACaptureRequest,  captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* Cancel any ongoing repeating capture set by {@link ACameraCaptureSession_setRepeatingRequest}.
	* Has no effect on requests submitted through {@link ACameraCaptureSession_capture}.
	*
	* <p>Any currently in-flight captures will still complete, as will any burst that is
	* mid-capture. To ensure that the device has finished processing all of its capture requests
	* and is in ready state, wait for the {@link ACameraCaptureSession_stateCallbacks#onReady} callback
	* after calling this method.</p>
	*
	* @param session the capture session of interest
	*
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method succeeds. captureSequenceId will be filled
	*             if it is not NULL.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if the camera device is closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DEVICE} if the camera device encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_SERVICE} if the camera service encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons</li></ul>
	*/
	ACameraCaptureSession_stopRepeating :: proc(session: ^ACameraCaptureSession) -> CameraStatus ---

	/**
	* Discard all captures currently pending and in-progress as fast as possible.
	*
	* <p>The camera device will discard all of its current work as fast as possible. Some in-flight
	* captures may complete successfully and call
	* {@link ACameraCaptureSession_captureCallbacks#onCaptureCompleted},
	* while others will trigger their {@link ACameraCaptureSession_captureCallbacks#onCaptureFailed}
	* callbacks. If a repeating request list is set, it will be cleared.</p>
	*
	* <p>This method is the fastest way to switch the camera device to a new session with
	* {@link ACameraDevice_createCaptureSession}, at the cost of discarding in-progress
	* work. It must be called before the new session is created. Once all pending requests are
	* either completed or thrown away, the {@link ACameraCaptureSession_stateCallbacks#onReady}
	* callback will be called, if the session has not been closed. Otherwise, the
	* {@link ACameraCaptureSession_stateCallbacks#onClosed}
	* callback will be fired when a new session is created by the camera device and the previous
	* session is being removed from memory.</p>
	*
	* <p>Cancelling will introduce at least a brief pause in the stream of data from the camera
	* device, since once the camera device is emptied, the first new request has to make it through
	* the entire camera pipeline before new output buffers are produced.</p>
	*
	* <p>This means that using ACameraCaptureSession_abortCaptures to simply remove pending requests is
	* not recommended it's best used for quickly switching output configurations, or for cancelling
	* long in-progress requests (such as a multi-second capture).</p>
	*
	* @param session the capture session of interest
	*
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method succeeds. captureSequenceId will be filled
	*             if it is not NULL.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if the camera device is closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DEVICE} if the camera device encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_SERVICE} if the camera service encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons</li></ul>
	*/
	ACameraCaptureSession_abortCaptures :: proc(session: ^ACameraCaptureSession) -> CameraStatus ---

	/**
	* Update shared ACaptureSessionOutput.
	*
	* <p>A shared ACaptureSessionOutput (see {@link ACaptureSessionSharedOutput_create}) that
	* was modified via calls to {@link ACaptureSessionSharedOutput_add} or
	* {@link ACaptureSessionSharedOutput_remove} must be updated by calling this method before its
	* changes take effect. After the update call returns  with {@link ACAMERA_OK}, any newly added
	* native windows can be used as a target in subsequent capture requests.</p>
	*
	* <p>Native windows that get removed must not be part of any active repeating or single/burst
	* request or have any pending results. Consider updating repeating requests via
	* {@link ACameraCaptureSession_setRepeatingRequest} and then wait for the last frame number
	* when the sequence completes
	* {@link ACameraCaptureSession_captureCallbacks#onCaptureSequenceCompleted}.</p>
	*
	* <p>Native windows that get added must not be part of any other registered ACaptureSessionOutput
	* and must be compatible. Compatible windows must have matching format, rotation and
	* consumer usage.</p>
	*
	* <p>A shared ACameraCaptureSession can support up to 4 additional native windows.</p>
	*
	* @param session the capture session of interest
	* @param output the modified output configuration
	*
	* @return <ul><li>
	*             {@link ACAMERA_OK} if the method succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if session or output is NULL or output
	*             contains invalid native windows or if an attempt was made to add
	*             a native window to a different output configuration or new native window is not
	*             compatible or any removed native window still has pending requests</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_OPERATION} if output configuration is not shared (see
	*             {@link ACaptureSessionSharedOutput_create}  or the number of additional
	*             native windows goes beyond the supported limit.</li>
	*         <li>{@link ACAMERA_ERROR_SESSION_CLOSED} if the capture session has been closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DISCONNECTED} if the camera device is closed</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_DEVICE} if the camera device encounters fatal error</li>
	*         <li>{@link ACAMERA_ERROR_CAMERA_SERVICE} if the camera service encounters fatal
	*             error</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons</li></ul>
	*/
	ACameraCaptureSession_updateSharedOutput :: proc(session: ^ACameraCaptureSession, output: ^ACaptureSessionOutput) -> CameraStatus ---


	/**
	* This has the same functionality as ACameraCaptureSession_capture, with added
	* support for logical multi-camera where the capture callbacks supports result metadata for
	* physical cameras.
	*/
	ACameraCaptureSession_logicalCamera_capture :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_logicalCamera_captureCallbacks, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* This has the same functionality as ACameraCaptureSession_setRepeatingRequest, with added
	* support for logical multi-camera where the capture callbacks supports result metadata for
	* physical cameras.
	*/
	ACameraCaptureSession_logicalCamera_setRepeatingRequest :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_logicalCamera_captureCallbacks, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* This has the same functionality as ACameraCaptureSession_capture, with added
	* support for v2 of camera callbacks, where the onCaptureStarted callback
	* adds frame number in its parameter list.
	*/
	ACameraCaptureSession_captureV2 :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_captureCallbacksV2, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* This has the same functionality as ACameraCaptureSession_logical_setRepeatingRequest, with added
	* support for v2 of logical multi-camera callbacks where the onCaptureStarted
	* callback adds frame number in its parameter list.
	*/
	ACameraCaptureSession_setRepeatingRequestV2 :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_captureCallbacksV2, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* This has the same functionality as ACameraCaptureSession_logical_capture, with added
	* support for v2 of logical multi-camera  callbacks where the onCaptureStarted callback
	* adds frame number in its parameter list.
	*/
	ACameraCaptureSession_logicalCamera_captureV2 :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_logicalCamera_captureCallbacksV2, numRequests: i32, requests: [^]^i32, captureSequenceId: ^i32) -> CameraStatus ---

	/**
	* This has the same functionality as ACameraCaptureSession_logical_setRepeatingRequest, with added
	* support for v2 of logical multi-camera callbacks where the onCaptureStarted
	* callback adds frame number in its parameter list.
	*/
	ACameraCaptureSession_logicalCamera_setRepeatingRequestV2 :: proc(session: ^ACameraCaptureSession, callbacks: [^]ACameraCaptureSession_logicalCamera_captureCallbacksV2, numRequests: i32, requests: [^]^ACaptureRequest, captureSequenceId: ^i32) -> CameraStatus ---
}
