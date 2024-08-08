//+build android
package camerandk

foreign import camerandk "system:camera2ndk"

/** Container for output targets */
ACameraOutputTargets :: struct{}

/** Container for a single output target */
ACameraOutputTarget :: struct{}

/**
* ACaptureRequest is an opaque type that contains settings and output targets needed to capture
* a single image from camera device.
*
* <p>ACaptureRequest contains the configuration for the capture hardware (sensor, lens, flash),
* the processing pipeline, the control algorithms, and the output buffers. Also
* contains the list of target {@link ANativeWindow}s to send image data to for this
* capture.</p>
*
* <p>ACaptureRequest is created by {@link ACameraDevice_createCaptureRequest}.
*
* <p>ACaptureRequest is given to {@link ACameraCaptureSession_capture} or
* {@link ACameraCaptureSession_setRepeatingRequest} to capture images from a camera.</p>
*
* <p>Each request can specify a different subset of target {@link ANativeWindow}s for the
* camera to send the captured data to. All the {@link ANativeWindow}s used in a request must
* be part of the {@link ANativeWindow} list given to the last call to
* {@link ACameraDevice_createCaptureSession}, when the request is submitted to the
* session.</p>
*
* <p>For example, a request meant for repeating preview might only include the
* {@link ANativeWindow} for the preview SurfaceView or SurfaceTexture, while a
* high-resolution still capture would also include a {@link ANativeWindow} from a
* {@link AImageReader} configured for high-resolution JPEG images.</p>
*
* @see ACameraDevice_createCaptureRequest
* @see ACameraCaptureSession_capture
* @see ACameraCaptureSession_setRepeatingRequest
*/
ACaptureRequest :: struct{}

foreign camerandk {
	/**
	* Create a ACameraOutputTarget object.
	*
	* <p>The ACameraOutputTarget is used in {@link ACaptureRequest_addTarget} method to add an output
	* {@link ANativeWindow} to ACaptureRequest. Use {@link ACameraOutputTarget_free} to free the object
	* and its memory after application no longer needs the {@link ACameraOutputTarget}.</p>
	*
	* @param window the {@link ANativeWindow} to be associated with the {@link ACameraOutputTarget}
	* @param output the output {@link ACameraOutputTarget} will be stored here if the
	*                  method call succeeds.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds. The created ACameraOutputTarget will
	*                                be filled in the output argument.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if window or output is NULL.</li></ul>
	*
	* @see ACaptureRequest_addTarget
	*
	* Available since API level 24.
	*/
	ACameraOutputTarget_create :: proc(window: ^ACameraWindowType, output: ^^ACameraOutputTarget) -> CameraStatus ---

	/**
	* Free a ACameraOutputTarget object.
	*
	* @param output the {@link ACameraOutputTarget} to be freed.
	*
	* @see ACameraOutputTarget_create
	*
	* Available since API level 24.
	*/
	ACameraOutputTarget_free :: proc(output: ^ACameraOutputTarget) ---

	/**
	* Add an {@link ACameraOutputTarget} object to {@link ACaptureRequest}.
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param output the output {@link ACameraOutputTarget} to be added to capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or output is NULL.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_addTarget :: proc(request: ^ACaptureRequest, output: ^ACameraOutputTarget) -> CameraStatus ---

	/**
	* Remove an {@link ACameraOutputTarget} object from {@link ACaptureRequest}.
	*
	* <p>This method has no effect if the ACameraOutputTarget does not exist in ACaptureRequest.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param output the output {@link ACameraOutputTarget} to be removed from capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or output is NULL.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_removeTarget :: proc(request: ^ACaptureRequest, output: ^ACameraOutputTarget) -> CameraStatus ---

	/**
	* Get a metadata entry from input {@link ACaptureRequest}.
	*
	* <p>The memory of the data field in returned entry is managed by camera framework. Do not
	* attempt to free it.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be get.
	* @param entry the output {@link ACameraMetadata_const_entry} will be filled here if the method
	*        call succeeeds.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if metadata or entry is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_METADATA_NOT_FOUND} if the capture request does not contain an
	*             entry of input tag value.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_getConstEntry :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, entry: ^ACameraMetadata_const_entry) -> CameraStatus ---

	/*
	* List all the entry tags in input {@link ACaptureRequest}.
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param numEntries number of metadata entries in input {@link ACaptureRequest}
	* @param tags the tag values of the metadata entries. Length of tags is returned in numEntries
	*             argument. The memory is managed by ACaptureRequest itself and must NOT be free/delete
	*             by application. Calling ACaptureRequest_setEntry_* methods will invalidate previous
	*             output of ACaptureRequest_getAllTags. Do not access tags after calling
	*             ACaptureRequest_setEntry_*. To get new list of tags after updating capture request,
	*             application must call ACaptureRequest_getAllTags again. Do NOT access tags after
	*             calling ACaptureRequest_free.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request, numEntries or tags is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_getAllTags :: proc(request: ^ACaptureRequest, numTags: ^i32, tags: ^[^]acamera_metadata_tag_t) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with unsigned 8 bits data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not unsigned 8 bits, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_u8 :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]byte) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with signed 32 bits data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not signed 32 bits, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_i32 :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]i32) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with float data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not float, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_float :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]f32) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with signed 64 bits data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not signed 64 bits, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_i64 :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]i64) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with double data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not double, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_double :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]f64) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with rational data type.
	*
	* <p>Set count to 0 and data to NULL to remove a tag from the capture request.</p>
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param tag the tag value of the camera metadata entry to be set.
	* @param count number of elements to be set in data argument
	* @param data the entries to be set/change in the capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL, count is larger than
	*             zero while data is NULL, the data type of the tag is not rational, or
	*             the tag is not controllable by application.</li></ul>
	*
	* Available since API level 24.
	*/
	ACaptureRequest_setEntry_rational :: proc(request: ^ACaptureRequest, tag: acamera_metadata_tag_t, count: u32, data: [^]ACameraMetadata_rational) -> CameraStatus ---

	/**
	* Free a {@link ACaptureRequest} structure.
	*
	* @param request the {@link ACaptureRequest} to be freed.
	*
	* Available since API level 24.
	*/
	ACaptureRequest_free :: proc(request: ^ACaptureRequest) ---

	/**
	* Associate an arbitrary user context pointer to the {@link ACaptureRequest}
	*
	* This method is useful for user to identify the capture request in capture session callbacks.
	* The context is NULL for newly created request.
	* {@link ACameraOutputTarget_free} will not free the context. Also calling this method twice
	* will not cause the previous context be freed.
	* Also note that calling this method after the request has been sent to capture session will not
	* change the context pointer in the capture callbacks.
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param context the user context pointer to be associated with this capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL.</li></ul>
	*
	* Available since API level 28.
	*/
	ACaptureRequest_setUserContext :: proc(request: ^ACaptureRequest, _context: rawptr) -> CameraStatus ---

	/**
	* Get the user context pointer of the {@link ACaptureRequest}
	*
	* This method is useful for user to identify the capture request in capture session callbacks.
	* The context is NULL for newly created request.
	*
	* @param request the {@link ACaptureRequest} of interest.
	* @param context the user context pointer of this capture request.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request is NULL.</li></ul>
	*
	* Available since API level 28.
	*/
	ACaptureRequest_getUserContext :: proc(request: ^ACaptureRequest, _context: ^rawptr) -> CameraStatus ---

	/**
	* Create a copy of input {@link ACaptureRequest}.
	*
	* <p>The returned ACaptureRequest must be freed by the application by {@link ACaptureRequest_free}
	* after application is done using it.</p>
	*
	* @param src the input {@link ACaptureRequest} to be copied.
	*
	* @return a valid ACaptureRequest pointer or NULL if the input request cannot be copied.
	*
	* Available since API level 28.
	*/
	ACaptureRequest_copy :: proc(src: ^ACaptureRequest) -> ^ACaptureRequest ---

	/**
	* Get a metadata entry from input {@link ACaptureRequest} for
	* a physical camera backing a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_getConstEntry, except that if the key is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* returns the entry set by ACaptureRequest_setEntry_physicalCamera_* class of
	* functions on the particular physical camera.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag the capture request metadata tag in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}
	*            that is set by ACaptureRequest_setEntry_physicalCamera_* class of functions.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if metadata, physicalId, or entry is NULL,
	*         physicalId is not one of the Ids used in creating the request, or if the capture
	*         request is a regular request with no physical Ids at all.</li>
	*         <li>{@link ACAMERA_ERROR_METADATA_NOT_FOUND} if the capture request does not contain an
	*             entry of input tag value.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_getConstEntry_physicalCamera :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, entry: ^ACameraMetadata_const_entry) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with unsigned 8 bits data type for
	* a physical camera backing a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_u8, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not unsigned 8 bits,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_u8 :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]byte) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with signed 32 bits data type for
	* a physical camera of a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_i32, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not signed 32 bits,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_i32 :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]i32) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with float data type for
	* a physical camera of a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_float, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not float,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_float :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]f32) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with signed 64 bits data type for
	* a physical camera of a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_i64, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not signed 64 bits,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_i64 :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]i64) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with double data type for
	* a physical camera of a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_double, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not double,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_double :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]f64) -> CameraStatus ---

	/**
	* Set/change a camera capture control entry with rational data type for
	* a physical camera of a logical multi-camera device.
	*
	* <p>Same as ACaptureRequest_setEntry_rational, except that if tag is contained
	* in {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, this function
	* sets the entry for a particular physical sub-camera backing the logical multi-camera.
	* If tag is not contained in
	* {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}, the key will be ignored
	* by the camera device.</p>
	*
	* @param request the {@link ACaptureRequest} of interest created by
	*                {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param physicalId one of the physical Ids used when request is created with
	*                   {@link ACameraDevice_createCaptureRequest_withPhysicalIds}.
	* @param tag one of the capture request metadata tags in
	*            {@link ACAMERA_REQUEST_AVAILABLE_PHYSICAL_CAMERA_REQUEST_KEYS}.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if request or physicalId is NULL, count is
	*             larger than zero while data is NULL, the data type of the tag is not rational,
	*             the tag is not controllable by application, physicalId is not one of the Ids used
	*             in creating the request, or if the capture request is a regular request with no
	*             physical Ids at all.</li></ul>
	*
	* Available since API level 29.
	*/
	ACaptureRequest_setEntry_physicalCamera_rational :: proc(request: ^ACaptureRequest, physicalId: cstring, tag: acamera_metadata_tag_t, count: u32, data: [^]ACameraMetadata_rational) -> CameraStatus ---
}
