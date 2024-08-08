//+build android
package mediandk

foreign import mediandk "system:mediandk"

OutputFormat :: enum i32 {
    MPEG_4 = 0,
    WEBM   = 1,
    THREE_GPP   = 2,
}

AppendMode :: enum i32 {
    /* Last group of pictures(GOP) of video track can be incomplete, so it would be safe to
     * scrap that and rewrite.  If both audio and video tracks are present in a file, then
     * samples of audio track after last GOP of video would be scrapped too.
     * If only audio track is present, then no sample would be discarded.
     */
    IGNORE_LAST_VIDEO_GOP = 0,
    // Keep all existing samples as it is and append new samples after that only.
    TO_EXISTING_DATA = 1,
}

AMediaMuxer :: struct{}

foreign mediandk {
	/**
	 * Create new media muxer.
	 *
	 * Available since API level 21.
	 */
	AMediaMuxer_new :: proc(fd: i32, format: OutputFormat) -> ^AMediaMuxer ---

	/**
	* Delete a previously created media muxer.
	*
	* Available since API level 21.
	*/
	AMediaMuxer_delete :: proc(muxer: ^AMediaMuxer) -> media_status_t ---

	/**
	* Set and store the geodata (latitude and longitude) in the output file.
	* This method should be called before AMediaMuxer_start. The geodata is stored
	* in udta box if the output format is AMEDIAMUXER_OUTPUT_FORMAT_MPEG_4, and is
	* ignored for other output formats.
	* The geodata is stored according to ISO-6709 standard.
	*
	* Both values are specified in degrees.
	* Latitude must be in the range [-90, 90].
	* Longitude must be in the range [-180, 180].
	*
	* Available since API level 21.
	*/
	AMediaMuxer_setLocation :: proc(muxer: ^AMediaMuxer, latitude: f32, longitude: f32) -> media_status_t ---

	/**
	* Sets the orientation hint for output video playback.
	* This method should be called before AMediaMuxer_start. Calling this
	* method will not rotate the video frame when muxer is generating the file,
	* but add a composition matrix containing the rotation angle in the output
	* video if the output format is AMEDIAMUXER_OUTPUT_FORMAT_MPEG_4, so that a
	* video player can choose the proper orientation for playback.
	* Note that some video players may choose to ignore the composition matrix
	* during playback.
	* The angle is specified in degrees, clockwise.
	* The supported angles are 0, 90, 180, and 270 degrees.
	*
	* Available since API level 21.
	*/
	AMediaMuxer_setOrientationHint :: proc(muxer: ^AMediaMuxer, degrees: i32) -> media_status_t ---

	/**
	* Adds a track with the specified format.
	* Returns the index of the new track or a negative value in case of failure,
	* which can be interpreted as a media_status_t.
	*
	* Available since API level 21.
	*/
	AMediaMuxer_addTrack :: proc(muxer: ^AMediaMuxer, format: ^AMediaFormat) -> int ---

	/**
	* Start the muxer. Should be called after AMediaMuxer_addTrack and
	* before AMediaMuxer_writeSampleData.
	*
	* Available since API level 21.
	*/
	AMediaMuxer_start :: proc(muxer: ^AMediaMuxer) -> media_status_t ---

	/**
	* Stops the muxer.
	* Once the muxer stops, it can not be restarted.
	*
	* Available since API level 21.
	*/
	AMediaMuxer_stop :: proc(muxer: ^AMediaMuxer) -> media_status_t ---

	/**
	* Writes an encoded sample into the muxer.
	* The application needs to make sure that the samples are written into
	* the right tracks. Also, it needs to make sure the samples for each track
	* are written in chronological order (e.g. in the order they are provided
	* by the encoder.)
	*
	* Available since API level 21.
	*/
	AMediaMuxer_writeSampleData :: proc(muxer: ^AMediaMuxer, trackIdx: uint, data: [^]u8, info: ^AMediaCodecBufferInfo) -> media_status_t ---

	/**
	* Creates a new media muxer for appending data to an existing MPEG4 file.
	* This is a synchronous API call and could take a while to return if the existing file is large.
	* Only works for MPEG4 files matching one of the following characteristics:
	* <ul>
	*    <li>a single audio track.</li>
	*    <li>a single video track.</li>
	*    <li>a single audio and a single video track.</li>
	* </ul>
	* @param fd Must be opened with read and write permission. Does not take ownership of
	* this fd i.e., caller is responsible for closing fd.
	* @param mode Specifies how data will be appended the AppendMode enum describes
	*             the possible methods for appending..
	* @return Pointer to AMediaMuxer if the file(fd) has tracks already, otherwise, nullptr.
	* {@link AMediaMuxer_delete} should be used to free the returned pointer.
	*
	* Available since API level 31.
	*/
	AMediaMuxer_append :: proc(fd: i32, mode: AppendMode) -> ^AMediaMuxer ---

	/**
	* Returns the number of tracks added in the file passed to {@link AMediaMuxer_new} or
	* the number of existing tracks in the file passed to {@link AMediaMuxer_append}.
	* Should be called in INITIALIZED or STARTED state, otherwise returns -1.
	*
	* Available since API level 31.
	*/
	AMediaMuxer_getTrackCount :: proc(muxer: ^AMediaMuxer) -> int ---

	/**
	* Returns AMediaFormat of the added track with index idx in the file passed to
	* {@link AMediaMuxer_new} or the AMediaFormat of the existing track with index idx
	* in the file passed to {@link AMediaMuxer_append}.
	* Should be called in INITIALIZED or STARTED state, otherwise returns nullptr.
	* {@link AMediaFormat_delete} should be used to free the returned pointer.
	*
	* Available since API level 31.
	*/
	AMediaMuxer_getTrackFormat :: proc(muxer: ^AMediaMuxer, idx: uint) -> ^AMediaFormat ---
}
