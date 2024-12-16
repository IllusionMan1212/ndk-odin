package android

foreign import android "system:android"

/**
 * An opaque type representing a handle to a performance hint manager.
 * It must be released after use.
 *
 * <p>To use:<ul>
 *    <li>Obtain the performance hint manager instance by calling
 *        {@link APerformanceHint_getManager} function.</li>
 *    <li>Create an {@link APerformanceHintSession} with
 *        {@link APerformanceHint_createSession}.</li>
 *    <li>Get the preferred update rate in nanoseconds with
 *        {@link APerformanceHint_getPreferredUpdateRateNanos}.</li>
 */
APerformanceHintManager :: struct{}

/**
 * An opaque type representing a handle to a performance hint session.
 * A session can only be acquired from a {@link APerformanceHintManager}
 * with {@link APerformanceHint_getPreferredUpdateRateNanos}. It must be
 * freed with {@link APerformanceHint_closeSession} after use.
 *
 * A Session represents a group of threads with an inter-related workload such that hints for
 * their performance should be considered as a unit. The threads in a given session should be
 * long-life and not created or destroyed dynamically.
 *
 * <p>Each session is expected to have a periodic workload with a target duration for each
 * cycle. The cycle duration is likely greater than the target work duration to allow other
 * parts of the pipeline to run within the available budget. For example, a renderer thread may
 * work at 60hz in order to produce frames at the display's frame but have a target work
 * duration of only 6ms.</p>
 *
 * <p>After each cycle of work, the client is expected to use
 * {@link APerformanceHint_reportActualWorkDuration} to report the actual time taken to
 * complete.</p>
 *
 * <p>To use:<ul>
 *    <li>Update a sessions target duration for each cycle of work
 *        with  {@link APerformanceHint_updateTargetWorkDuration}.</li>
 *    <li>Report the actual duration for the last cycle of work with
 *        {@link APerformanceHint_reportActualWorkDuration}.</li>
 *    <li>Release the session instance with
 *        {@link APerformanceHint_closeSession}.</li></ul></p>
 */
APerformanceHintSession :: struct{}

foreign android {
	/**
	  * Acquire an instance of the performance hint manager.
	  *
	  * Available since API level 33.
	  *
	  * @return manager instance on success, nullptr on failure.
	  */
	APerformanceHint_getManager :: proc() -> ^APerformanceHintManager ---

	/**
	* Creates a session for the given set of threads and sets their initial target work
	* duration.
	*
	* Available since API level 33.
	*
	* @param manager The performance hint manager instance.
	* @param threadIds The list of threads to be associated with this session. They must be part of
	*     this app's thread group.
	* @param size the size of threadIds.
	* @param initialTargetWorkDurationNanos The desired duration in nanoseconds for the new session.
	*     This must be positive.
	* @return manager instance on success, nullptr on failure.
	*/
	APerformanceHint_createSession :: proc(manager: ^APerformanceHintManager, threadIds: [^]i32, size: uint, initialTargetWorkDurationNanos: i64) -> ^APerformanceHintSession ---

	/**
	* Get preferred update rate information for this device.
	*
	* Available since API level 33.
	*
	* @param manager The performance hint manager instance.
	* @return the preferred update rate supported by device software.
	*/
	APerformanceHint_getPreferredUpdateRateNanos :: proc(manager: ^APerformanceHintManager) -> i64 ---

	/**
	* Updates this session's target duration for each cycle of work.
	*
	* Available since API level 33.
	*
	* @param session The performance hint session instance to update.
	* @param targetDurationNanos the new desired duration in nanoseconds. This must be positive.
	* @return 0 on success
	*         EINVAL if targetDurationNanos is not positive.
	*         EPIPE if communication with the system service has failed.
	*/
	APerformanceHint_updateTargetWorkDuration :: proc(session: ^APerformanceHintSession, targetDurationNanos: i64) -> i32 ---

	/**
	* Reports the actual duration for the last cycle of work.
	*
	* <p>The system will attempt to adjust the core placement of the threads within the thread
	* group and/or the frequency of the core on which they are run to bring the actual duration
	* close to the target duration.</p>
	*
	* Available since API level 33.
	*
	* @param session The performance hint session instance to update.
	* @param actualDurationNanos how long the thread group took to complete its last task in
	*     nanoseconds. This must be positive.
	* @return 0 on success
	*         EINVAL if actualDurationNanos is not positive.
	*         EPIPE if communication with the system service has failed.
	*/
	APerformanceHint_reportActualWorkDuration :: proc(session: ^APerformanceHintSession, actualDurationNanos: i64) -> i32 ---

	/**
	* Release the performance hint manager pointer acquired via
	* {@link APerformanceHint_createSession}.
	*
	* Available since API level 33.
	*
	* @param session The performance hint session instance to release.
	*/
	APerformanceHint_closeSession :: proc(session: ^APerformanceHintSession) ---
}

