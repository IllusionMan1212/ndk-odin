//+build android
package camerandk

import "../"

foreign import camerandk "system:camera2ndk"

/**
 * Possible data types of a metadata entry.
 *
 * Keep in sync with system/media/include/system/camera_metadata.h
 */
CameraDataType :: enum u8 {
    /// Unsigned 8-bit integer (uint8_t)
    BYTE = 0,
    /// Signed 32-bit integer (int32_t)
    INT32 = 1,
    /// 32-bit float (float)
    FLOAT = 2,
    /// Signed 64-bit integer (int64_t)
    INT64 = 3,
    /// 64-bit float (double)
    DOUBLE = 4,
    /// A 64-bit fraction (ACameraMetadata_rational)
    RATIONAL = 5,
    /// Number of type fields
    TYPES
}


/**
 * ACameraMetadata is opaque type that provides access to read-only camera metadata like camera
 * characteristics (via {@link ACameraManager_getCameraCharacteristics}) or capture results (via
 * {@link ACameraCaptureSession_captureCallback_result}).
 */
ACameraMetadata :: struct{}

/**
 * Definition of rational data type in {@link ACameraMetadata}.
 */
ACameraMetadata_rational :: struct {
	numerator: i32,
    denominator: i32,
}

/**
 * A single camera metadata entry.
 *
 * <p>Each entry is an array of values, though many metadata fields may only have 1 entry in the
 * array.</p>
 */
ACameraMetadata_entry :: struct {
    /**
     * The tag identifying the entry.
     *
     * <p> It is one of the values defined in {@link NdkCameraMetadataTags.h}, and defines how the
     * entry should be interpreted and which parts of the API provide it.
     * See {@link NdkCameraMetadataTags.h} for more details. </p>
     */
	tag: acamera_metadata_tag_t,

    /**
     * The data type of this metadata entry.
     *
     * <p>Must be one of ACAMERA_TYPE_* enum values defined above. A particular tag always has the
     * same type.</p>
     */
    type: CameraDataType,

    /**
     * Count of elements (NOT count of bytes) in this metadata entry.
     */
    count: u32,

    /**
     * Pointer to the data held in this metadata entry.
     *
     * <p>The type field above defines which union member pointer is valid. The count field above
     * defines the length of the data in number of elements.</p>
     */
    data: struct #raw_union {
        u8: ^u8,
        i32: ^i32,
        f: ^f32,
        i64: ^i64,
        d: ^f64,
        r: ^ACameraMetadata_rational,
    },
}

/**
 * A single read-only camera metadata entry.
 *
 * <p>Each entry is an array of values, though many metadata fields may only have 1 entry in the
 * array.</p>
 */
ACameraMetadata_const_entry :: struct {
    /**
     * The tag identifying the entry.
     *
     * <p> It is one of the values defined in {@link NdkCameraMetadataTags.h}, and defines how the
     * entry should be interpreted and which parts of the API provide it.
     * See {@link NdkCameraMetadataTags.h} for more details. </p>
     */
	tag: acamera_metadata_tag_t,

    /**
     * The data type of this metadata entry.
     *
     * <p>Must be one of ACAMERA_TYPE_* enum values defined above. A particular tag always has the
     * same type.</p>
     */
    type: CameraDataType,

    /**
     * Count of elements (NOT count of bytes) in this metadata entry.
     */
    count: u32,

    /**
     * Pointer to the data held in this metadata entry.
     *
     * <p>The type field above defines which union member pointer is valid. The count field above
     * defines the length of the data in number of elements.</p>
     */
    data: struct #raw_union {
        u8: ^u8,
        i32: ^i32,
        f: ^f32,
        i64: ^i64,
        d: ^f64,
        r: ^ACameraMetadata_rational,
    },
}



foreign camerandk {
	/**
	 * Get a metadata entry from an input {@link ACameraMetadata}.
	 *
	 * <p>The memory of the data field in the returned entry is managed by camera framework. Do not
	 * attempt to free it.</p>
	 *
	 * @param metadata the {@link ACameraMetadata} of interest.
	 * @param tag the tag value of the camera metadata entry to be get.
	 * @param entry the output {@link ACameraMetadata_const_entry} will be filled here if the method
	 *        call succeeeds.
	 *
	 * @return <ul>
	 *         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	 *         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if metadata or entry is NULL.</li>
	 *         <li>{@link ACAMERA_ERROR_METADATA_NOT_FOUND} if input metadata does not contain an entry
	 *             of input tag value.</li></ul>
	 *
	 * Available since API level 24.
	 */
	ACameraMetadata_getConstEntry :: proc(metadata: ^ACameraMetadata, tag: acamera_metadata_tag_t, entry: ^ACameraMetadata_const_entry) -> CameraStatus ---

	/**
	* List all the entry tags in input {@link ACameraMetadata}.
	*
	* @param metadata the {@link ACameraMetadata} of interest.
	* @param numEntries number of metadata entries in input {@link ACameraMetadata}
	* @param tags the tag values of the metadata entries. Length of tags is returned in numEntries
	*             argument. The memory is managed by ACameraMetadata itself and must NOT be free/delete
	*             by application. Do NOT access tags after calling ACameraMetadata_free.
	*
	* @return <ul>
	*         <li>{@link ACAMERA_OK} if the method call succeeds.</li>
	*         <li>{@link ACAMERA_ERROR_INVALID_PARAMETER} if metadata, numEntries or tags is NULL.</li>
	*         <li>{@link ACAMERA_ERROR_UNKNOWN} if the method fails for some other reasons.</li></ul>
	*
	* Available since API level 24.
	*/
	ACameraMetadata_getAllTags :: proc(metadata: ^ACameraMetadata, numEntries: ^i32, tags: ^[^]acamera_metadata_tag_t) -> CameraStatus ---

	/**
	* Create a copy of input {@link ACameraMetadata}.
	*
	* <p>The returned ACameraMetadata must be freed by the application by {@link ACameraMetadata_free}
	* after application is done using it.</p>
	*
	* @param src the input {@link ACameraMetadata} to be copied.
	*
	* @return a valid ACameraMetadata pointer or NULL if the input metadata cannot be copied.
	*
	* Available since API level 24.
	*/
	ACameraMetadata_copy :: proc(src: ^ACameraMetadata) -> ^ACameraMetadata ---

	/**
	* Free a {@link ACameraMetadata} structure.
	*
	* @param metadata the {@link ACameraMetadata} to be freed.
	*
	* Available since API level 24.
	*/
	ACameraMetadata_free :: proc(metadata: ^ACameraMetadata) ---

	/**
	* Helper function to check if a camera is logical multi-camera.
	*
	* <p> Check whether a camera device is a logical multi-camera based on its
	* static metadata. If it is, also returns its physical sub camera Ids.</p>
	*
	* @param staticMetadata the static metadata of the camera being checked.
	* @param numPhysicalCameras returns the number of physical cameras.
	* @param physicalCameraIds returns the array of physical camera Ids backing this logical
	*                          camera device. Note that this pointer is only valid
	*                          during the lifetime of the staticMetadata object.
	*
	* @return true if this is a logical multi-camera, false otherwise.
	*
	* Available since API level 29.
	*/
	ACameraMetadata_isLogicalMultiCamera :: proc(staticMetadata: ^ACameraMetadata, numPhysicalCameras: ^uint, physicalCameraIds: ^[^]cstring) -> bool ---

	/**
	* Return a {@link ACameraMetadata} that references the same data as
	* <a href="/reference/android/hardware/camera2/CameraMetadata">
	*     android.hardware.camera2.CameraMetadata</a> from Java API. (e.g., a
	* <a href="/reference/android/hardware/camera2/CameraCharacteristics">
	*     android.hardware.camera2.CameraCharacteristics</a>
	* or <a href="/reference/android/hardware/camera2/CaptureResult">
	*     android.hardware.camera2.CaptureResult</a>).
	*
	* <p>The returned ACameraMetadata must be freed by the application by {@link ACameraMetadata_free}
	* after application is done using it.</p>
	*
	* <p>The ACameraMetadata maintains a reference count to the underlying data, so
	* it can be used independently of the Java object, and it remains valid even if
	* the Java metadata is garbage collected.
	*
	* @param env the JNI environment.
	* @param cameraMetadata the source <a href="/reference/android/hardware/camera2/CameraMetadata">
	android.hardware.camera2.CameraMetadata </a>from which the
	*                       returned {@link ACameraMetadata} is a view.
	*
	* @return a valid ACameraMetadata pointer or NULL if cameraMetadata is null or not a valid
	*         instance of <a href="android/hardware/camera2/CameraMetadata">
	*         android.hardware.camera2.CameraMetadata</a>.
	*
	* Available since API level 30.
	*/
	ACameraMetadata_fromCameraMetadata :: proc(env: ^android.JNIEnv, cameraMetadata: android.jobject) -> ^ACameraMetadata ---
}
