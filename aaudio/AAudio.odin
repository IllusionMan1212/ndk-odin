package aaudio

foreign import aaudio "system:aaudio"

/**
 * This is used to represent a value that has not been specified.
 * For example, an application could use {@link #AAUDIO_UNSPECIFIED} to indicate
 * that it did not care what the specific value of a parameter was
 * and would accept whatever it was given.
 */
AAUDIO_UNSPECIFIED          :: 0
AAUDIO_SYSTEM_USAGE_OFFSET  :: 1000

// TODO: doesn't belong here. move to sys/android or something.
clockid_t :: i32

AAudioDirection :: enum i32 {
    /**
     * Audio data will travel out of the device, for example through a speaker.
     */
    OUTPUT,


    /**
     * Audio data will travel into the device, for example from a microphone.
     */
    INPUT
}

AAudioFormat :: enum i32 {
    INVALID = -1,
    UNSPECIFIED = 0,

    /**
     * This format uses the int16_t data type.
     * The maximum range of the data is -32768 (0x8000) to 32767 (0x7FFF).
     */
    PCM_I16,

    /**
     * This format uses the float data type.
     * The nominal range of the data is [-1.0f, 1.0f).
     * Values outside that range may be clipped.
     *
     * See also the float Data in
     * <a href="/reference/android/media/AudioTrack#write(float[],%20int,%20int,%20int)">
     *   write(float[], int, int, int)</a>.
     */
    PCM_FLOAT,

    /**
     * This format uses 24-bit samples packed into 3 bytes.
     * The bytes are in little-endian order, so the least significant byte
     * comes first in the byte array.
     *
     * The maximum range of the data is -8388608 (0x800000)
     * to 8388607 (0x7FFFFF).
     *
     * Note that the lower precision bits may be ignored by the device.
     *
     * Available since API level 31.
     */
    PCM_I24_PACKED,

    /**
     * This format uses 32-bit samples stored in an int32_t data type.
     * The maximum range of the data is -2147483648 (0x80000000)
     * to 2147483647 (0x7FFFFFFF).
     *
     * Note that the lower precision bits may be ignored by the device.
     *
     * Available since API level 31.
     */
    PCM_I32
}

/**
 * These result codes are returned from AAudio functions to indicate success or failure.
 * Note that error return codes may change in the future so applications should generally
 * not rely on specific return codes.
 */
AAudioResult :: enum i32 {
    /**
     * The call was successful.
     */
    OK,
    ERROR_BASE = -900,

    /**
     * The audio device was disconnected. This could occur, for example, when headphones
     * are plugged in or unplugged. The stream cannot be used after the device is disconnected.
     * Applications should stop and close the stream.
     * If this error is received in an error callback then another thread should be
     * used to stop and close the stream.
     */
    ERROR_DISCONNECTED,

    /**
     * An invalid parameter was passed to AAudio.
     */
    ERROR_ILLEGAL_ARGUMENT,
    // reserved
    ERROR_INTERNAL = ERROR_ILLEGAL_ARGUMENT + 2,

    /**
     * The requested operation is not appropriate for the current state of AAudio.
     */
    ERROR_INVALID_STATE,
    // reserved
    // reserved
    /* The server rejected the handle used to identify the stream.
     */
    ERROR_INVALID_HANDLE = ERROR_INVALID_STATE + 3,
    // reserved

    /**
     * The function is not implemented for this stream.
     */
    ERROR_UNIMPLEMENTED = ERROR_INVALID_HANDLE + 2,

    /**
     * A resource or information is unavailable.
     * This could occur when an application tries to open too many streams,
     * or a timestamp is not available.
     */
    ERROR_UNAVAILABLE,
    ERROR_NO_FREE_HANDLES,

    /**
     * Memory could not be allocated.
     */
    ERROR_NO_MEMORY,

    /**
     * A NULL pointer was passed to AAudio.
     * Or a NULL pointer was detected internally.
     */
    ERROR_NULL,

    /**
     * An operation took longer than expected.
     */
    ERROR_TIMEOUT,
    ERROR_WOULD_BLOCK,

    /**
     * The requested data format is not supported.
     */
    ERROR_INVALID_FORMAT,

    /**
     * A requested was out of range.
     */
    ERROR_OUT_OF_RANGE,

    /**
     * The audio service was not available.
     */
    ERROR_NO_SERVICE,

    /**
     * The requested sample rate was not supported.
     */
    ERROR_INVALID_RATE
}

/**
 * AAudio Stream states, for details, refer to
 * <a href="/ndk/guides/audio/aaudio/aaudio#using-streams">Using an Audio Stream</a>
 */
AAudioStreamState :: enum i32 {
    /**
     * The stream is created but not initialized yet.
     */
    UNINITIALIZED = 0,
    /**
     * The stream is in an unrecognized state.
     */
    UNKNOWN,

    /**
     * The stream is open and ready to use.
     */
    OPEN,
    /**
     * The stream is just starting up.
     */
    STARTING,
    /**
     * The stream has started.
     */
    STARTED,
    /**
     * The stream is pausing.
     */
    PAUSING,
    /**
     * The stream has paused, could be restarted or flushed.
     */
    PAUSED,
    /**
     * The stream is being flushed.
     */
    FLUSHING,
    /**
     * The stream is flushed, ready to be restarted.
     */
    FLUSHED,
    /**
     * The stream is stopping.
     */
    STOPPING,
    /**
     * The stream has been stopped.
     */
    STOPPED,
    /**
     * The stream is closing.
     */
    CLOSING,
    /**
     * The stream has been closed.
     */
    CLOSED,
    /**
     * The stream is disconnected from audio device.
     */
    DISCONNECTED
}


AAudioSharingMode :: enum i32 {
    /**
     * This will be the only stream using a particular source or sink.
     * This mode will provide the lowest possible latency.
     * You should close EXCLUSIVE streams immediately when you are not using them.
     */
	 EXCLUSIVE,
    /**
     * Multiple applications will be mixed by the AAudio Server.
     * This will have higher latency than the EXCLUSIVE mode.
     */
	 SHARED
}


AAudioPerformanceMode :: enum i32 {
    /**
     * No particular performance needs. Default.
     */
    NONE = 10,

    /**
     * Extending battery life is more important than low latency.
     *
     * This mode is not supported in input streams.
     * For input, mode NONE will be used if this is requested.
     */
    POWER_SAVING,

    /**
     * Reducing latency is more important than battery life.
     */
    LOW_LATENCY
}

/**
 * The USAGE attribute expresses "why" you are playing a sound, what is this sound used for.
 * This information is used by certain platforms or routing policies
 * to make more refined volume or routing decisions.
 *
 * Note that these match the equivalent values in
 * <a href="/reference/android/media/AudioAttributes">AudioAttributes</a>
 * in the Android Java API.
 *
 * Added in API level 28.
 */
AAudioUsage :: enum i32 {
    /**
     * Use this for streaming media, music performance, video, podcasts, etcetera.
     */
    MEDIA = 1,

    /**
     * Use this for voice over IP, telephony, etcetera.
     */
    VOICE_COMMUNICATION = 2,

    /**
     * Use this for sounds associated with telephony such as busy tones, DTMF, etcetera.
     */
    VOICE_COMMUNICATION_SIGNALLING = 3,

    /**
     * Use this to demand the users attention.
     */
    ALARM = 4,

    /**
     * Use this for notifying the user when a message has arrived or some
     * other background event has occured.
     */
    NOTIFICATION = 5,

    /**
     * Use this when the phone rings.
     */
    NOTIFICATION_RINGTONE = 6,

    /**
     * Use this to attract the users attention when, for example, the battery is low.
     */
    NOTIFICATION_EVENT = 10,

    /**
     * Use this for screen readers, etcetera.
     */
    ASSISTANCE_ACCESSIBILITY = 11,

    /**
     * Use this for driving or navigation directions.
     */
    ASSISTANCE_NAVIGATION_GUIDANCE = 12,

    /**
     * Use this for user interface sounds, beeps, etcetera.
     */
    ASSISTANCE_SONIFICATION = 13,

    /**
     * Use this for game audio and sound effects.
     */
    GAME = 14,

    /**
     * Use this for audio responses to user queries, audio instructions or help utterances.
     */
    ASSISTANT = 16,

    /**
     * Use this in case of playing sounds in an emergency.
     * Privileged MODIFY_AUDIO_ROUTING permission required.
     */
    EMERGENCY = AAUDIO_SYSTEM_USAGE_OFFSET,

    /**
     * Use this for safety sounds and alerts, for example backup camera obstacle detection.
     * Privileged MODIFY_AUDIO_ROUTING permission required.
     */
    SAFETY = AAUDIO_SYSTEM_USAGE_OFFSET + 1,

    /**
     * Use this for vehicle status alerts and information, for example the check engine light.
     * Privileged MODIFY_AUDIO_ROUTING permission required.
     */
    VEHICLE_STATUS = AAUDIO_SYSTEM_USAGE_OFFSET + 2,

    /**
     * Use this for traffic announcements, etc.
     * Privileged MODIFY_AUDIO_ROUTING permission required.
     */
    ANNOUNCEMENT = AAUDIO_SYSTEM_USAGE_OFFSET + 3,
}

/**
 * The CONTENT_TYPE attribute describes "what" you are playing.
 * It expresses the general category of the content. This information is optional.
 * But in case it is known (for instance AAUDIO_CONTENT_TYPE_MOVIE for a
 * movie streaming service or AAUDIO_CONTENT_TYPE_SPEECH for
 * an audio book application) this information might be used by the audio framework to
 * enforce audio focus.
 *
 * Note that these match the equivalent values in
 * <a href="/reference/android/media/AudioAttributes">AudioAttributes</a>
 * in the Android Java API.
 *
 * Added in API level 28.
 */
AAudioContentType :: enum i32 {

    /**
     * Use this for spoken voice, audio books, etcetera.
     */
    SPEECH = 1,

    /**
     * Use this for pre-recorded or live music.
     */
    MUSIC = 2,

    /**
     * Use this for a movie or video soundtrack.
     */
    MOVIE = 3,

    /**
     * Use this for sound is designed to accompany a user action,
     * such as a click or beep sound made when the user presses a button.
     */
    SONIFICATION = 4
}

AAudioSpatializationBehavior :: enum i32 {

    /**
     * Constant indicating the audio content associated with these attributes will follow the
     * default platform behavior with regards to which content will be spatialized or not.
     */
    AUTO = 1,

    /**
     * Constant indicating the audio content associated with these attributes should never
     * be spatialized.
     */
    NEVER = 2,
}

/**
 * Defines the audio source.
 * An audio source defines both a default physical source of audio signal, and a recording
 * configuration.
 *
 * Note that these match the equivalent values in MediaRecorder.AudioSource in the Android Java API.
 *
 * Added in API level 28.
 */
AAudioInputPreset :: enum i32 {
    /**
     * Use this preset when other presets do not apply.
     */
    GENERIC = 1,

    /**
     * Use this preset when recording video.
     */
    CAMCORDER = 5,

    /**
     * Use this preset when doing speech recognition.
     */
    VOICE_RECOGNITION = 6,

    /**
     * Use this preset when doing telephony or voice messaging.
     */
    VOICE_COMMUNICATION = 7,

    /**
     * Use this preset to obtain an input with no effects.
     * Note that this input will not have automatic gain control
     * so the recorded volume may be very low.
     */
    UNPROCESSED = 9,

    /**
     * Use this preset for capturing audio meant to be processed in real time
     * and played back for live performance (e.g karaoke).
     * The capture path will minimize latency and coupling with playback path.
     * Available since API level 29.
     */
    VOICE_PERFORMANCE = 10,
}

/**
 * Specifying if audio may or may not be captured by other apps or the system.
 *
 * Note that these match the equivalent values in
 * <a href="/reference/android/media/AudioAttributes">AudioAttributes</a>
 * in the Android Java API.
 *
 * Added in API level 29.
 */
AAudioAllowedCapturePolicy :: enum i32 {
    /**
     * Indicates that the audio may be captured by any app.
     *
     * For privacy, the following usages can not be recorded: AAUDIO_VOICE_COMMUNICATION*,
     * AAUDIO_USAGE_NOTIFICATION*, AAUDIO_USAGE_ASSISTANCE* and {@link #AAUDIO_USAGE_ASSISTANT}.
     *
     * On <a href="/reference/android/os/Build.VERSION_CODES#Q">Build.VERSION_CODES</a>,
     * this means only {@link #AAUDIO_USAGE_MEDIA} and {@link #AAUDIO_USAGE_GAME} may be captured.
     *
     * See <a href="/reference/android/media/AudioAttributes.html#ALLOW_CAPTURE_BY_ALL">
     * ALLOW_CAPTURE_BY_ALL</a>.
     */
    ALLOW_CAPTURE_BY_ALL = 1,
    /**
     * Indicates that the audio may only be captured by system apps.
     *
     * System apps can capture for many purposes like accessibility, user guidance...
     * but have strong restriction. See
     * <a href="/reference/android/media/AudioAttributes.html#ALLOW_CAPTURE_BY_SYSTEM">
     * ALLOW_CAPTURE_BY_SYSTEM</a>
     * for what the system apps can do with the capture audio.
     */
    ALLOW_CAPTURE_BY_SYSTEM = 2,
    /**
     * Indicates that the audio may not be recorded by any app, even if it is a system app.
     *
     * It is encouraged to use {@link #AAUDIO_ALLOW_CAPTURE_BY_SYSTEM} instead of this value as system apps
     * provide significant and useful features for the user (eg. accessibility).
     * See <a href="/reference/android/media/AudioAttributes.html#ALLOW_CAPTURE_BY_NONE">
     * ALLOW_CAPTURE_BY_NONE</a>.
     */
    ALLOW_CAPTURE_BY_NONE = 3,
}

/**
 * These may be used with AAudioStreamBuilder_setSessionId().
 *
 * Added in API level 28.
 */
AAudioSessionId :: enum i32 {
    /**
     * Do not allocate a session ID.
     * Effects cannot be used with this stream.
     * Default.
     *
     * Added in API level 28.
     */
    NONE = -1,

    /**
     * Allocate a session ID that can be used to attach and control
     * effects using the Java AudioEffects API.
     * Note that using this may result in higher latency.
     *
     * Note that this matches the value of AudioManager.AUDIO_SESSION_ID_GENERATE.
     *
     * Added in API level 28.
     */
    ALLOCATE = 0,
}

/**
 * Defines the audio channel mask.
 * Channel masks are used to describe the samples and their
 * arrangement in the audio frame. They are also used in the endpoint
 * (e.g. a USB audio interface, a DAC connected to headphones) to
 * specify allowable configurations of a particular device.
 *
 * Added in API level 32.
 */
AAudioChannelMask :: enum u32 {
    /**
     * Invalid channel mask
     */
    INVALID = 0xFFFFFFFF, // -1

    /**
     * Output audio channel mask
     */
    FRONT_LEFT = 1 << 0,
    FRONT_RIGHT = 1 << 1,
    FRONT_CENTER = 1 << 2,
    LOW_FREQUENCY = 1 << 3,
    BACK_LEFT = 1 << 4,
    BACK_RIGHT = 1 << 5,
    FRONT_LEFT_OF_CENTER = 1 << 6,
    FRONT_RIGHT_OF_CENTER = 1 << 7,
    BACK_CENTER = 1 << 8,
    SIDE_LEFT = 1 << 9,
    SIDE_RIGHT = 1 << 10,
    TOP_CENTER = 1 << 11,
    TOP_FRONT_LEFT = 1 << 12,
    TOP_FRONT_CENTER = 1 << 13,
    TOP_FRONT_RIGHT = 1 << 14,
    TOP_BACK_LEFT = 1 << 15,
    TOP_BACK_CENTER = 1 << 16,
    TOP_BACK_RIGHT = 1 << 17,
    TOP_SIDE_LEFT = 1 << 18,
    TOP_SIDE_RIGHT = 1 << 19,
    BOTTOM_FRONT_LEFT = 1 << 20,
    BOTTOM_FRONT_CENTER = 1 << 21,
    BOTTOM_FRONT_RIGHT = 1 << 22,
    LOW_FREQUENCY_2 = 1 << 23,
    FRONT_WIDE_LEFT = 1 << 24,
    FRONT_WIDE_RIGHT = 1 << 25,

    MONO = FRONT_LEFT,
    STEREO = FRONT_LEFT | FRONT_RIGHT,
    _2POINT1 = FRONT_LEFT | FRONT_RIGHT | LOW_FREQUENCY,
    TRI = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER,
    TRI_BACK = FRONT_LEFT | FRONT_RIGHT | BACK_CENTER,
    _3POINT1 = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | LOW_FREQUENCY,
    _2POINT0POINT2 = FRONT_LEFT | FRONT_RIGHT | TOP_SIDE_LEFT | TOP_SIDE_RIGHT,
    _2POINT1POINT2 = _2POINT0POINT2 | LOW_FREQUENCY,
    _3POINT0POINT2 = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | TOP_SIDE_LEFT | TOP_SIDE_RIGHT,
    _3POINT1POINT2 = _3POINT0POINT2 | LOW_FREQUENCY,
    QUAD = FRONT_LEFT | FRONT_RIGHT | BACK_LEFT | BACK_RIGHT,
    QUAD_SIDE = FRONT_LEFT | FRONT_RIGHT | SIDE_LEFT | SIDE_RIGHT,
    SURROUND = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | BACK_CENTER,
    PENTA = QUAD | FRONT_CENTER,
    // aka 5POINT1_BACK
    _5POINT1 = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | LOW_FREQUENCY | BACK_LEFT | BACK_RIGHT,
    _5POINT1_SIDE = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | LOW_FREQUENCY | SIDE_LEFT | SIDE_RIGHT,
    _6POINT1 = FRONT_LEFT | FRONT_RIGHT | FRONT_CENTER | LOW_FREQUENCY | BACK_LEFT | BACK_RIGHT | BACK_CENTER,
    _7POINT1 = _5POINT1 | SIDE_LEFT | SIDE_RIGHT,
    _5POINT1POINT2 = _5POINT1 | TOP_SIDE_LEFT | TOP_SIDE_RIGHT,
    _5POINT1POINT4 = _5POINT1 | TOP_FRONT_LEFT | TOP_FRONT_RIGHT | TOP_BACK_LEFT | TOP_BACK_RIGHT,
    _7POINT1POINT2 = _7POINT1 | TOP_SIDE_LEFT | TOP_SIDE_RIGHT,
    _7POINT1POINT4 = _7POINT1 | TOP_FRONT_LEFT | TOP_FRONT_RIGHT | TOP_BACK_LEFT | TOP_BACK_RIGHT,
    _9POINT1POINT4 = _7POINT1POINT4 | FRONT_WIDE_LEFT | FRONT_WIDE_RIGHT,
    _9POINT1POINT6 = _9POINT1POINT4 | TOP_SIDE_LEFT | TOP_SIDE_RIGHT,

    FRONT_BACK = FRONT_CENTER | BACK_CENTER,
}

/**
* Return one of these values from the data callback function.
*/
AAudioDataCallbackResult :: enum i32 {
    /**
     * Continue calling the callback.
     */
    CONTINUE = 0,
    /**
     *
     Stop calling the callback.
     *
     * The application will still need to call AAudioStream_requestPause()
     * or AAudioStream_requestStop().
     */
    STOP,
}

AAudioStream :: struct{}
AAudioStreamBuilder :: struct{}

/**
* Prototype for the data function that is passed to AAudioStreamBuilder_setDataCallback :: proc().
*
* For an output stream, this function should render and write numFrames of data
* in the streams current data format to the audioData buffer.
*
* For an input stream, this function should read and process numFrames of data
* from the audioData buffer.
*
* The audio data is passed through the buffer. So do NOT call AAudioStream_read :: proc() or
* AAudioStream_write :: proc() on the stream that is making the callback.
*
* Note that numFrames can vary unless AAudioStreamBuilder_setFramesPerDataCallback :: proc()
* is called.
*
* Also note that this callback function should be considered a "real-time" function.
* It must not do anything that could cause an unbounded delay because that can cause the
* audio to glitch or pop.
*
* These are things the function should NOT do:
* <ul>
* <li>allocate memory using, for example, malloc :: proc() or new</li>
* <li>any file operations such as opening, closing, reading or writing</li>
* <li>any network operations such as streaming</li>
* <li>use any mutexes or other synchronization primitives</li>
* <li>sleep</li>
* <li>stop or close the stream</li>
* <li>AAudioStream_read :: proc()</li>
* <li>AAudioStream_write :: proc()</li>
* </ul>
*
* The following are OK to call from the data callback:
* <ul>
* <li>AAudioStream_get*()</li>
* <li>AAudio_convertResultToText :: proc()</li>
* </ul>
*
* If you need to move data, eg. MIDI commands, in or out of the callback function then
* we recommend the use of non-blocking techniques such as an atomic FIFO.
*
* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
* @param userData the same address that was passed to AAudioStreamBuilder_setCallback :: proc()
* @param audioData a pointer to the audio data
* @param numFrames the number of frames to be processed, which can vary
* @return AAUDIO_CALLBACK_RESULT_*
*/
AAudioStream_dataCallback :: #type proc "c" (stream: ^AAudioStream, userData: rawptr, audioData: rawptr, numFrames: i32) -> AAudioDataCallbackResult

/**
* Prototype for the callback function that is passed to
* AAudioStreamBuilder_setErrorCallback :: proc().
*
* The following may NOT be called from the error callback:
* <ul>
* <li>AAudioStream_requestStop :: proc()</li>
* <li>AAudioStream_requestPause :: proc()</li>
* <li>AAudioStream_close :: proc()</li>
* <li>AAudioStream_waitForStateChange :: proc()</li>
* <li>AAudioStream_read :: proc()</li>
* <li>AAudioStream_write :: proc()</li>
* </ul>
*
* The following are OK to call from the error callback:
* <ul>
* <li>AAudioStream_get*()</li>
* <li>AAudio_convertResultToText :: proc()</li>
* </ul>
*
* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
* @param userData the same address that was passed to AAudioStreamBuilder_setErrorCallback :: proc()
* @param error an AAUDIO_ERROR_* value.
*/
AAudioStream_errorCallback :: #type proc "c" (stream: ^AAudioStream, userData: rawptr, error: AAudioResult)

foreign aaudio {
	/**
	 * The text is the ASCII symbol corresponding to the returnCode,
	 * or an English message saying the returnCode is unrecognized.
	 * This is intended for developers to use when debugging.
	 * It is not for display to users.
	 *
	 * Available since API level 26.
	 *
	 * @return pointer to a text representation of an AAudio result code.
	 */
	AAudio_convertResultToText :: proc(returnCode: AAudioResult) -> cstring ---

	/**
	* The text is the ASCII symbol corresponding to the stream state,
	* or an English message saying the state is unrecognized.
	* This is intended for developers to use when debugging.
	* It is not for display to users.
	*
	* Available since API level 26.
	*
	* @return pointer to a text representation of an AAudio state.
	*/
	AAudio_convertStreamStateToText :: proc(state: AAudioStreamState) -> cstring ---

	// ============================================================
	// StreamBuilder
	// ============================================================

	/**
	* Create a StreamBuilder that can be used to open a Stream.
	*
	* The deviceId is initially unspecified, meaning that the current default device will be used.
	*
	* The default direction is {@link #AAUDIO_DIRECTION_OUTPUT}.
	* The default sharing mode is {@link #AAUDIO_SHARING_MODE_SHARED}.
	* The data format, samplesPerFrames and sampleRate are unspecified and will be
	* chosen by the device when it is opened.
	*
	* AAudioStreamBuilder_delete :: proc() must be called when you are done using the builder.
	*
	* Available since API level 26.
	*/
	AAudio_createStreamBuilder :: proc(builder: ^^AAudioStreamBuilder) -> AAudioResult ---

	/**
	* Request an audio device identified by an ID.
	*
	* The ID could be obtained from the Java AudioManager.
	* AudioManager.getDevices :: proc() returns an array of {@link AudioDeviceInfo},
	* which contains a getId :: proc() method. That ID can be passed to this function.
	*
	* It is possible that you may not get the device that you requested.
	* So if it is important to you, you should call
	* AAudioStream_getDeviceId :: proc() after the stream is opened to
	* verify the actual ID.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED},
	* in which case the primary device will be used.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param deviceId device identifier or {@link #AAUDIO_UNSPECIFIED}
	*/
	AAudioStreamBuilder_setDeviceId :: proc(builder: ^AAudioStreamBuilder, deviceId: i32) ---

	/**
	* Declare the name of the package creating the stream.
	*
	* This is usually {@code Context#getPackageName :: proc()}.
	*
	* The default, if you do not call this function, is a random package in the calling uid.
	* The vast majority of apps have only one package per calling UID.
	* If an invalid package name is set, input streams may not be given permission to
	* record when started.
	*
	* The package name is usually the applicationId in your app's build.gradle file.
	*
	* Available since API level 31.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param packageName packageName of the calling app.
	*/
	AAudioStreamBuilder_setPackageName :: proc(builder: ^AAudioStreamBuilder, packageName: cstring) ---

	/**
	* Declare the attribution tag of the context creating the stream.
	*
	* This is usually {@code Context#getAttributionTag :: proc()}.
	*
	* The default, if you do not call this function, is null.
	*
	* Available since API level 31.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param attributionTag attributionTag of the calling context.
	*/
	AAudioStreamBuilder_setAttributionTag :: proc(builder: ^AAudioStreamBuilder, attributionTag: cstring) ---

	/**
	* Request a sample rate in Hertz.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	* An optimal value will then be chosen when the stream is opened.
	* After opening a stream with an unspecified value, the application must
	* query for the actual value, which may vary by device.
	*
	* If an exact value is specified then an opened stream will use that value.
	* If a stream cannot be opened with the specified value then the open will fail.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param sampleRate frames per second. Common rates include 44100 and 48000 Hz.
	*/
	AAudioStreamBuilder_setSampleRate :: proc(builder: ^AAudioStreamBuilder, sampleRate: i32) ---

	/**
	* Request a number of channels for the stream.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	* An optimal value will then be chosen when the stream is opened.
	* After opening a stream with an unspecified value, the application must
	* query for the actual value, which may vary by device.
	*
	* If an exact value is specified then an opened stream will use that value.
	* If a stream cannot be opened with the specified value then the open will fail.
	*
	* As the channel count provided here may be different from the corresponding channel count
	* of channel mask used in {@link AAudioStreamBuilder_setChannelMask}, the last called function
	* will be respected if both this function and {@link AAudioStreamBuilder_setChannelMask} are
	* called.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param channelCount Number of channels desired.
	*/
	AAudioStreamBuilder_setChannelCount :: proc(builder: ^AAudioStreamBuilder, channelCount: i32) ---

	/**
	* Identical to AAudioStreamBuilder_setChannelCount :: proc().
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param samplesPerFrame Number of samples in a frame.
	*
	* @deprecated use {@link AAudioStreamBuilder_setChannelCount}
	*/
	AAudioStreamBuilder_setSamplesPerFrame :: proc(builder: ^AAudioStreamBuilder, samplesPerFrame: i32) ---

	/**
	* Request a sample data format, for example {@link #AAUDIO_FORMAT_PCM_I16}.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	* An optimal value will then be chosen when the stream is opened.
	* After opening a stream with an unspecified value, the application must
	* query for the actual value, which may vary by device.
	*
	* If an exact value is specified then an opened stream will use that value.
	* If a stream cannot be opened with the specified value then the open will fail.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param format common formats are {@link #AAUDIO_FORMAT_PCM_FLOAT} and
	*               {@link #AAUDIO_FORMAT_PCM_I16}.
	*/
	AAudioStreamBuilder_setFormat :: proc(builder: ^AAudioStreamBuilder, format: AAudioFormat) ---

	/**
	* Request a mode for sharing the device.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_SHARING_MODE_SHARED}.
	*
	* The requested sharing mode may not be available.
	* The application can query for the actual mode after the stream is opened.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param sharingMode {@link #AAUDIO_SHARING_MODE_SHARED} or {@link #AAUDIO_SHARING_MODE_EXCLUSIVE}
	*/
	AAudioStreamBuilder_setSharingMode :: proc(builder: ^AAudioStreamBuilder, sharingMode: AAudioSharingMode) ---

	/**
	* Request the direction for a stream.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_DIRECTION_OUTPUT}.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param direction {@link #AAUDIO_DIRECTION_OUTPUT} or {@link #AAUDIO_DIRECTION_INPUT}
	*/
	AAudioStreamBuilder_setDirection :: proc(builder: ^AAudioStreamBuilder, direction: AAudioDirection) ---

	/**
	* Set the requested buffer capacity in frames.
	* The final AAudioStream capacity may differ, but will probably be at least this big.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param numFrames the desired buffer capacity in frames or {@link #AAUDIO_UNSPECIFIED}
	*/
	AAudioStreamBuilder_setBufferCapacityInFrames :: proc(builder: ^AAudioStreamBuilder, numFrames: i32) ---

	/**
	* Set the requested performance mode.
	*
	* Supported modes are {@link #AAUDIO_PERFORMANCE_MODE_NONE},
	* {@link #AAUDIO_PERFORMANCE_MODE_POWER_SAVING} * and {@link #AAUDIO_PERFORMANCE_MODE_LOW_LATENCY}.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_PERFORMANCE_MODE_NONE}.
	*
	* You may not get the mode you requested.
	* You can call AAudioStream_getPerformanceMode :: proc()
	* to find out the final mode for the stream.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param mode the desired performance mode, eg. {@link #AAUDIO_PERFORMANCE_MODE_LOW_LATENCY}
	*/
	AAudioStreamBuilder_setPerformanceMode :: proc(builder: ^AAudioStreamBuilder, mode: AAudioPerformanceMode) ---

	/**
	* Set the intended use case for the output stream.
	*
	* The AAudio system will use this information to optimize the
	* behavior of the stream.
	* This could, for example, affect how volume and focus is handled for the stream.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_USAGE_MEDIA}.
	*
	* Available since API level 28.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param usage the desired usage, eg. {@link #AAUDIO_USAGE_GAME}
	*/
	AAudioStreamBuilder_setUsage :: proc(builder: ^AAudioStreamBuilder, usage: AAudioUsage) ---

	/**
	* Set the type of audio data that the output stream will carry.
	*
	* The AAudio system will use this information to optimize the
	* behavior of the stream.
	* This could, for example, affect whether a stream is paused when a notification occurs.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_CONTENT_TYPE_MUSIC}.
	*
	* Available since API level 28.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param contentType the type of audio data, eg. {@link #AAUDIO_CONTENT_TYPE_SPEECH}
	*/
	AAudioStreamBuilder_setContentType :: proc(builder: ^AAudioStreamBuilder, contentType: AAudioContentType) ---

	/**
	* Sets the behavior affecting whether spatialization will be used.
	*
	* The AAudio system will use this information to select whether the stream will go
	* through a spatializer effect or not when the effect is supported and enabled.
	*
	* Available since API level 32.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param spatializationBehavior the desired behavior with regards to spatialization, eg.
	*     {@link #AAUDIO_SPATIALIZATION_BEHAVIOR_AUTO}
	*/
	AAudioStreamBuilder_setSpatializationBehavior :: proc(builder: ^AAudioStreamBuilder, spatializationBehavior: AAudioSpatializationBehavior) ---

	/**
	* Specifies whether the audio data of this output stream has already been processed for
	* spatialization.
	*
	* If the stream has been processed for spatialization, setting this to true will prevent
	* issues such as double-processing on platforms that will spatialize audio data.
	*
	* Available since API level 32.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param isSpatialized true if the content is already processed for binaural or transaural spatial
	*     rendering, false otherwise.
	*/
	AAudioStreamBuilder_setIsContentSpatialized :: proc(builder: ^AAudioStreamBuilder, isSpatialized: bool) ---

	/**
	* Set the input (capture) preset for the stream.
	*
	* The AAudio system will use this information to optimize the
	* behavior of the stream.
	* This could, for example, affect which microphones are used and how the
	* recorded data is processed.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_INPUT_PRESET_VOICE_RECOGNITION}.
	* That is because VOICE_RECOGNITION is the preset with the lowest latency
	* on many platforms.
	*
	* Available since API level 28.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param inputPreset the desired configuration for recording
	*/
	AAudioStreamBuilder_setInputPreset :: proc(builder: ^AAudioStreamBuilder, inputPreset: AAudioInputPreset) ---

	/**
	* Specify whether this stream audio may or may not be captured by other apps or the system.
	*
	* The default is {@link #AAUDIO_ALLOW_CAPTURE_BY_ALL}.
	*
	* Note that an application can also set its global policy, in which case the most restrictive
	* policy is always applied. See
	* <a href="/reference/android/media/AudioManager#setAllowedCapturePolicy :: proc(int)">
	* setAllowedCapturePolicy :: proc(int)</a>
	*
	* Available since API level 29.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param capturePolicy the desired level of opt-out from being captured.
	*/
	AAudioStreamBuilder_setAllowedCapturePolicy :: proc(builder: ^AAudioStreamBuilder, capturePolicy: AAudioAllowedCapturePolicy) ---

	/** Set the requested session ID.
	*
	* The session ID can be used to associate a stream with effects processors.
	* The effects are controlled using the Android AudioEffect Java API.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_SESSION_ID_NONE}.
	*
	* If set to {@link #AAUDIO_SESSION_ID_ALLOCATE} then a session ID will be allocated
	* when the stream is opened.
	*
	* The allocated session ID can be obtained by calling AAudioStream_getSessionId :: proc()
	* and then used with this function when opening another stream.
	* This allows effects to be shared between streams.
	*
	* Session IDs from AAudio can be used with the Android Java APIs and vice versa.
	* So a session ID from an AAudio stream can be passed to Java
	* and effects applied using the Java AudioEffect API.
	*
	* Note that allocating or setting a session ID may result in a stream with higher latency.
	*
	* Allocated session IDs will always be positive and nonzero.
	*
	* Available since API level 28.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param sessionId an allocated sessionID or {@link #AAUDIO_SESSION_ID_ALLOCATE}
	*/
	AAudioStreamBuilder_setSessionId :: proc(builder: ^AAudioStreamBuilder, sessionId: AAudioSessionId) ---


	/** Indicates whether this input stream must be marked as privacy sensitive or not.
	*
	* When true, this input stream is privacy sensitive and any concurrent capture
	* is not permitted.
	*
	* This is off (false) by default except when the input preset is {@link #AAUDIO_INPUT_PRESET_VOICE_COMMUNICATION}
	* or {@link #AAUDIO_INPUT_PRESET_CAMCORDER}.
	*
	* Always takes precedence over default from input preset when set explicitly.
	*
	* Only relevant if the stream direction is {@link #AAUDIO_DIRECTION_INPUT}.
	*
	* Added in API level 30.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param privacySensitive true if capture from this stream must be marked as privacy sensitive,
	* false otherwise.
	*/
	AAudioStreamBuilder_setPrivacySensitive :: proc(builder: ^AAudioStreamBuilder, privacySensitive: bool) ---

	/**
	* Request that AAudio call this functions when the stream is running.
	*
	* Note that when using this callback, the audio data will be passed in or out
	* of the function as an argument.
	* So you cannot call AAudioStream_write :: proc() or AAudioStream_read()
	* on the same stream that has an active data callback.
	*
	* The callback function will start being called after AAudioStream_requestStart :: proc()
	* is called.
	* It will stop being called after AAudioStream_requestPause :: proc() or
	* AAudioStream_requestStop :: proc() is called.
	*
	* This callback function will be called on a real-time thread owned by AAudio.
	* The low latency streams may have callback threads with higher priority than normal streams.
	* See {@link #AAudioStream_dataCallback} for more information.
	*
	* Note that the AAudio callbacks will never be called simultaneously from multiple threads.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param callback pointer to a function that will process audio data.
	* @param userData pointer to an application data structure that will be passed
	*          to the callback functions.
	*/
	AAudioStreamBuilder_setDataCallback :: proc(builder: ^AAudioStreamBuilder, callback: AAudioStream_dataCallback, userData: rawptr) ---

	/**
	* Set the requested data callback buffer size in frames.
	* See {@link #AAudioStream_dataCallback}.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	*
	* For the lowest possible latency, do not call this function. AAudio will then
	* call the dataProc callback function with whatever size is optimal.
	* That size may vary from one callback to another.
	*
	* Only use this function if the application requires a specific number of frames for processing.
	* The application might, for example, be using an FFT that requires
	* a specific power-of-two sized buffer.
	*
	* AAudio may need to add additional buffering in order to adapt between the internal
	* buffer size and the requested buffer size.
	*
	* If you do call this function then the requested size should be less than
	* half the buffer capacity, to allow double buffering.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param numFrames the desired buffer size in frames or {@link #AAUDIO_UNSPECIFIED}
	*/
	AAudioStreamBuilder_setFramesPerDataCallback :: proc(builder: ^AAudioStreamBuilder, numFrames: i32) ---

	/**
	* Request that AAudio call this function if any error occurs or the stream is disconnected.
	*
	* It will be called, for example, if a headset or a USB device is unplugged causing the stream's
	* device to be unavailable or "disconnected".
	* Another possible cause of error would be a timeout or an unanticipated internal error.
	*
	* In response, this function should signal or create another thread to stop
	* and close this stream. The other thread could then reopen a stream on another device.
	* Do not stop or close the stream, or reopen the new stream, directly from this callback.
	*
	* This callback will not be called because of actions by the application, such as stopping
	* or closing a stream.
	*
	* Note that the AAudio callbacks will never be called simultaneously from multiple threads.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param callback pointer to a function that will be called if an error occurs.
	* @param userData pointer to an application data structure that will be passed
	*          to the callback functions.
	*/
	AAudioStreamBuilder_setErrorCallback :: proc(builder: ^AAudioStreamBuilder, callback: AAudioStream_errorCallback, userData: rawptr) ---

	/**
	* Open a stream based on the options in the StreamBuilder.
	*
	* AAudioStream_close :: proc() must be called when finished with the stream to recover
	* the memory and to free the associated resources.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param stream pointer to a variable to receive the new stream reference
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStreamBuilder_openStream :: proc(builder: ^AAudioStreamBuilder, stream: ^^AAudioStream) -> AAudioResult ---

	/**
	* Delete the resources associated with the StreamBuilder.
	*
	* Available since API level 26.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStreamBuilder_delete :: proc(builder: ^AAudioStreamBuilder) -> AAudioResult ---

	/**
	* Set audio channel mask for the stream.
	*
	* The default, if you do not call this function, is {@link #AAUDIO_UNSPECIFIED}.
	* If both channel mask and count are not set, then stereo will then be chosen when the
	* stream is opened.
	* After opening a stream with an unspecified value, the application must query for the
	* actual value, which may vary by device.
	*
	* If an exact value is specified then an opened stream will use that value.
	* If a stream cannot be opened with the specified value then the open will fail.
	*
	* As the corresponding channel count of provided channel mask here may be different
	* from the channel count used in {@link AAudioStreamBuilder_setChannelCount} or
	* {@link AAudioStreamBuilder_setSamplesPerFrame}, the last called function will be
	* respected if this function and {@link AAudioStreamBuilder_setChannelCount} or
	* {@link AAudioStreamBuilder_setSamplesPerFrame} are called.
	*
	* Available since API level 32.
	*
	* @param builder reference provided by AAudio_createStreamBuilder :: proc()
	* @param channelMask Audio channel mask desired.
	*/
	AAudioStreamBuilder_setChannelMask :: proc(builder: ^AAudioStreamBuilder, channelMask: AAudioChannelMask) ---

	// ============================================================
	// Stream Control
	// ============================================================

	/**
	* Free the audio resources associated with a stream created by
	* AAudioStreamBuilder_openStream :: proc().
	* AAudioStream_close :: proc() should be called at some point after calling
	* this function.
	*
	* After this call, the stream will be in {@link #AAUDIO_STREAM_STATE_CLOSING}
	*
	* This function is useful if you want to release the audio resources immediately,
	* but still allow queries to the stream to occur from other threads. This often
	* happens if you are monitoring stream progress from a UI thread.
	*
	* NOTE: This function is only fully implemented for MMAP streams,
	* which are low latency streams supported by some devices.
	* On other "Legacy" streams some audio resources will still be in use
	* and some callbacks may still be in process after this call.
	*
	* Available since API level 30.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_release :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Delete the internal data structures associated with the stream created
	* by AAudioStreamBuilder_openStream :: proc().
	*
	* If AAudioStream_release :: proc() has not been called then it will be called automatically.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_close :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Asynchronously request to start playing the stream. For output streams, one should
	* write to the stream to fill the buffer before starting.
	* Otherwise it will underflow.
	* After this call the state will be in {@link #AAUDIO_STREAM_STATE_STARTING} or
	* {@link #AAUDIO_STREAM_STATE_STARTED}.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_requestStart :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Asynchronous request for the stream to pause.
	* Pausing a stream will freeze the data flow but not flush any buffers.
	* Use AAudioStream_requestStart :: proc() to resume playback after a pause.
	* After this call the state will be in {@link #AAUDIO_STREAM_STATE_PAUSING} or
	* {@link #AAUDIO_STREAM_STATE_PAUSED}.
	*
	* This will return {@link #AAUDIO_ERROR_UNIMPLEMENTED} for input streams.
	* For input streams use AAudioStream_requestStop :: proc().
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_requestPause :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Asynchronous request for the stream to flush.
	* Flushing will discard any pending data.
	* This call only works if the stream is pausing or paused. TODO review
	* Frame counters are not reset by a flush. They may be advanced.
	* After this call the state will be in {@link #AAUDIO_STREAM_STATE_FLUSHING} or
	* {@link #AAUDIO_STREAM_STATE_FLUSHED}.
	*
	* This will return {@link #AAUDIO_ERROR_UNIMPLEMENTED} for input streams.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_requestFlush :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Asynchronous request for the stream to stop.
	* The stream will stop after all of the data currently buffered has been played.
	* After this call the state will be in {@link #AAUDIO_STREAM_STATE_STOPPING} or
	* {@link #AAUDIO_STREAM_STATE_STOPPED}.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_requestStop :: proc(stream: ^AAudioStream) -> AAudioResult ---

	/**
	* Query the current state of the client, eg. {@link #AAUDIO_STREAM_STATE_PAUSING}
	*
	* This function will immediately return the state without updating the state.
	* If you want to update the client state based on the server state then
	* call AAudioStream_waitForStateChange :: proc() with currentState
	* set to {@link #AAUDIO_STREAM_STATE_UNKNOWN} and a zero timeout.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	*/
	AAudioStream_getState :: proc(stream: ^AAudioStream) -> AAudioStreamState ---

	/**
	* Wait until the current state no longer matches the input state.
	*
	* This will update the current client state.
	*
	* <pre><code>
	* AAudioResult result = AAUDIO_OK
	* AAudioStreamState currentState = AAudioStream_getState :: proc(stream)
	* AAudioStreamState inputState = currentState
	* while (result == AAUDIO_OK && currentState != AAUDIO_STREAM_STATE_PAUSED) {
	*     result = AAudioStream_waitForStateChange :: proc(
	*                                   stream, inputState, &currentState, MY_TIMEOUT_NANOS)
	*     inputState = currentState
	* }
	* </code></pre>
	*
	* Available since API level 26.
	*
	* @param stream A reference provided by AAudioStreamBuilder_openStream :: proc()
	* @param inputState The state we want to avoid.
	* @param nextState Pointer to a variable that will be set to the new state.
	* @param timeoutNanoseconds Maximum number of nanoseconds to wait for completion.
	* @return {@link #AAUDIO_OK} or a negative error.
	*/
	AAudioStream_waitForStateChange :: proc(stream: ^AAudioStream, inputState: AAudioStreamState, nextState: ^AAudioStreamState, timeoutNanoseconds: i64) -> AAudioResult ---

	// ============================================================
	// Stream I/O
	// ============================================================

	/**
	* Read data from the stream.
	*
	* The call will wait until the read is complete or until it runs out of time.
	* If timeoutNanos is zero then this call will not wait.
	*
	* Note that timeoutNanoseconds is a relative duration in wall clock time.
	* Time will not stop if the thread is asleep.
	* So it will be implemented using CLOCK_BOOTTIME.
	*
	* This call is "strong non-blocking" unless it has to wait for data.
	*
	* If the call times out then zero or a partial frame count will be returned.
	*
	* Available since API level 26.
	*
	* @param stream A stream created using AAudioStreamBuilder_openStream :: proc().
	* @param buffer The address of the first sample.
	* @param numFrames Number of frames to read. Only complete frames will be written.
	* @param timeoutNanoseconds Maximum number of nanoseconds to wait for completion.
	* @return The number of frames actually read or a negative error.
	*/
	AAudioStream_read :: proc(stream: ^AAudioStream, buffer: rawptr, numFrames: i32, timeoutNanoseconds: i64) -> AAudioResult ---

	/**
	* Write data to the stream.
	*
	* The call will wait until the write is complete or until it runs out of time.
	* If timeoutNanos is zero then this call will not wait.
	*
	* Note that timeoutNanoseconds is a relative duration in wall clock time.
	* Time will not stop if the thread is asleep.
	* So it will be implemented using CLOCK_BOOTTIME.
	*
	* This call is "strong non-blocking" unless it has to wait for room in the buffer.
	*
	* If the call times out then zero or a partial frame count will be returned.
	*
	* Available since API level 26.
	*
	* @param stream A stream created using AAudioStreamBuilder_openStream :: proc().
	* @param buffer The address of the first sample.
	* @param numFrames Number of frames to write. Only complete frames will be written.
	* @param timeoutNanoseconds Maximum number of nanoseconds to wait for completion.
	* @return The number of frames actually written or a negative error.
	*/
	AAudioStream_write :: proc(stream: ^AAudioStream, buffer: rawptr, numFrames: i32, timeoutNanoseconds: i64) -> AAudioResult ---

	// ============================================================
	// Stream - queries
	// ============================================================

	/**
	* This can be used to adjust the latency of the buffer by changing
	* the threshold where blocking will occur.
	* By combining this with AAudioStream_getXRunCount :: proc(), the latency can be tuned
	* at run-time for each device.
	*
	* This cannot be set higher than AAudioStream_getBufferCapacityInFrames :: proc().
	*
	* Note that you will probably not get the exact size you request.
	* You can check the return value or call AAudioStream_getBufferSizeInFrames :: proc()
	* to see what the actual final size is.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @param numFrames requested number of frames that can be filled without blocking
	* @return actual buffer size in frames or a negative error
	*/
	AAudioStream_setBufferSizeInFrames :: proc(stream: ^AAudioStream, numFrames: i32) -> AAudioResult ---

	/**
	* Query the maximum number of frames that can be filled without blocking.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return buffer size in frames.
	*/
	AAudioStream_getBufferSizeInFrames :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Query the number of frames that the application should read or write at
	* one time for optimal performance. It is OK if an application writes
	* a different number of frames. But the buffer size may need to be larger
	* in order to avoid underruns or overruns.
	*
	* Note that this may or may not match the actual device burst size.
	* For some endpoints, the burst size can vary dynamically.
	* But these tend to be devices with high latency.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return burst size
	*/
	AAudioStream_getFramesPerBurst :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Query maximum buffer capacity in frames.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return  buffer capacity in frames
	*/
	AAudioStream_getBufferCapacityInFrames :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Query the size of the buffer that will be passed to the dataProc callback
	* in the numFrames parameter.
	*
	* This call can be used if the application needs to know the value of numFrames before
	* the stream is started. This is not normally necessary.
	*
	* If a specific size was requested by calling
	* AAudioStreamBuilder_setFramesPerDataCallback :: proc() then this will be the same size.
	*
	* If AAudioStreamBuilder_setFramesPerDataCallback :: proc() was not called then this will
	* return the size chosen by AAudio, or {@link #AAUDIO_UNSPECIFIED}.
	*
	* {@link #AAUDIO_UNSPECIFIED} indicates that the callback buffer size for this stream
	* may vary from one dataProc callback to the next.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return callback buffer size in frames or {@link #AAUDIO_UNSPECIFIED}
	*/
	AAudioStream_getFramesPerDataCallback :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* An XRun is an Underrun or an Overrun.
	* During playing, an underrun will occur if the stream is not written in time
	* and the system runs out of valid data.
	* During recording, an overrun will occur if the stream is not read in time
	* and there is no place to put the incoming data so it is discarded.
	*
	* An underrun or overrun can cause an audible "pop" or "glitch".
	*
	* Note that some INPUT devices may not support this function.
	* In that case a 0 will always be returned.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return the underrun or overrun count
	*/
	AAudioStream_getXRunCount :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual sample rate
	*/
	AAudioStream_getSampleRate :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* A stream has one or more channels of data.
	* A frame will contain one sample for each channel.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual number of channels
	*/
	AAudioStream_getChannelCount :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Identical to AAudioStream_getChannelCount :: proc().
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual number of samples frame
	*/
	AAudioStream_getSamplesPerFrame :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual device ID
	*/
	AAudioStream_getDeviceId :: proc(stream: ^AAudioStream) -> i32 ---

	/**
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual data format
	*/
	AAudioStream_getFormat :: proc(stream: ^AAudioStream) -> AAudioFormat ---

	/**
	* Provide actual sharing mode.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return  actual sharing mode
	*/
	AAudioStream_getSharingMode :: proc(stream: ^AAudioStream) -> AAudioSharingMode ---

	/**
	* Get the performance mode used by the stream.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	*/
	AAudioStream_getPerformanceMode :: proc(stream: ^AAudioStream) -> AAudioPerformanceMode ---

	/**
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return direction
	*/
	AAudioStream_getDirection :: proc(stream: ^AAudioStream) -> AAudioDirection ---

	/**
	* Passes back the number of frames that have been written since the stream was created.
	* For an output stream, this will be advanced by the application calling write :: proc()
	* or by a data callback.
	* For an input stream, this will be advanced by the endpoint.
	*
	* The frame position is monotonically increasing.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return frames written
	*/
	AAudioStream_getFramesWritten :: proc(stream: ^AAudioStream) -> i64 ---

	/**
	* Passes back the number of frames that have been read since the stream was created.
	* For an output stream, this will be advanced by the endpoint.
	* For an input stream, this will be advanced by the application calling read :: proc()
	* or by a data callback.
	*
	* The frame position is monotonically increasing.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return frames read
	*/
	AAudioStream_getFramesRead :: proc(stream: ^AAudioStream) -> i64 ---

	/**
	* Passes back the session ID associated with this stream.
	*
	* The session ID can be used to associate a stream with effects processors.
	* The effects are controlled using the Android AudioEffect Java API.
	*
	* If AAudioStreamBuilder_setSessionId :: proc() was
	* called with {@link #AAUDIO_SESSION_ID_ALLOCATE}
	* then a new session ID should be allocated once when the stream is opened.
	*
	* If AAudioStreamBuilder_setSessionId :: proc() was called with a previously allocated
	* session ID then that value should be returned.
	*
	* If AAudioStreamBuilder_setSessionId :: proc() was not called then this function should
	* return {@link #AAUDIO_SESSION_ID_NONE}.
	*
	* The sessionID for a stream should not change once the stream has been opened.
	*
	* Available since API level 28.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return session ID or {@link #AAUDIO_SESSION_ID_NONE}
	*/
	AAudioStream_getSessionId :: proc(stream: ^AAudioStream) -> AAudioSessionId ---

	/**
	* Passes back the time at which a particular frame was presented.
	* This can be used to synchronize audio with video or MIDI.
	* It can also be used to align a recorded stream with a playback stream.
	*
	* Timestamps are only valid when the stream is in {@link #AAUDIO_STREAM_STATE_STARTED}.
	* {@link #AAUDIO_ERROR_INVALID_STATE} will be returned if the stream is not started.
	* Note that because requestStart :: proc() is asynchronous, timestamps will not be valid until
	* a short time after calling requestStart :: proc().
	* So {@link #AAUDIO_ERROR_INVALID_STATE} should not be considered a fatal error.
	* Just try calling again later.
	*
	* If an error occurs, then the position and time will not be modified.
	*
	* The position and time passed back are monotonically increasing.
	*
	* Available since API level 26.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @param clockid CLOCK_MONOTONIC or CLOCK_BOOTTIME
	* @param framePosition pointer to a variable to receive the position
	* @param timeNanoseconds pointer to a variable to receive the time
	* @return {@link #AAUDIO_OK} or a negative error
	*/
	AAudioStream_getTimestamp :: proc(stream: ^AAudioStream, clockid: clockid_t, framePosition: ^i64, timeNanoseconds: ^i64) -> AAudioResult ---

	/**
	* Return the use case for the stream.
	*
	* Available since API level 28.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return frames read
	*/
	AAudioStream_getUsage :: proc(stream: ^AAudioStream) -> AAudioUsage ---

	/**
	* Return the content type for the stream.
	*
	* Available since API level 28.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return content type, for example {@link #AAUDIO_CONTENT_TYPE_MUSIC}
	*/
	AAudioStream_getContentType :: proc(stream: ^AAudioStream) -> AAudioContentType ---

	/**
	* Return the spatialization behavior for the stream.
	*
	* If none was explicitly set, it will return the default
	* {@link #AAUDIO_SPATIALIZATION_BEHAVIOR_AUTO} behavior.
	*
	* Available since API level 32.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return spatialization behavior, for example {@link #AAUDIO_SPATIALIZATION_BEHAVIOR_AUTO}
	*/
	AAudioStream_getSpatializationBehavior :: proc(stream: ^AAudioStream) -> AAudioSpatializationBehavior ---

	/**
	* Return whether the content of the stream is spatialized.
	*
	* Available since API level 32.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return true if the content is spatialized
	*/
	AAudioStream_isContentSpatialized :: proc(stream: ^AAudioStream) -> bool ---


	/**
	* Return the input preset for the stream.
	*
	* Available since API level 28.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return input preset, for example {@link #AAUDIO_INPUT_PRESET_CAMCORDER}
	*/
	AAudioStream_getInputPreset :: proc(stream: ^AAudioStream) -> AAudioInputPreset ---

	/**
	* Return the policy that determines whether the audio may or may not be captured
	* by other apps or the system.
	*
	* Available since API level 29.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return the allowed capture policy, for example {@link #AAUDIO_ALLOW_CAPTURE_BY_ALL}
	*/
	AAudioStream_getAllowedCapturePolicy :: proc(stream: ^AAudioStream) -> AAudioAllowedCapturePolicy ---


	/**
	* Return whether this input stream is marked as privacy sensitive or not.
	*
	* See {@link #AAudioStreamBuilder_setPrivacySensitive :: proc()}.
	*
	* Added in API level 30.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return true if privacy sensitive, false otherwise
	*/
	AAudioStream_isPrivacySensitive :: proc(stream: ^AAudioStream) -> bool ---

	/**
	* Return the channel mask for the stream. This will be the mask set using
	* {@link #AAudioStreamBuilder_setChannelMask}, or {@link #AAUDIO_UNSPECIFIED} otherwise.
	*
	* Available since API level 32.
	*
	* @param stream reference provided by AAudioStreamBuilder_openStream :: proc()
	* @return actual channel mask
	*/
	AAudioStream_getChannelMask :: proc(stream: ^AAudioStream) -> AAudioChannelMask ---
}
