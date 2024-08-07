//+build android
package android

foreign import android "system:android"

foreign android {
	/**
	 * Returns true if tracing is enabled. Use this to avoid expensive computation only necessary
	 * when tracing is enabled.
	 *
	 * Available since API level 23.
	 */
	ATrace_isEnabled :: proc() -> bool ---

	/**
	 * Writes a tracing message to indicate that the given section of code has begun. This call must be
	 * followed by a corresponding call to {@link ATrace_endSection} on the same thread.
	 *
	 * Note: At this time the vertical bar character '|' and newline character '\\n' are used internally
	 * by the tracing mechanism. If \p sectionName contains these characters they will be replaced with a
	 * space character in the trace.
	 *
	 * Available since API level 23.
	 */
	ATrace_beginSection :: proc(sectionName: cstring) ---

	/**
	 * Writes a tracing message to indicate that a given section of code has ended. This call must be
	 * preceeded by a corresponding call to {@link ATrace_beginSection} on the same thread. Calling this method
	 * will mark the end of the most recently begun section of code, so care must be taken to ensure
	 * that {@link ATrace_beginSection}/{@link ATrace_endSection} pairs are properly nested and called from the same thread.
	 *
	 * Available since API level 23.
	 */
	ATrace_endSection :: proc() ---

	/**
	 * Writes a trace message to indicate that a given section of code has
	 * begun. Must be followed by a call to {@link ATrace_endAsyncSection} with the same
	 * methodName and cookie. Unlike {@link ATrace_beginSection} and {@link ATrace_endSection},
	 * asynchronous events do not need to be nested. The name and cookie used to
	 * begin an event must be used to end it.
	 *
	 * Available since API level 29.
	 *
	 * \param sectionName The method name to appear in the trace.
	 * \param cookie Unique identifier for distinguishing simultaneous events
	 */
	ATrace_beginAsyncSection :: proc(sectionName: cstring, cookie: i32) ---

	/**
	 * Writes a trace message to indicate that the current method has ended.
	 * Must be called exactly once for each call to {@link ATrace_beginAsyncSection}
	 * using the same name and cookie.
	 *
	 * Available since API level 29.
	 *
	 * \param sectionName The method name to appear in the trace.
	 * \param cookie Unique identifier for distinguishing simultaneous events
	 */
	ATrace_endAsyncSection :: proc(sectionName: cstring, cookie: i32) ---

	/**
	 * Writes trace message to indicate the value of a given counter.
	 *
	 * Available since API level 29.
	 *
	 * \param counterName The counter name to appear in the trace.
	 * \param counterValue The counter value.
	 */
	ATrace_setCounter :: proc(counterName: cstring, counterValue: i64) ---
}
