package camerandk

/**
 * Camera status enum types.
 */
CameraStatus :: enum {
    /**
     * Camera operation has succeeded.
     */
    OK = 0,

    ERROR_BASE                  = -10000,

    /**
     * Camera operation has failed due to an unspecified cause.
     */
    ERROR_UNKNOWN               = ERROR_BASE,

    /**
     * Camera operation has failed due to an invalid parameter being passed to the method.
     */
    ERROR_INVALID_PARAMETER     = ERROR_BASE - 1,

    /**
     * Camera operation has failed because the camera device has been closed, possibly because a
     * higher-priority client has taken ownership of the camera device.
     */
    ERROR_CAMERA_DISCONNECTED   = ERROR_BASE - 2,

    /**
     * Camera operation has failed due to insufficient memory.
     */
    ERROR_NOT_ENOUGH_MEMORY     = ERROR_BASE - 3,

    /**
     * Camera operation has failed due to the requested metadata tag cannot be found in input
     * {@link ACameraMetadata} or {@link ACaptureRequest}.
     */
    ERROR_METADATA_NOT_FOUND    = ERROR_BASE - 4,

    /**
     * Camera operation has failed and the camera device has encountered a fatal error and needs to
     * be re-opened before it can be used again.
     */
    ERROR_CAMERA_DEVICE         = ERROR_BASE - 5,

    /**
     * Camera operation has failed and the camera service has encountered a fatal error.
     *
     * <p>The Android device may need to be shut down and restarted to restore
     * camera function, or there may be a persistent hardware problem.</p>
     *
     * <p>An attempt at recovery may be possible by closing the
     * ACameraDevice and the ACameraManager, and trying to acquire all resources
     * again from scratch.</p>
     */
    ERROR_CAMERA_SERVICE        = ERROR_BASE - 6,

    /**
     * The {@link ACameraCaptureSession} has been closed and cannnot perform any operation other
     * than {@link ACameraCaptureSession_close}.
     */
    ERROR_SESSION_CLOSED        = ERROR_BASE - 7,

    /**
     * Camera operation has failed due to an invalid internal operation. Usually this is due to a
     * low-level problem that may resolve itself on retry
     */
    ERROR_INVALID_OPERATION     = ERROR_BASE - 8,

    /**
     * Camera device does not support the stream configuration provided by application in
     * {@link ACameraDevice_createCaptureSession} or {@link
     * ACameraDevice_isSessionConfigurationSupported}.
     */
    ERROR_STREAM_CONFIGURE_FAIL = ERROR_BASE - 9,

    /**
     * Camera device is being used by another higher priority camera API client.
     */
    ERROR_CAMERA_IN_USE         = ERROR_BASE - 10,

    /**
     * The system-wide limit for number of open cameras or camera resources has been reached, and
     * more camera devices cannot be opened until previous instances are closed.
     */
    ERROR_MAX_CAMERA_IN_USE     = ERROR_BASE - 11,

    /**
     * The camera is disabled due to a device policy, and cannot be opened.
     */
    ERROR_CAMERA_DISABLED       = ERROR_BASE - 12,

    /**
     * The application does not have permission to open camera.
     */
    ERROR_PERMISSION_DENIED     = ERROR_BASE - 13,

    /**
     * The operation is not supported by the camera device.
     */
    ERROR_UNSUPPORTED_OPERATION = ERROR_BASE - 14,
}

