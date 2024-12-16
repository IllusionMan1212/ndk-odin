package android

foreign import android "system:android"

/**
 * @file hardware_buffer.h
 * @brief API for native hardware buffers.
 */
/**
 * @defgroup AHardwareBuffer Native Hardware Buffer
 *
 * AHardwareBuffer objects represent chunks of memory that can be
 * accessed by various hardware components in the system. It can be
 * easily converted to the Java counterpart
 * android.hardware.HardwareBuffer and passed between processes using
 * Binder. All operations involving AHardwareBuffer and HardwareBuffer
 * are zero-copy, i.e., passing AHardwareBuffer to another process
 * creates a shared view of the same region of memory.
 *
 * AHardwareBuffers can be bound to EGL/OpenGL and Vulkan primitives.
 * For EGL, use the extension function eglGetNativeClientBufferANDROID
 * to obtain an EGLClientBuffer and pass it directly to
 * eglCreateImageKHR. Refer to the EGL extensions
 * EGL_ANDROID_get_native_client_buffer and
 * EGL_ANDROID_image_native_buffer for more information. In Vulkan,
 * the contents of the AHardwareBuffer can be accessed as external
 * memory. See the VK_ANDROID_external_memory_android_hardware_buffer
 * extension for details.
 *
 * @{
 */

/**
 * Buffer pixel formats.
 */
AHardwareBuffer_Format :: enum u32 {
    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8A8_UNORM
     *   OpenGL ES: GL_RGBA8
     */
    R8G8B8A8_UNORM           = 1,

    /**
     * 32 bits per pixel, 8 bits per channel format where alpha values are
     * ignored (always opaque).
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8A8_UNORM
     *   OpenGL ES: GL_RGB8
     */
    R8G8B8X8_UNORM           = 2,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8G8B8_UNORM
     *   OpenGL ES: GL_RGB8
     */
    R8G8B8_UNORM             = 3,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R5G6B5_UNORM_PACK16
     *   OpenGL ES: GL_RGB565
     */
    R5G6B5_UNORM             = 4,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16G16B16A16_SFLOAT
     *   OpenGL ES: GL_RGBA16F
     */
    R16G16B16A16_FLOAT       = 0x16,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_A2B10G10R10_UNORM_PACK32
     *   OpenGL ES: GL_RGB10_A2
     */
    R10G10B10A2_UNORM        = 0x2b,

    /**
     * Opaque binary blob format.
     * Must have height 1 and one layer, with width equal to the buffer
     * size in bytes. Corresponds to Vulkan buffers and OpenGL buffer
     * objects. Can be bound to the latter using GL_EXT_external_buffer.
     */
    BLOB                     = 0x21,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D16_UNORM
     *   OpenGL ES: GL_DEPTH_COMPONENT16
     */
    D16_UNORM                = 0x30,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_X8_D24_UNORM_PACK32
     *   OpenGL ES: GL_DEPTH_COMPONENT24
     */
    D24_UNORM                = 0x31,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D24_UNORM_S8_UINT
     *   OpenGL ES: GL_DEPTH24_STENCIL8
     */
    D24_UNORM_S8_UINT        = 0x32,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D32_SFLOAT
     *   OpenGL ES: GL_DEPTH_COMPONENT32F
     */
    D32_FLOAT                = 0x33,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_D32_SFLOAT_S8_UINT
     *   OpenGL ES: GL_DEPTH32F_STENCIL8
     */
    D32_FLOAT_S8_UINT        = 0x34,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_S8_UINT
     *   OpenGL ES: GL_STENCIL_INDEX8
     */
    S8_UINT                  = 0x35,

    /**
     * YUV 420 888 format.
     * Must have an even width and height. Can be accessed in OpenGL
     * shaders through an external sampler. Does not support mip-maps
     * cube-maps or multi-layered textures.
     */
    Y8Cb8Cr8_420             = 0x23,

    /**
     * YUV P010 format.
     * Must have an even width and height. Can be accessed in OpenGL
     * shaders through an external sampler. Does not support mip-maps
     * cube-maps or multi-layered textures.
     */
    YCbCr_P010               = 0x36,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R8_UNORM
     *   OpenGL ES: GR_GL_R8
     */
    R8_UNORM                 = 0x38,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16_UINT
     *   OpenGL ES: GL_R16UI
     */
    R16_UINT                 = 0x39,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R16G16_UINT
     *   OpenGL ES: GL_RG16UI
     */
    R16G16_UINT              = 0x3a,

    /**
     * Corresponding formats:
     *   Vulkan: VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16
     *   OpenGL ES: N/A
     */
    R10G10B10A10_UNORM       = 0x3b,
}

/**
 * Buffer usage flags, specifying how the buffer will be accessed.
 */
AHardwareBuffer_UsageFlags :: enum u64 {
    /**
     * The buffer will never be locked for direct CPU reads using the
     * AHardwareBuffer_lock() function. Note that reading the buffer
     * using OpenGL or Vulkan functions or memory mappings is still
     * allowed.
     */
    CPU_READ_NEVER        = 0,
    /**
     * The buffer will sometimes be locked for direct CPU reads using
     * the AHardwareBuffer_lock() function. Note that reading the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    CPU_READ_RARELY       = 2,
    /**
     * The buffer will often be locked for direct CPU reads using
     * the AHardwareBuffer_lock() function. Note that reading the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    CPU_READ_OFTEN        = 3,

    /** CPU read value mask. */
    CPU_READ_MASK         = 0xF,
    /**
     * The buffer will never be locked for direct CPU writes using the
     * AHardwareBuffer_lock() function. Note that writing the buffer
     * using OpenGL or Vulkan functions or memory mappings is still
     * allowed.
     */
    CPU_WRITE_NEVER       = 0 << 4,
    /**
     * The buffer will sometimes be locked for direct CPU writes using
     * the AHardwareBuffer_lock() function. Note that writing the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    CPU_WRITE_RARELY      = 2 << 4,
    /**
     * The buffer will often be locked for direct CPU writes using
     * the AHardwareBuffer_lock() function. Note that writing the
     * buffer using OpenGL or Vulkan functions or memory mappings
     * does not require the presence of this flag.
     */
    CPU_WRITE_OFTEN       = 3 << 4,
    /** CPU write value mask. */
    CPU_WRITE_MASK        = 0xF << 4,
    /** The buffer will be read from by the GPU as a texture. */
    GPU_SAMPLED_IMAGE     = 1 << 8,
    /** The buffer will be written to by the GPU as a framebuffer attachment.*/
    GPU_FRAMEBUFFER       = 1 << 9,
    /**
     * The buffer will be written to by the GPU as a framebuffer
     * attachment.
     *
     * Note that the name of this flag is somewhat misleading: it does
     * not imply that the buffer contains a color format. A buffer with
     * depth or stencil format that will be used as a framebuffer
     * attachment should also have this flag. Use the equivalent flag
     * AHARDWAREBUFFER_USAGE_GPU_FRAMEBUFFER to avoid this confusion.
     */
    GPU_COLOR_OUTPUT      = GPU_FRAMEBUFFER,
    /**
     * The buffer will be used as a composer HAL overlay layer.
     *
     * This flag is currently only needed when using ASurfaceTransaction_setBuffer
     * to set a buffer. In all other cases, the framework adds this flag
     * internally to buffers that could be presented in a composer overlay.
     * ASurfaceTransaction_setBuffer is special because it uses buffers allocated
     * directly through AHardwareBuffer_allocate instead of buffers allocated
     * by the framework.
     */
    COMPOSER_OVERLAY      = 1 << 11,
    /**
     * The buffer is protected from direct CPU access or being read by
     * non-secure hardware, such as video encoders.
     *
     * This flag is incompatible with CPU read and write flags. It is
     * mainly used when handling DRM video. Refer to the EGL extension
     * EGL_EXT_protected_content and GL extension
     * GL_EXT_protected_textures for more information on how these
     * buffers are expected to behave.
     */
    PROTECTED_CONTENT     = 1 << 14,
    /** The buffer will be read by a hardware video encoder. */
    VIDEO_ENCODE          = 1 << 16,
    /**
     * The buffer will be used for direct writes from sensors.
     * When this flag is present, the format must be AHARDWAREBUFFER_FORMAT_BLOB.
     */
    SENSOR_DIRECT_DATA    = 1 << 23,
    /**
     * The buffer will be used as a shader storage or uniform buffer object.
     * When this flag is present, the format must be AHARDWAREBUFFER_FORMAT_BLOB.
     */
    GPU_DATA_BUFFER       = 1 << 24,
    /**
     * The buffer will be used as a cube map texture.
     * When this flag is present, the buffer must have a layer count
     * that is a multiple of 6. Note that buffers with this flag must be
     * bound to OpenGL textures using the extension
     * GL_EXT_EGL_image_storage instead of GL_KHR_EGL_image.
     */
    GPU_CUBE_MAP          = 1 << 25,
    /**
     * The buffer contains a complete mipmap hierarchy.
     * Note that buffers with this flag must be bound to OpenGL textures using
     * the extension GL_EXT_EGL_image_storage instead of GL_KHR_EGL_image.
     */
    GPU_MIPMAP_COMPLETE   = 1 << 26,

    /**
     * Usage: The buffer is used for front-buffer rendering. When
     * front-buffering rendering is specified, different usages may adjust their
     * behavior as a result. For example, when used as GPU_COLOR_OUTPUT the buffer
     * will behave similar to a single-buffered window. When used with
     * COMPOSER_OVERLAY, the system will try to prioritize the buffer receiving
     * an overlay plane & avoid caching it in intermediate composition buffers.
     */
    FRONT_BUFFER = 1 << 32,

    VENDOR_0  = 1 << 28,
    VENDOR_1  = 1 << 29,
    VENDOR_2  = 1 << 30,
    VENDOR_3  = 1 << 31,
    VENDOR_4  = 1 << 48,
    VENDOR_5  = 1 << 49,
    VENDOR_6  = 1 << 50,
    VENDOR_7  = 1 << 51,
    VENDOR_8  = 1 << 52,
    VENDOR_9  = 1 << 53,
    VENDOR_10 = 1 << 54,
    VENDOR_11 = 1 << 55,
    VENDOR_12 = 1 << 56,
    VENDOR_13 = 1 << 57,
    VENDOR_14 = 1 << 58,
    VENDOR_15 = 1 << 59,
    VENDOR_16 = 1 << 60,
    VENDOR_17 = 1 << 61,
    VENDOR_18 = 1 << 62,
    VENDOR_19 = 1 << 63,
}

/**
 * Buffer description. Used for allocating new buffers and querying
 * parameters of existing ones.
 */
AHardwareBuffer_Desc :: struct {
	width: u32,  ///< Width in pixels.
    height: u32, ///< Height in pixels.
    /**
     * Number of images in an image array. AHardwareBuffers with one
     * layer correspond to regular 2D textures. AHardwareBuffers with
     * more than layer correspond to texture arrays. If the layer count
     * is a multiple of 6 and the usage flag
     * AHARDWAREBUFFER_USAGE_GPU_CUBE_MAP is present, the buffer is
     * a cube map or a cube map array.
     */
    layers: u32,
    format: AHardwareBuffer_Format, ///< One of AHardwareBuffer_Format.
    usage: AHardwareBuffer_UsageFlags,  ///< Combination of AHardwareBuffer_UsageFlags.
    stride: u32, ///< Row stride in pixels, ignored for AHardwareBuffer_allocate()
    rfu0: u32,   ///< Initialize to zero, reserved for future use.
    rfu1: u64,   ///< Initialize to zero, reserved for future use.
}

/**
 * Holds data for a single image plane.
 */
AHardwareBuffer_Plane :: struct {
	data: rawptr,     ///< Points to first byte in plane
    pixelStride: u32, ///< Distance in bytes from the color channel of one pixel to the next
    rowStride: u32,   ///< Distance in bytes from the first value of one row of the image to
                      ///  the first value of the next row.
}

/**
 * Holds all image planes that contain the pixel data.
 */
AHardwareBuffer_Planes :: struct {
	planeCount: u32, ///< Number of distinct planes
    planes: [4]AHardwareBuffer_Plane,  ///< Array of image planes
}

/**
 * Opaque handle for a native hardware buffer.
 */
AHardwareBuffer :: struct{}

foreign android {
	/**
	 * Allocates a buffer that matches the passed AHardwareBuffer_Desc.
	 *
	 * If allocation succeeds, the buffer can be used according to the
	 * usage flags specified in its description. If a buffer is used in ways
	 * not compatible with its usage flags, the results are undefined and
	 * may include program termination.
	 *
	 * Available since API level 26.
	 *
	 * \return 0 on success, or an error number of the allocation fails for
	 * any reason. The returned buffer has a reference count of 1.
	 */
	AHardwareBuffer_allocate :: proc(desc: ^AHardwareBuffer_Desc, outBuffer: ^^AHardwareBuffer) -> i32 ---
	/**
	* Acquire a reference on the given AHardwareBuffer object.
	*
	* This prevents the object from being deleted until the last reference
	* is removed.
	*
	* Available since API level 26.
	*/
	AHardwareBuffer_acquire :: proc(buffer: ^AHardwareBuffer) ---

	/**
	* Remove a reference that was previously acquired with
	* AHardwareBuffer_acquire() or AHardwareBuffer_allocate().
	*
	* Available since API level 26.
	*/
	AHardwareBuffer_release :: proc(buffer: ^AHardwareBuffer) ---

	/**
	* Return a description of the AHardwareBuffer in the passed
	* AHardwareBuffer_Desc struct.
	*
	* Available since API level 26.
	*/
	AHardwareBuffer_describe :: proc(buffer: ^AHardwareBuffer, outDesc: ^AHardwareBuffer_Desc) ---

	/**
	* Lock the AHardwareBuffer for direct CPU access.
	*
	* This function can lock the buffer for either reading or writing.
	* It may block if the hardware needs to finish rendering, if CPU caches
	* need to be synchronized, or possibly for other implementation-
	* specific reasons.
	*
	* The passed AHardwareBuffer must have one layer, otherwise the call
	* will fail.
	*
	* If \a fence is not negative, it specifies a fence file descriptor on
	* which to wait before locking the buffer. If it's negative, the caller
	* is responsible for ensuring that writes to the buffer have completed
	* before calling this function.  Using this parameter is more efficient
	* than waiting on the fence and then calling this function.
	*
	* The \a usage parameter may only specify AHARDWAREBUFFER_USAGE_CPU_*.
	* If set, then outVirtualAddress is filled with the address of the
	* buffer in virtual memory. The flags must also be compatible with
	* usage flags specified at buffer creation: if a read flag is passed,
	* the buffer must have been created with
	* AHARDWAREBUFFER_USAGE_CPU_READ_RARELY or
	* AHARDWAREBUFFER_USAGE_CPU_READ_OFTEN. If a write flag is passed, it
	* must have been created with AHARDWAREBUFFER_USAGE_CPU_WRITE_RARELY or
	* AHARDWAREBUFFER_USAGE_CPU_WRITE_OFTEN.
	*
	* If \a rect is not NULL, the caller promises to modify only data in
	* the area specified by rect. If rect is NULL, the caller may modify
	* the contents of the entire buffer. The content of the buffer outside
	* of the specified rect is NOT modified by this call.
	*
	* It is legal for several different threads to lock a buffer for read
	* access none of the threads are blocked.
	*
	* Locking a buffer simultaneously for write or read/write is undefined,
	* but will neither terminate the process nor block the caller.
	* AHardwareBuffer_lock may return an error or leave the buffer's
	* content in an indeterminate state.
	*
	* If the buffer has AHARDWAREBUFFER_FORMAT_BLOB, it is legal lock it
	* for reading and writing in multiple threads and/or processes
	* simultaneously, and the contents of the buffer behave like shared
	* memory.
	*
	* Available since API level 26.
	*
	* \return 0 on success. -EINVAL if \a buffer is NULL, the usage flags
	* are not a combination of AHARDWAREBUFFER_USAGE_CPU_*, or the buffer
	* has more than one layer. Error number if the lock fails for any other
	* reason.
	*/
	AHardwareBuffer_lock :: proc(buffer: ^AHardwareBuffer, usage: AHardwareBuffer_UsageFlags, fence: i32, rect: ^ARect, outVirtualAddress: ^rawptr) -> i32 ---

	/**
	* Unlock the AHardwareBuffer from direct CPU access.
	*
	* Must be called after all changes to the buffer are completed by the
	* caller.  If \a fence is NULL, the function will block until all work
	* is completed.  Otherwise, \a fence will be set either to a valid file
	* descriptor or to -1.  The file descriptor will become signaled once
	* the unlocking is complete and buffer contents are updated.
	* The caller is responsible for closing the file descriptor once it's
	* no longer needed.  The value -1 indicates that unlocking has already
	* completed before the function returned and no further operations are
	* necessary.
	*
	* Available since API level 26.
	*
	* \return 0 on success. -EINVAL if \a buffer is NULL. Error number if
	* the unlock fails for any reason.
	*/
	AHardwareBuffer_unlock :: proc(buffer: ^AHardwareBuffer, fence: ^i32) -> i32 ---

	/**
	* Send the AHardwareBuffer to an AF_UNIX socket.
	*
	* Available since API level 26.
	*
	* \return 0 on success, -EINVAL if \a buffer is NULL, or an error
	* number if the operation fails for any reason.
	*/
	AHardwareBuffer_sendHandleToUnixSocket :: proc(buffer: ^AHardwareBuffer, socketFd: i32) -> i32 ---

	/**
	* Receive an AHardwareBuffer from an AF_UNIX socket.
	*
	* Available since API level 26.
	*
	* \return 0 on success, -EINVAL if \a outBuffer is NULL, or an error
	* number if the operation fails for any reason.
	*/
	AHardwareBuffer_recvHandleFromUnixSocket :: proc(socketFd: i32, outBuffer: ^^AHardwareBuffer) -> i32 ---

	/**
	* Lock a potentially multi-planar AHardwareBuffer for direct CPU access.
	*
	* This function is similar to AHardwareBuffer_lock, but can lock multi-planar
	* formats. The locked planes are returned in the \a outPlanes argument. Note,
	* that multi-planar should not be confused with multi-layer images, which this
	* locking function does not support.
	*
	* YUV formats are always represented by three separate planes of data, one for
	* each color plane. The order of planes in the array is guaranteed such that
	* plane #0 is always Y, plane #1 is always U (Cb), and plane #2 is always V
	* (Cr). All other formats are represented by a single plane.
	*
	* Additional information always accompanies the buffers, describing the row
	* stride and the pixel stride for each plane.
	*
	* In case the buffer cannot be locked, \a outPlanes will contain zero planes.
	*
	* See the AHardwareBuffer_lock documentation for all other locking semantics.
	*
	* Available since API level 29.
	*
	* \return 0 on success. -EINVAL if \a buffer is NULL, the usage flags
	* are not a combination of AHARDWAREBUFFER_USAGE_CPU_*, or the buffer
	* has more than one layer. Error number if the lock fails for any other
	* reason.
	*/
	AHardwareBuffer_lockPlanes :: proc(buffer: ^AHardwareBuffer, usage: AHardwareBuffer_UsageFlags, fence: i32, rect: ^ARect, outPlanes: ^AHardwareBuffer_Planes) -> i32 ---

	/**
	* Test whether the given format and usage flag combination is
	* allocatable.
	*
	* If this function returns true, it means that a buffer with the given
	* description can be allocated on this implementation, unless resource
	* exhaustion occurs. If this function returns false, it means that the
	* allocation of the given description will never succeed.
	*
	* The return value of this function may depend on all fields in the
	* description, except stride, which is always ignored. For example,
	* some implementations have implementation-defined limits on texture
	* size and layer count.
	*
	* Available since API level 29.
	*
	* \return 1 if the format and usage flag combination is allocatable,
	*     0 otherwise.
	*/
	AHardwareBuffer_isSupported :: proc(desc: ^AHardwareBuffer_Desc) -> i32 ---

	/**
	* Lock an AHardwareBuffer for direct CPU access.
	*
	* This function is the same as the above lock function, but passes back
	* additional information about the bytes per pixel and the bytes per stride
	* of the locked buffer.  If the bytes per pixel or bytes per stride are unknown
	* or variable, or if the underlying mapper implementation does not support returning
	* additional information, then this call will fail with INVALID_OPERATION
	*
	* Available since API level 29.
	*/
	AHardwareBuffer_lockAndGetInfo :: proc(buffer: ^AHardwareBuffer, usage: AHardwareBuffer_UsageFlags, fence: i32, rect: ^ARect, outVirtualAddress: ^rawptr, outBytesPerPixel: ^i32, outBytesPerStride: ^i32) -> i32 ---


	/**
	* Get the system wide unique id for an AHardwareBuffer.
	*
	* Available since API level 31.
	*
	* \return 0 on success, -EINVAL if \a buffer or \a outId is NULL, or an error number if the
	* operation fails for any reason.
	*/
	AHardwareBuffer_getId :: proc(buffer: ^AHardwareBuffer, outId: ^u64) -> i32 ---
}
