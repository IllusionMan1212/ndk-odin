package mediandk

import "../"

foreign import mediandk "system:mediandk"

SeekMode :: enum {
	PREVIOUS_SYNC,
	NEXT_SYNC,
	CLOSEST_SYNC
}

SampleFlags :: enum u32 {
	SYNC = 1,
	ENCRYPTED = 2,
}

AMediaExtractor :: struct{}

/**
* mapping of crypto scheme uuid to the scheme specific data for that scheme
*/
PsshEntry :: struct {
	uuid: AMediaUUID,
	datalen: uint,
	data: rawptr,
}

/**
* list of crypto schemes and their data
*/
PsshInfo :: struct {
	numentries: uint,
	entries: [0]PsshEntry,
}

foreign mediandk {
	/**
	 * Create new media extractor.
	 *
	 * Available since API level 21.
	 */
	AMediaExtractor_new :: proc() -> ^AMediaExtractor ---

	/**
	* Delete a previously created media extractor.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_delete :: proc(extractor: ^AMediaExtractor) -> media_status_t ---

	/**
	* Set the file descriptor from which the extractor will read.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_setDataSourceFd :: proc(extractor: ^AMediaExtractor, fd: i32, offset: android.off64_t, length: android.off64_t) -> media_status_t ---

	/**
	* Set the URI from which the extractor will read.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_setDataSource :: proc(extractor: ^AMediaExtractor, location: cstring) -> media_status_t ---

	/**
	* Set the custom data source implementation from which the extractor will read.
	*
	* Available since API level 28.
	*/
	AMediaExtractor_setDataSourceCustom :: proc(extractor: ^AMediaExtractor, src: ^AMediaDataSource) -> media_status_t ---

	/**
	* Return the number of tracks in the previously specified media file
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getTrackCount :: proc(extractor: ^AMediaExtractor) -> uint ---

	/**
	* Return the format of the specified track. The caller must free the returned format
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getTrackFormat :: proc(extractor: ^AMediaExtractor, idx: uint) -> ^AMediaFormat ---

	/**
	* Select the specified track. Subsequent calls to readSampleData, getSampleTrackIndex and
	* getSampleTime only retrieve information for the subset of tracks selected.
	* Selecting the same track multiple times has no effect, the track is
	* only selected once.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_selectTrack :: proc(extractor: ^AMediaExtractor, idx: uint) -> media_status_t ---

	/**
	* Unselect the specified track. Subsequent calls to readSampleData, getSampleTrackIndex and
	* getSampleTime only retrieve information for the subset of tracks selected.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_unselectTrack :: proc(extractor: ^AMediaExtractor, idx: uint) -> media_status_t ---

	/**
	* Read the current sample.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_readSampleData :: proc(extractor: ^AMediaExtractor, buffer: [^]u8, capacity: uint) -> int ---

	/**
	* Read the current sample's flags.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getSampleFlags :: proc(extractor: ^AMediaExtractor) -> SampleFlags ---

	/**
	* Returns the track index the current sample originates from (or -1
	* if no more samples are available)
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getSampleTrackIndex :: proc(extractor: ^AMediaExtractor) -> i32 ---

	/**
	* Returns the current sample's presentation time in microseconds.
	* or -1 if no more samples are available.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getSampleTime :: proc(extractor: ^AMediaExtractor) -> i64 ---

	/**
	* Advance to the next sample. Returns false if no more sample data
	* is available (end of stream).
	*
	* Available since API level 21.
	*/
	AMediaExtractor_advance :: proc(extractor: ^AMediaExtractor) -> bool ---


	/**
	* Available since API level 21.
	*/
	AMediaExtractor_seekTo :: proc(extractor: ^AMediaExtractor, seekPosUs: i64, mode: SeekMode) -> media_status_t ---

	/**
	* Get the PSSH info if present.
	*
	* Available since API level 21.
	*/
	AMediaExtractor_getPsshInfo :: proc(extractor: ^AMediaExtractor) -> ^PsshInfo ---

	/**
	* Available since API level 21.
	*/
	AMediaExtractor_getSampleCryptoInfo :: proc(extractor: ^AMediaExtractor) -> ^AMediaCodecCryptoInfo ---

	/**
	* Returns the format of the extractor. The caller must free the returned format
	* using AMediaFormat_delete(format).
	*
	* This function will always return a format however, the format could be empty
	* (no key-value pairs) if the media container does not provide format information.
	*
	* Available since API level 28.
	*/
	AMediaExtractor_getFileFormat :: proc(extractor: ^AMediaExtractor) -> ^AMediaFormat ---

	/**
	* Returns the size of the current sample in bytes, or -1 when no samples are
	* available (end of stream). This API can be used in in conjunction with
	* AMediaExtractor_readSampleData:
	*
	* ssize_t sampleSize = AMediaExtractor_getSampleSize(ex)
	* uint8_t *buf = new uint8_t[sampleSize]
	* AMediaExtractor_readSampleData(ex, buf, sampleSize)
	*
	* Available since API level 28.
	*/
	AMediaExtractor_getSampleSize :: proc(extractor: ^AMediaExtractor) -> int ---

	/**
	* Returns the duration of cached media samples downloaded from a network data source
	* (AMediaExtractor_setDataSource with a "http(s)" URI) in microseconds.
	*
	* This information is calculated using total bitrate if total bitrate is not in the
	* media container it is calculated using total duration and file size.
	*
	* Returns -1 when the extractor is not reading from a network data source, or when the
	* cached duration cannot be calculated (bitrate, duration, and file size information
	* not available).
	*
	* Available since API level 28.
	*/
	AMediaExtractor_getCachedDuration :: proc(extractor: ^AMediaExtractor) -> i64 ---

	/**
	* Read the current sample's metadata format into |fmt|. Examples of sample metadata are
	* SEI (supplemental enhancement information) and MPEG user data, both of which can embed
	* closed-caption data.
	*
	* Returns AMEDIA_OK on success or AMEDIA_ERROR_* to indicate failure reason.
	* Existing key-value pairs in |fmt| would be removed if this API returns AMEDIA_OK.
	* The contents of |fmt| is undefined if this API returns AMEDIA_ERROR_*.
	*
	* Available since API level 28.
	*/
	AMediaExtractor_getSampleFormat :: proc(ex: ^AMediaExtractor, fmt: ^AMediaFormat) -> media_status_t ---
}
