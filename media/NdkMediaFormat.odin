package mediandk

foreign import mediandk "system:mediandk"

AMediaFormat :: struct{}

AMEDIAFORMAT_KEY_AAC_DRC_ATTENUATION_FACTOR: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_DRC_BOOST_FACTOR: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_DRC_HEAVY_COMPRESSION: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_DRC_TARGET_REFERENCE_LEVEL: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_ENCODED_TARGET_LEVEL: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_MAX_OUTPUT_CHANNEL_COUNT: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AAC_PROFILE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_AAC_SBR_MODE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_AUDIO_SESSION_ID: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_BITRATE_MODE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_BIT_RATE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_CAPTURE_RATE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_CHANNEL_COUNT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_CHANNEL_MASK: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_COLOR_FORMAT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_COLOR_RANGE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_COLOR_STANDARD: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_COLOR_TRANSFER: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_COMPLEXITY: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_CSD: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_CSD_0: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_CSD_1: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_CSD_2: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_DISPLAY_CROP: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_DISPLAY_HEIGHT: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_DISPLAY_WIDTH: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_DURATION: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_FLAC_COMPRESSION_LEVEL: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_FRAME_RATE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_GRID_COLUMNS: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_GRID_ROWS: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_HDR_STATIC_INFO: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_HEIGHT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_INTRA_REFRESH_PERIOD: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_IS_ADTS: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_IS_AUTOSELECT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_IS_DEFAULT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_IS_FORCED_SUBTITLE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_I_FRAME_INTERVAL: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_LANGUAGE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_LATENCY: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_LEVEL: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_MAX_HEIGHT: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_MAX_INPUT_SIZE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_MAX_WIDTH: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_MIME: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_MPEG_USER_DATA: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_OPERATING_RATE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_PCM_ENCODING: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_PRIORITY: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_PROFILE: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_PUSH_BLANK_BUFFERS_ON_STOP: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_REPEAT_PREVIOUS_FRAME_AFTER: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_ROTATION: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_SAMPLE_RATE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_SEI: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_SLICE_HEIGHT: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_STRIDE: cstring        //__INTRODUCED_IN(21)
AMEDIAFORMAT_KEY_TEMPORAL_LAYER_ID: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TEMPORAL_LAYERING: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TILE_HEIGHT: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TILE_WIDTH: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TIME_US: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TRACK_ID: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_TRACK_INDEX: cstring        //__INTRODUCED_IN(28)
AMEDIAFORMAT_KEY_WIDTH: cstring        //__INTRODUCED_IN(21)


AMEDIAFORMAT_KEY_ALBUM: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ALBUMART: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ALBUMARTIST: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ARTIST: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_AUDIO_PRESENTATION_INFO: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_AUDIO_PRESENTATION_PRESENTATION_ID: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_AUDIO_PRESENTATION_PROGRAM_ID: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_AUTHOR: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_BITS_PER_SAMPLE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CDTRACKNUMBER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_COMPILATION: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_COMPOSER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CREATE_INPUT_SURFACE_SUSPENDED: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_DEFAULT_IV_SIZE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_ENCRYPTED_BYTE_BLOCK: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_ENCRYPTED_SIZES: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_IV: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_KEY: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_MODE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_PLAIN_SIZES: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CRYPTO_SKIP_BYTE_BLOCK: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CSD_AVC: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_CSD_HEVC: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_D263: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_DATE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_DISCNUMBER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ENCODER_DELAY: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ENCODER_PADDING: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ESDS: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_EXIF_OFFSET: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_EXIF_SIZE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_FRAME_COUNT: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_GENRE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_HAPTIC_CHANNEL_COUNT: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_ICC_PROFILE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_IS_SYNC_FRAME: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_LOCATION: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_LOOP: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_LYRICIST: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_MANUFACTURER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_MAX_BIT_RATE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_MAX_FPS_TO_ENCODER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_MAX_PTS_GAP_TO_ENCODER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_MPEG2_STREAM_HEADER: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_PCM_BIG_ENDIAN: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_PSSH: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_SAR_HEIGHT: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_SAR_WIDTH: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_TARGET_TIME: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_TEMPORAL_LAYER_COUNT: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_TEXT_FORMAT_DATA: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_THUMBNAIL_CSD_HEVC: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_THUMBNAIL_HEIGHT: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_THUMBNAIL_TIME: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_THUMBNAIL_WIDTH: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_TITLE: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_VALID_SAMPLES: cstring        //__INTRODUCED_IN(29)
AMEDIAFORMAT_KEY_YEAR: cstring        //__INTRODUCED_IN(29)

/**
 * An optional key describing the low latency decoding mode. This is an optional parameter
 * that applies only to decoders. If enabled, the decoder doesn't hold input and output
 * data more than required by the codec standards.
 * The associated value is an integer (0 or 1): 1 when low-latency decoding is enabled,
 * 0 otherwise. The default value is 0.
 *
 * Available since API level 30.
 */
AMEDIAFORMAT_KEY_LOW_LATENCY: cstring        //__INTRODUCED_IN(30)

AMEDIAFORMAT_KEY_HDR10_PLUS_INFO: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_SLOW_MOTION_MARKERS: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_THUMBNAIL_CSD_AV1C: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_XMP_OFFSET: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_XMP_SIZE: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_SAMPLE_FILE_OFFSET: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_LAST_SAMPLE_INDEX_IN_CHUNK: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_KEY_SAMPLE_TIME_BEFORE_APPEND: cstring        //__INTRODUCED_IN(31)

AMEDIAFORMAT_KEY_PICTURE_TYPE: cstring        //__INTRODUCED_IN(33)
AMEDIAFORMAT_KEY_VIDEO_ENCODING_STATISTICS_LEVEL: cstring        //__INTRODUCED_IN(33)
AMEDIAFORMAT_KEY_VIDEO_QP_AVERAGE: cstring        //__INTRODUCED_IN(33)

AMEDIAFORMAT_VIDEO_QP_B_MAX: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_B_MIN: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_I_MAX: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_I_MIN: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_MAX: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_MIN: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_P_MAX: cstring        //__INTRODUCED_IN(31)
AMEDIAFORMAT_VIDEO_QP_P_MIN: cstring        //__INTRODUCED_IN(31)

/**
 * MPEG-H audio profile and level compatibility.
 *
 * See FDAmd_2 of ISO_IEC_23008-3;2019 MHAProfileAndLevelCompatibilitySetBox.
 *
 * Available since API level 32.
 */
AMEDIAFORMAT_KEY_MPEGH_COMPATIBLE_SETS: cstring        //__INTRODUCED_IN(32)

/**
 * MPEG-H audio profile level indication.
 *
 * See ISO_IEC_23008-3;2019 MHADecoderConfigurationRecord mpegh3daProfileLevelIndication.
 *
 * Available since API level 32.
 */
AMEDIAFORMAT_KEY_MPEGH_PROFILE_LEVEL_INDICATION: cstring        //__INTRODUCED_IN(32)

/**
 * MPEG-H audio reference channel layout.
 *
 * See ISO_IEC_23008-3;2019 MHADecoderConfigurationRecord referenceChannelLayout
 * and ISO_IEC_23001‐8 ChannelConfiguration value.
 *
 * Available since API level 32.
 */
AMEDIAFORMAT_KEY_MPEGH_REFERENCE_CHANNEL_LAYOUT: cstring        //__INTRODUCED_IN(32)

foreign mediandk {
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_new :: proc() -> ^AMediaFormat ---

	/**
	 * Available since API level 21.
	 */
	AMediaFormat_delete :: proc(format: ^AMediaFormat) -> media_status_t ---

	/**
	 * Human readable representation of the format. The returned string is owned by the format,
	 * and remains valid until the next call to toString, or until the format is deleted.
	 *
	 * Available since API level 21.
	 */
	AMediaFormat_toString :: proc(format: ^AMediaFormat) -> cstring ---

	/**
	 * Available since API level 21.
	 */
	AMediaFormat_getInt32 :: proc(format: ^AMediaFormat, name: cstring, out: ^i32) -> bool ---
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_getInt64 :: proc(format: ^AMediaFormat, name: cstring, out: ^i64) -> bool ---
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_getFloat :: proc(format: ^AMediaFormat, name: cstring, out: ^f32) -> bool ---
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_getSize :: proc(format: ^AMediaFormat, name: cstring, out: ^uint) -> bool ---
	/**
	 * The returned data is owned by the format and remains valid as long as the named entry
	 * is part of the format.
	 *
	 * Available since API level 21.
	 */
	AMediaFormat_getBuffer :: proc(format: ^AMediaFormat, name: cstring, data: ^rawptr, size: ^uint) -> bool ---
	/**
	 * The returned string is owned by the format, and remains valid until the next call to getString,
	 * or until the format is deleted.
	 *
	 * Available since API level 21.
	 */
	AMediaFormat_getString :: proc(format: ^AMediaFormat, name: cstring, out: ^cstring) -> bool ---

	/**
	 * Available since API level 21.
	 */
	AMediaFormat_setInt32 :: proc(format: ^AMediaFormat, name: cstring, value: i32) ---
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_setInt64 :: proc(format: ^AMediaFormat, name: cstring, value: i64) ---
	/**
	 * Available since API level 21.
	 */
	AMediaFormat_setFloat :: proc(format: ^AMediaFormat, name: cstring, value: f32) ---
	/**
	 * The provided string is copied into the format.
	 *
	 * Available since API level 21.
	 */
	AMediaFormat_setString :: proc(format: ^AMediaFormat, name: cstring, value: cstring) ---
	/**
	 * The provided data is copied into the format.
	 *
	 * Available since API level 21.
	 */
	AMediaFormat_setBuffer :: proc(format: ^AMediaFormat, name: cstring, data: rawptr, size: uint) ---

	/**
	 * Available since API level 28.
	 */
	AMediaFormat_getDouble :: proc(format: ^AMediaFormat, name: cstring, out: ^f64) -> bool ---
	/**
	 * Available since API level 28.
	 */
	AMediaFormat_getRect :: proc(format: ^AMediaFormat, name: cstring, left: ^i32, top: ^i32, right: ^i32, bottom: ^i32) -> bool ---

	/**
	 * Available since API level 28.
	 */
	AMediaFormat_setDouble :: proc(format: ^AMediaFormat, name: cstring, value: f64) ---
	/**
	 * Available since API level 28.
	 */
	AMediaFormat_setSize :: proc(format: ^AMediaFormat, name: cstring, value: uint) ---
	/**
	 * Available since API level 28.
	 */
	AMediaFormat_setRect :: proc(format: ^AMediaFormat, name: cstring, left: i32, top: i32, right: i32, bottom: i32) ---

	/**
	 * Remove all key/value pairs from the given AMediaFormat.
	 *
	 * Available since API level 29.
	 */
	AMediaFormat_clear :: proc(format: ^AMediaFormat) ---

	/**
	 * Copy one AMediaFormat to another.
	 *
	 * Available since API level 29.
	 */
	AMediaFormat_copy :: proc(to: ^AMediaFormat, from: ^AMediaFormat) -> media_status_t ---
}
