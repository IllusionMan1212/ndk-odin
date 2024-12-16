package android

import "core:c"

foreign import log "system:log"

/**
 * \file
 *
 * Support routines to send messages to the Android log buffer,
 * which can later be accessed through the `logcat` utility.
 *
 * Each log message must have
 *   - a priority
 *   - a log tag
 *   - some text
 *
 * The tag normally corresponds to the component that emits the log message,
 * and should be reasonably small.
 *
 * Log message text may be truncated to less than an implementation-specific
 * limit (1023 bytes).
 *
 * Note that a newline character ("\n") will be appended automatically to your
 * log message, if not already there. It is not possible to send several
 * messages and have them appear on a single line in logcat.
 *
 * Please use logging in moderation:
 *
 *  - Sending log messages eats CPU and slow down your application and the
 *    system.
 *
 *  - The circular log buffer is pretty small, so sending many messages
 *    will hide other important log messages.
 *
 *  - In release builds, only send log messages to account for exceptional
 *    conditions.
 */


/**
 * Android log priority values, in increasing order of priority.
 */
LogPriority :: enum i32 {
  /** For internal use only.  */
  UNKNOWN = 0,
  /** The default priority, for internal use only.  */
  DEFAULT, /* only for SetMinPriority() */
  /** Verbose logging. Should typically be disabled for a release apk. */
  VERBOSE,
  /** Debug logging. Should typically be disabled for a release apk. */
  DEBUG,
  /** Informational logging. Should typically be disabled for a release apk. */
  INFO,
  /** Warning logging. For use with recoverable failures. */
  WARN,
  /** Error logging. For use with unrecoverable failures. */
  ERROR,
  /** Fatal logging. For use when aborting. */
  FATAL,
  /** For internal use only.  */
  SILENT, /* only for SetMinPriority(); must be last */
}

/**
 * Identifies a specific log buffer for __android_log_buf_write()
 * and __android_log_buf_print().
 */
LogId :: enum i32 {
  MIN = 0,

  /** The main log buffer. This is the only log buffer available to apps. */
  MAIN = 0,
  /** The radio log buffer. */
  RADIO = 1,
  /** The event log buffer. */
  EVENTS = 2,
  /** The system log buffer. */
  SYSTEM = 3,
  /** The crash log buffer. */
  CRASH = 4,
  /** The statistics log buffer. */
  STATS = 5,
  /** The security log buffer. */
  SECURITY = 6,
  /** The kernel log buffer. */
  KERNEL = 7,

  MAX,

  /** Let the logging function choose the best log target. */
  DEFAULT = 0x7FFFFFFF
}

/**
 * Logger data struct used for writing log messages to liblog via __android_log_write_logger_data()
 * and sending log messages to user defined loggers specified in __android_log_set_logger().
 */
LogMessage :: struct {
  /** Must be set to sizeof(LogMessage) and is used for versioning. */
  struct_size: uint,

  /** {@link log_id_t} values. */
  buffer_id: i32,

  /** {@link android_LogPriority} values. */
  priority: i32,

  /** The tag for the log message. */
  tag: cstring,

  /** Optional file name, may be set to nullptr. */
  file: cstring,

  /** Optional line number, ignore if file is nullptr. */
  line: u32,

  /** The log message itself. */
  message: cstring,
}

/**
 * Prototype for the 'logger' function that is called for every log message.
 */
__android_logger_function :: #type proc "c" (log_message: ^LogMessage)
/**
 * Prototype for the 'abort' function that is called when liblog will abort due to
 * __android_log_assert() failures.
 */
__android_aborter_function :: #type proc "c" (abort_message: cstring)

foreign log {
	/**
	 * Writes the constant string `text` to the log, with priority `prio` and tag
	 * `tag`.
	 */
	__android_log_write :: proc(prio: LogPriority, tag: cstring, text: cstring) -> i32 ---

	/**
	* Writes a formatted string to the log, with priority `prio` and tag `tag`.
	* The details of formatting are the same as for
	* [printf(3)](http://man7.org/linux/man-pages/man3/printf.3.html).
	*/
	__android_log_print :: proc(prio: LogPriority, tag: cstring, fmt: cstring, #c_vararg args: ..any) -> i32 ---

	/**
	* Equivalent to `__android_log_print`, but taking a `va_list`.
	* (If `__android_log_print` is like `printf`, this is like `vprintf`.)
	*/
	__android_log_vprint :: proc(prio: LogPriority, tag: cstring, fmt: cstring, ap: c.va_list) -> i32 ---

	/**
	* Writes an assertion failure to the log (as `ANDROID_LOG_FATAL`) and to
	* stderr, before calling
	* [abort(3)](http://man7.org/linux/man-pages/man3/abort.3.html).
	*
	* If `fmt` is non-null, `cond` is unused. If `fmt` is null, the string
	* `Assertion failed: %s` is used with `cond` as the string argument.
	* If both `fmt` and `cond` are null, a default string is provided.
	*
	* Most callers should use
	* [assert(3)](http://man7.org/linux/man-pages/man3/assert.3.html) from
	* `&ltassert.h&gt` instead, or the `__assert` and `__assert2` functions
	* provided by bionic if more control is needed. They support automatically
	* including the source filename and line number more conveniently than this
	* function.
	*/
	__android_log_assert :: proc(cond: cstring, tag: cstring, fmt: cstring, #c_vararg args: ..any) ---

	/**
	* Writes the constant string `text` to the log buffer `id`,
	* with priority `prio` and tag `tag`.
	*
	* Apps should use __android_log_write() instead.
	*/
	__android_log_buf_write :: proc(bufID: LogId, prio: LogPriority, tag: cstring, text: cstring) -> i32 ---

	/**
	* Writes a formatted string to log buffer `id`,
	* with priority `prio` and tag `tag`.
	* The details of formatting are the same as for
	* [printf(3)](http://man7.org/linux/man-pages/man3/printf.3.html).
	*
	* Apps should use __android_log_print() instead.
	*/
	__android_log_buf_print :: proc(bufID: LogId, prio: LogPriority, tag: cstring, fmt: cstring, #c_vararg args: ..any) -> i32 ---

	/**
	* Writes the log message specified by log_message.  log_message includes additional file name and
	* line number information that a logger may use.  log_message is versioned for backwards
	* compatibility.
	* This assumes that loggability has already been checked through __android_log_is_loggable().
	* Higher level logging libraries, such as libbase, first check loggability, then format their
	* buffers, then pass the message to liblog via this function, and therefore we do not want to
	* duplicate the loggability check here.
	*
	* @param log_message the log message itself, see __android_log_message.
	*
	* Available since API level 30.
	*/
	__android_log_write_log_message :: proc(log_message: ^LogMessage) ---

	/**
	* Sets a user defined logger function.  All log messages sent to liblog will be set to the
	* function pointer specified by logger for processing.  It is not expected that log messages are
	* already terminated with a new line.  This function should add new lines if required for line
	* separation.
	*
	* @param logger the new function that will handle log messages.
	*
	* Available since API level 30.
	*/
	__android_log_set_logger :: proc(logger: __android_logger_function) ---

	/**
	* Writes the log message to logd.  This is an __android_logger_function and can be provided to
	* __android_log_set_logger().  It is the default logger when running liblog on a device.
	*
	* @param log_message the log message to write, see __android_log_message.
	*
	* Available since API level 30.
	*/
	__android_log_logd_logger :: proc(log_message: ^LogMessage) ---

	/**
	* Writes the log message to stderr.  This is an __android_logger_function and can be provided to
	* __android_log_set_logger().  It is the default logger when running liblog on host.
	*
	* @param log_message the log message to write, see __android_log_message.
	*
	* Available since API level 30.
	*/
	__android_log_stderr_logger :: proc(log_message: ^LogMessage) ---

	/**
	* Sets a user defined aborter function that is called for __android_log_assert() failures.  This
	* user defined aborter function is highly recommended to abort and be noreturn, but is not strictly
	* required to.
	*
	* @param aborter the new aborter function, see __android_aborter_function.
	*
	* Available since API level 30.
	*/
	__android_log_set_aborter :: proc(aborter: __android_aborter_function) ---

	/**
	* Calls the stored aborter function.  This allows for other logging libraries to use the same
	* aborter function by calling this function in liblog.
	*
	* @param abort_message an additional message supplied when aborting, for example this is used to
	*                      call android_set_abort_message() in __android_log_default_aborter().
	*
	* Available since API level 30.
	*/
	__android_log_call_aborter :: proc(abort_message: cstring) ---

	/**
	* Sets android_set_abort_message() on device then aborts().  This is the default aborter.
	*
	* @param abort_message an additional message supplied when aborting.  This functions calls
	*                      android_set_abort_message() with its contents.
	*
	* Available since API level 30.
	*/
	__android_log_default_aborter :: proc(abort_message: cstring) ---

	/**
	* Use the per-tag properties "log.tag.<tagname>" along with the minimum priority from
	* __android_log_set_minimum_priority() to determine if a log message with a given prio and tag will
	* be printed.  A non-zero result indicates yes, zero indicates false.
	*
	* If both a priority for a tag and a minimum priority are set by
	* __android_log_set_minimum_priority(), then the lowest of the two values are to determine the
	* minimum priority needed to log.  If only one is set, then that value is used to determine the
	* minimum priority needed.  If none are set, then default_priority is used.
	*
	* @param prio         the priority to test, takes android_LogPriority values.
	* @param tag          the tag to test.
	* @param default_prio the default priority to use if no properties or minimum priority are set.
	* @return an integer where 1 indicates that the message is loggable and 0 indicates that it is not.
	*
	* Available since API level 30.
	*/
	__android_log_is_loggable :: proc(prio: LogPriority, tag: cstring, default_prio: LogPriority) -> i32 ---

	/**
	* Use the per-tag properties "log.tag.<tagname>" along with the minimum priority from
	* __android_log_set_minimum_priority() to determine if a log message with a given prio and tag will
	* be printed.  A non-zero result indicates yes, zero indicates false.
	*
	* If both a priority for a tag and a minimum priority are set by
	* __android_log_set_minimum_priority(), then the lowest of the two values are to determine the
	* minimum priority needed to log.  If only one is set, then that value is used to determine the
	* minimum priority needed.  If none are set, then default_priority is used.
	*
	* @param prio         the priority to test, takes android_LogPriority values.
	* @param tag          the tag to test.
	* @param len          the length of the tag.
	* @param default_prio the default priority to use if no properties or minimum priority are set.
	* @return an integer where 1 indicates that the message is loggable and 0 indicates that it is not.
	*
	* Available since API level 30.
	*/
	__android_log_is_loggable_len :: proc(prio: LogPriority, tag: cstring, len: uint, default_prio: LogPriority) -> i32 ---

	/**
	* Sets the minimum priority that will be logged for this process.
	*
	* @param priority the new minimum priority to set, takes android_LogPriority values.
	* @return the previous set minimum priority as android_LogPriority values, or
	*         ANDROID_LOG_DEFAULT if none was set.
	*
	* Available since API level 30.
	*/
	__android_log_set_minimum_priority :: proc(priority: LogPriority) -> LogPriority ---

	/**
	* Gets the minimum priority that will be logged for this process.  If none has been set by a
	* previous __android_log_set_minimum_priority() call, this returns ANDROID_LOG_DEFAULT.
	*
	* @return the current minimum priority as android_LogPriority values, or
	*         ANDROID_LOG_DEFAULT if none is set.
	*
	* Available since API level 30.
	*/
	__android_log_get_minimum_priority :: proc() -> LogPriority ---

	/**
	* Sets the default tag if no tag is provided when writing a log message.  Defaults to
	* getprogname().  This truncates tag to the maximum log message size, though appropriate tags
	* should be much smaller.
	*
	* @param tag the new log tag.
	*
	* Available since API level 30.
	*/
	__android_log_set_default_tag :: proc(tag: cstring) ---
}

