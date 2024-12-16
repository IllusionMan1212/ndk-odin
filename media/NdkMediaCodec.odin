package mediandk

import android "../"

foreign import mediandk "system:android"

AMEDIACODEC_KEY_HDR10_PLUS_INFO: cstring     //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_LOW_LATENCY: cstring         //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_OFFSET_TIME: cstring         //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_REQUEST_SYNC_FRAME: cstring  //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_SUSPEND: cstring             //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_SUSPEND_TIME: cstring        //   __INTRODUCED_IN(31);
AMEDIACODEC_KEY_VIDEO_BITRATE: cstring       //   __INTRODUCED_IN(31);


AMEDIACODEC_BUFFER_FLAG_CODEC_CONFIG :: 2
AMEDIACODEC_BUFFER_FLAG_END_OF_STREAM :: 4
AMEDIACODEC_BUFFER_FLAG_PARTIAL_FRAME :: 8

AMEDIACODEC_CONFIGURE_FLAG_ENCODE :: 1
AMEDIACODEC_INFO_OUTPUT_BUFFERS_CHANGED :: -3
AMEDIACODEC_INFO_OUTPUT_FORMAT_CHANGED :: -2
AMEDIACODEC_INFO_TRY_AGAIN_LATER :: -1

_off_t_compat :: i64

cryptoinfo_mode_t :: enum {
    CLEAR = 0,
    AES_CTR = 1,
    AES_WV = 2,
    AES_CBC = 3
}

AMediaCodec :: struct{}

AMediaCodecBufferInfo :: struct {
	offset: i32,
    size: i32,
    presentationTimeUs: i64,
    flags: u32,
}

AMediaCodecCryptoInfo :: struct{}

AMediaCodecOnAsyncNotifyCallback :: struct {
	onAsyncInputAvailable: AMediaCodecOnAsyncInputAvailable,
	onAsyncOutputAvailable: AMediaCodecOnAsyncOutputAvailable,
	onAsyncFormatChanged: AMediaCodecOnAsyncFormatChanged,
	onAsyncError: AMediaCodecOnAsyncError,
}

cryptoinfo_pattern_t :: struct {
	encryptBlocks: i32,
    skipBlocks: i32,
}

/**
 * Called when an input buffer becomes available.
 * The specified index is the index of the available input buffer.
 */
AMediaCodecOnAsyncInputAvailable :: #type proc "c" (codec: ^AMediaCodec, userdata: rawptr, index: i32)
/**
 * Called when an output buffer becomes available.
 * The specified index is the index of the available output buffer.
 * The specified bufferInfo contains information regarding the available output buffer.
 */
AMediaCodecOnAsyncOutputAvailable :: #type proc "c" (codec: ^AMediaCodec, userdata: rawptr, index: i32, bufferInfo: ^AMediaCodecBufferInfo)
/**
 * Called when the output format has changed.
 * The specified format contains the new output format.
 */
AMediaCodecOnAsyncFormatChanged :: #type proc "c" (codec: ^AMediaCodec, userdata: rawptr, format: ^AMediaFormat)
/**
 * Called when the MediaCodec encountered an error.
 * The specified actionCode indicates the possible actions that client can take,
 * and it can be checked by calling AMediaCodecActionCode_isRecoverable or
 * AMediaCodecActionCode_isTransient. If both AMediaCodecActionCode_isRecoverable()
 * and AMediaCodecActionCode_isTransient() return false, then the codec error is fatal
 * and the codec must be deleted.
 * The specified detail may contain more detailed messages about this error.
 */
AMediaCodecOnAsyncError :: #type proc "c" (
    codec: ^AMediaCodec,
    userdata: rawptr,
    error: media_status_t,
    actionCode: i32,
    detail: cstring
)

/**
 * Called when an output frame has rendered on the output surface.
 *
 * \param codec       The codec object that generated this notification.
 * \param userdata    The user data set at AMediaCodec_setOnFrameRenderedCallback.
 * \param mediaTimeUs The presentation time (media time) of the frame rendered.
 *                    This is usually the same as specified in
 *                    AMediaCodec_queueInputBuffer, but some codecs may alter
 *                    the media time by applying some time-based transformation,
 *                    such as frame rate conversion. In that case, presentation
 *                    time corresponds to the actual output frame rendered.
 * \param systemNano  The system time when the frame was rendered.
 */
AMediaCodecOnFrameRendered :: #type proc "c" (
    codec: ^AMediaCodec,
    userdata: rawptr,
    mediaTimeUs: i64,
    systemNano: i64,
)

foreign mediandk {
	/**
	 * Create codec by name. Use this if you know the exact codec you want to use.
	 * When configuring, you will need to specify whether to use the codec as an
	 * encoder or decoder.
	 *
	 * Available since API level 21.
	 */
	AMediaCodec_createCodecByName :: proc(name: cstring) -> ^AMediaCodec ---

	/**
	* Create codec by mime type. Most applications will use this, specifying a
	* mime type obtained from media extractor.
	*
	* Available since API level 21.
	*/
	AMediaCodec_createDecoderByType :: proc(mime_type: cstring) -> ^AMediaCodec ---

	/**
	* Create encoder by name.
	*
	* Available since API level 21.
	*/
	AMediaCodec_createEncoderByType :: proc(mime_type: cstring) -> ^AMediaCodec ---

	/**
	* Delete the codec and free its resources.
	*
	* Available since API level 21.
	*/
	AMediaCodec_delete :: proc(codec: ^AMediaCodec) -> media_status_t ---

	/**
	* Configure the codec. For decoding you would typically get the format from an extractor.
	*
	* Available since API level 21.
	*/
	AMediaCodec_configure :: proc(coded: ^AMediaCodec, format: ^AMediaFormat, surface: ^android.ANativeWindow, crypto: ^AMediaCrypto, flags: u32) -> media_status_t ---

	/**
	* Start the codec. A codec must be configured before it can be started, and must be started
	* before buffers can be sent to it.
	*
	* Available since API level 21.
	*/
	AMediaCodec_start :: proc(codec: ^AMediaCodec) -> media_status_t ---

	/**
	* Stop the codec.
	*
	* Available since API level 21.
	*/
	AMediaCodec_stop :: proc(codec: ^AMediaCodec) -> media_status_t ---

	/*
	* Flush the codec's input and output. All indices previously returned from calls to
	* AMediaCodec_dequeueInputBuffer and AMediaCodec_dequeueOutputBuffer become invalid.
	*
	* Available since API level 21.
	*/
	AMediaCodec_flush :: proc(codec: ^AMediaCodec) -> media_status_t ---

	/**
	* Get an input buffer. The specified buffer index must have been previously obtained from
	* dequeueInputBuffer, and not yet queued.
	*
	* Available since API level 21.
	*/
	AMediaCodec_getInputBuffer :: proc(codec: ^AMediaCodec, idx: uint, out_size: ^uint) -> [^]byte ---

	/**
	* Get an output buffer. The specified buffer index must have been previously obtained from
	* dequeueOutputBuffer, and not yet queued.
	*
	* Available since API level 21.
	*/
	AMediaCodec_getOutputBuffer :: proc(codec: ^AMediaCodec, idx: uint, out_size: ^uint) -> [^]byte ---

	/**
	* Get the index of the next available input buffer. An app will typically use this with
	* getInputBuffer() to get a pointer to the buffer, then copy the data to be encoded or decoded
	* into the buffer before passing it to the codec.
	*
	* Available since API level 21.
	*/
	AMediaCodec_dequeueInputBuffer :: proc(codec: ^AMediaCodec, timeoutUs: i64) -> int ---


	/**
	* Send the specified buffer to the codec for processing.
	*
	* Available since API level 21.
	*/
	AMediaCodec_queueInputBuffer :: proc(
		codec: ^AMediaCodec,
		idx: uint,
		offset: _off_t_compat,
		size: uint,
		time: u64,
		flags: u32) -> media_status_t ---

	/**
	* Send the specified buffer to the codec for processing.
	*
	* Available since API level 21.
	*/
	AMediaCodec_queueSecureInputBuffer :: proc(
		codec: ^AMediaCodec,
		idx: uint,
		offset: _off_t_compat,
		crypto_info: ^AMediaCodecCryptoInfo,
		time: u64,
		flags: u32) -> media_status_t ---

	/**
	* Get the index of the next available buffer of processed data.
	*
	* Available since API level 21.
	*/
	AMediaCodec_dequeueOutputBuffer :: proc(codec: ^AMediaCodec, info: ^AMediaCodecBufferInfo, timeoutUs: i64) -> int ---

	/**
	* Returns the format of the codec's output.
	* The caller must free the returned format.
	*
	* Available since API level 21.
	*/
	AMediaCodec_getOutputFormat :: proc(codec: ^AMediaCodec) -> ^AMediaFormat ---

	/**
	* If you are done with a buffer, use this call to return the buffer to
	* the codec. If you previously specified a surface when configuring this
	* video decoder you can optionally render the buffer.
	*
	* Available since API level 21.
	*/
	AMediaCodec_releaseOutputBuffer :: proc(codec: ^AMediaCodec, idx: uint, render: bool) -> media_status_t ---

	/**
	* Dynamically sets the output surface of a codec.
	*
	*  This can only be used if the codec was configured with an output surface.  The
	*  new output surface should have a compatible usage type to the original output surface.
	*  E.g. codecs may not support switching from a SurfaceTexture (GPU readable) output
	*  to ImageReader (software readable) output.
	*
	* For more details, see the Java documentation for MediaCodec.setOutputSurface.
	*
	* Available since API level 21.
	*/
	AMediaCodec_setOutputSurface :: proc(codec: ^AMediaCodec, surface: ^android.ANativeWindow) -> media_status_t ---

	/**
	* If you are done with a buffer, use this call to update its surface timestamp
	* and return it to the codec to render it on the output surface. If you
	* have not specified an output surface when configuring this video codec,
	* this call will simply return the buffer to the codec.
	*
	* For more details, see the Java documentation for MediaCodec.releaseOutputBuffer.
	*
	* Available since API level 21.
	*/
	AMediaCodec_releaseOutputBufferAtTime :: proc(mData: ^AMediaCodec, idx: uint, timestampNs: i64) -> media_status_t ---

	/**
	* Creates a Surface that can be used as the input to encoder, in place of input buffers
	*
	* This can only be called after the codec has been configured via
	* AMediaCodec_configure(..) and before AMediaCodec_start() has been called.
	*
	* The application is responsible for releasing the surface by calling
	* ANativeWindow_release() when done.
	*
	* For more details, see the Java documentation for MediaCodec.createInputSurface.
	*
	* Available since API level 26.
	*/
	AMediaCodec_createInputSurface :: proc(mData: ^AMediaCodec, surface: ^^android.ANativeWindow) -> media_status_t ---

	/**
	* Creates a persistent Surface that can be used as the input to encoder
	*
	* Persistent surface can be reused by MediaCodec instances and can be set
	* on a new instance via AMediaCodec_setInputSurface().
	* A persistent surface can be connected to at most one instance of MediaCodec
	* at any point in time.
	*
	* The application is responsible for releasing the surface by calling
	* ANativeWindow_release() when done.
	*
	* For more details, see the Java documentation for MediaCodec.createPersistentInputSurface.
	*
	* Available since API level 26.
	*/
	AMediaCodec_createPersistentInputSurface :: proc(surface: ^^android.ANativeWindow) -> media_status_t ---

	/**
	* Set a persistent-surface that can be used as the input to encoder, in place of input buffers
	*
	* The surface provided *must* be a persistent surface created via
	* AMediaCodec_createPersistentInputSurface()
	* This can only be called after the codec has been configured by calling
	* AMediaCodec_configure(..) and before AMediaCodec_start() has been called.
	*
	* For more details, see the Java documentation for MediaCodec.setInputSurface.
	*
	* Available since API level 26.
	*/
	AMediaCodec_setInputSurface :: proc(mData: ^AMediaCodec, surface: ^android.ANativeWindow) -> media_status_t ---

	/**
	* Signal additional parameters to the codec instance.
	*
	* Parameters can be communicated only when the codec is running, i.e
	* after AMediaCodec_start() has been called.
	*
	* NOTE: Some of these parameter changes may silently fail to apply.
	*
	* Available since API level 26.
	*/
	AMediaCodec_setParameters :: proc(mData: ^AMediaCodec, params: ^AMediaFormat) -> media_status_t ---

	/**
	* Signals end-of-stream on input. Equivalent to submitting an empty buffer with
	* AMEDIACODEC_BUFFER_FLAG_END_OF_STREAM set.
	*
	* Returns AMEDIA_ERROR_INVALID_OPERATION when used with an encoder not in executing state
	* or not receiving input from a Surface created by AMediaCodec_createInputSurface or
	* AMediaCodec_createPersistentInputSurface.
	*
	* Returns the previous codec error if one exists.
	*
	* Returns AMEDIA_OK when completed succesfully.
	*
	* For more details, see the Java documentation for MediaCodec.signalEndOfInputStream.
	*
	* Available since API level 26.
	*/
	AMediaCodec_signalEndOfInputStream :: proc(mData: ^AMediaCodec) -> media_status_t ---

	/**
	* Get format of the buffer. The specified buffer index must have been previously obtained from
	* dequeueOutputBuffer.
	* The caller must free the returned format.
	*
	* Available since API level 28.
	*/
	AMediaCodec_getBufferFormat :: proc(codec: ^AMediaCodec, index: uint) -> ^AMediaFormat ---

	/**
	* Get the component name. If the codec was created by createDecoderByType
	* or createEncoderByType, what component is chosen is not known beforehand.
	* Caller shall call AMediaCodec_releaseName to free the returned pointer.
	*
	* Available since API level 28.
	*/
	AMediaCodec_getName :: proc(codec: ^AMediaCodec, out_name: ^cstring) -> media_status_t ---

	/**
	* Free the memory pointed by name which is returned by AMediaCodec_getName.
	*
	* Available since API level 28.
	*/
	AMediaCodec_releaseName :: proc(codec: ^AMediaCodec, name: cstring) ---

	/**
	* Set an asynchronous callback for actionable AMediaCodec events.
	* When asynchronous callback is enabled, it is an error for the client to call
	* AMediaCodec_getInputBuffers(), AMediaCodec_getOutputBuffers(),
	* AMediaCodec_dequeueInputBuffer() or AMediaCodec_dequeueOutputBuffer().
	*
	* AMediaCodec_flush() behaves differently in asynchronous mode.
	* After calling AMediaCodec_flush(), the client must call AMediaCodec_start() to
	* "resume" receiving input buffers. Even if the client does not receive
	* AMediaCodecOnAsyncInputAvailable callbacks from video encoders configured
	* with an input surface, the client still needs to call AMediaCodec_start()
	* to resume the input surface to send buffers to the encoders.
	*
	* When called with null callback, this method unregisters any previously set callback.
	*
	* Refer to the definition of AMediaCodecOnAsyncNotifyCallback on how each
	* callback function is called and what are specified.
	* The specified userdata is opaque data which will be passed along
	* when the callback functions are called. MediaCodec does not look at or alter the
	* value of userdata. Often it is a pointer to a client-owned object,
	* and client manages the lifecycle of the object in that case.
	*
	* Once the callback is unregistered or the codec is reset / released, the
	* previously registered callback will not be called.
	*
	* All callbacks are fired on one NDK internal thread.
	* AMediaCodec_setAsyncNotifyCallback should not be called on the callback thread.
	* No heavy duty task should be performed on callback thread.
	*
	* Available since API level 28.
	*/
	AMediaCodec_setAsyncNotifyCallback :: proc(
		codec: ^AMediaCodec,
		callback: AMediaCodecOnAsyncNotifyCallback,
		userdata: rawptr) -> media_status_t ---

	/**
	* Registers a callback to be invoked when an output frame is rendered on the output surface.
	*
	* This method can be called in any codec state, but will only have an effect in the
	* Executing state for codecs that render buffers to the output surface.
	*
	* This callback is for informational purposes only: to get precise
	* render timing samples, and can be significantly delayed and batched. Some frames may have
	* been rendered even if there was no callback generated.
	*
	* When called with null callback, this method unregisters any previously set callback.
	*
	* Refer to the definition of AMediaCodecOnFrameRendered on how each
	* callback function is called and what are specified.
	* The specified userdata is opaque data which will be passed along
	* when the callback functions are called. MediaCodec does not look at or alter the
	* value of userdata. Often it is a pointer to a client-owned object,
	* and client manages the lifecycle of the object in that case.
	*
	* Once the callback is unregistered or the codec is reset / released, the
	* previously registered callback will not be called.
	*
	* All callbacks are fired on one NDK internal thread.
	* AMediaCodec_setOnFrameRenderedCallback should not be called on the callback thread.
	* No heavy duty task should be performed on callback thread.
	*
	* Available since Android T.
	*/
	AMediaCodec_setOnFrameRenderedCallback :: proc(
	codec: ^AMediaCodec,
	callback: AMediaCodecOnFrameRendered,
	userdata: rawptr) -> media_status_t ---

	/**
	* Release the crypto if applicable.
	*
	* Available since API level 28.
	*/
	AMediaCodec_releaseCrypto :: proc(codec: ^AMediaCodec) -> media_status_t ---

	/**
	* Call this after AMediaCodec_configure() returns successfully to get the input
	* format accepted by the codec. Do this to determine what optional configuration
	* parameters were supported by the codec.
	* The caller must free the returned format.
	*
	* Available since API level 28.
	*/
	AMediaCodec_getInputFormat :: proc(codec: ^AMediaCodec) -> ^AMediaFormat ---

	/**
	* Returns true if the codec cannot proceed further, but can be recovered by stopping,
	* configuring, and starting again.
	*
	* Available since API level 28.
	*/
	AMediaCodecActionCode_isRecoverable :: proc(actionCode: i32) -> bool ---

	/**
	* Returns true if the codec error is a transient issue, perhaps due to
	* resource constraints, and that the method (or encoding/decoding) may be
	* retried at a later time.
	*
	* Available since API level 28.
	*/
	AMediaCodecActionCode_isTransient :: proc(actionCode: i32) -> bool ---

	/**
	* Create an AMediaCodecCryptoInfo from scratch. Use this if you need to use custom
	* crypto info, rather than one obtained from AMediaExtractor.
	*
	* AMediaCodecCryptoInfo describes the structure of an (at least
	* partially) encrypted input sample.
	* A buffer's data is considered to be partitioned into "subsamples",
	* each subsample starts with a (potentially empty) run of plain,
	* unencrypted bytes followed by a (also potentially empty) run of
	* encrypted bytes.
	* numBytesOfClearData can be null to indicate that all data is encrypted.
	* This information encapsulates per-sample metadata as outlined in
	* ISO/IEC FDIS 23001-7:2011 "Common encryption in ISO base media file format files".
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_new :: proc(
	numsubsamples: i32,
	key: [16]byte,
	iv: [16]byte,
	mode: cryptoinfo_mode_t,
	clearbytes: ^uint,
	encryptedbytes: ^uint) -> ^AMediaCodecCryptoInfo ---

	/**
	* Delete an AMediaCodecCryptoInfo created previously with AMediaCodecCryptoInfo_new, or
	* obtained from AMediaExtractor.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_delete :: proc(info: ^AMediaCodecCryptoInfo) -> media_status_t ---

	/**
	* Set the crypto pattern on an AMediaCryptoInfo object.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_setPattern :: proc(info: ^AMediaCodecCryptoInfo, pattern: ^cryptoinfo_pattern_t) ---

	/**
	* The number of subsamples that make up the buffer's contents.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getNumSubSamples :: proc(info: ^AMediaCodecCryptoInfo) -> uint ---

	/**
	* A 16-byte opaque key.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getKey :: proc(info: ^AMediaCodecCryptoInfo, dst: [^]byte) -> media_status_t ---

	/**
	* A 16-byte initialization vector.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getIV :: proc(info: ^AMediaCodecCryptoInfo, dst: [^]byte) -> media_status_t ---

	/**
	* The type of encryption that has been applied,
	* one of AMEDIACODECRYPTOINFO_MODE_CLEAR or AMEDIACODECRYPTOINFO_MODE_AES_CTR.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getMode :: proc(info: ^AMediaCodecCryptoInfo) -> cryptoinfo_mode_t ---

	/**
	* The number of leading unencrypted bytes in each subsample.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getClearBytes :: proc(info: ^AMediaCodecCryptoInfo, dst: ^uint) -> media_status_t ---

	/**
	* The number of trailing encrypted bytes in each subsample.
	*
	* Available since API level 21.
	*/
	AMediaCodecCryptoInfo_getEncryptedBytes :: proc(info: ^AMediaCodecCryptoInfo, dst: ^uint) -> media_status_t ---
}
