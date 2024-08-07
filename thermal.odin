//+build android
package android

foreign import android "system:android"

/**
 * Thermal status used in function {@link AThermal_getCurrentThermalStatus} and
 * {@link AThermal_StatusCallback}.
 */
AThermalStatus :: enum {
    /** Error in thermal status. */
    ERROR = -1,
    /** Not under throttling. */
    NONE = 0,
    /** Light throttling where UX is not impacted. */
    LIGHT = 1,
    /** Moderate throttling where UX is not largely impacted. */
    MODERATE = 2,
    /** Severe throttling where UX is largely impacted. */
    SEVERE = 3,
    /** Platform has done everything to reduce power. */
    CRITICAL = 4,
    /**
     * Key components in platform are shutting down due to thermal condition.
     * Device functionalities will be limited.
     */
    EMERGENCY = 5,
    /** Need shutdown immediately. */
    SHUTDOWN = 6,
}

/**
 * An opaque type representing a handle to a thermal manager.
 * An instance of thermal manager must be acquired prior to
 * using thermal status APIs and must be released after use.
 *
 * <p>To use:<ul>
 *    <li>Create a new thermal manager instance by calling the
 *        {@link AThermal_acquireManager} function.</li>
 *    <li>Get current thermal status with
 *        {@link AThermal_getCurrentThermalStatus}.</li>
 *    <li>Register a thermal status listener with
 *        {@link AThermal_registerThermalStatusListener}.</li>
 *    <li>Unregister a thermal status listener with
 *        {@link AThermal_unregisterThermalStatusListener}.</li>
 *    <li>Release the thermal manager instance with
 *        {@link AThermal_releaseManager}.</li></ul></p>
 *
 */
AThermalManager :: struct{}

/**
 * Prototype of the function that is called when thermal status changes.
 * It's passed the updated thermal status as parameter, as well as the
 * pointer provided by the client that registered a callback.
 */
AThermal_StatusCallback :: #type proc "c" (data: rawptr, status: AThermalStatus)

foreign android {
	/**
	  * Acquire an instance of the thermal manager. This must be freed using
	  * {@link AThermal_releaseManager}.
	  *
	  * Available since API level 30.
	  *
	  * @return manager instance on success, nullptr on failure.
	  */
	AThermal_acquireManager :: proc() -> ^AThermalManager ---

	/**
	* Release the thermal manager pointer acquired via
	* {@link AThermal_acquireManager}.
	*
	* Available since API level 30.
	*
	* @param manager The manager to be released.
	*/
	AThermal_releaseManager :: proc(manager: ^AThermalManager) ---

	/**
	* Gets the current thermal status.
	*
	* Available since API level 30.
	*
	* @param manager The manager instance to use to query the thermal status.
	* Acquired via {@link AThermal_acquireManager}.
	*
	* @return current thermal status, ATHERMAL_STATUS_ERROR on failure.
	*/
	AThermal_getCurrentThermalStatus :: proc(manager: ^AThermalManager) -> AThermalStatus ---

	/**
	* Register the thermal status listener for thermal status change.
	*
	* Available since API level 30.
	*
	* @param manager The manager instance to use to register.
	* Acquired via {@link AThermal_acquireManager}.
	* @param callback The callback function to be called when thermal status updated.
	* @param data The data pointer to be passed when callback is called.
	*
	* @return 0 on success
	*         EINVAL if the listener and data pointer were previously added and not removed.
	*         EPERM if the required permission is not held.
	*         EPIPE if communication with the system service has failed.
	*/
	AThermal_registerThermalStatusListener :: proc(manager: ^AThermalManager, callback: AThermal_StatusCallback, data: rawptr) -> i32 ---

	/**
	* Unregister the thermal status listener previously resgistered.
	*
	* Available since API level 30.
	*
	* @param manager The manager instance to use to unregister.
	* Acquired via {@link AThermal_acquireManager}.
	* @param callback The callback function to be called when thermal status updated.
	* @param data The data pointer to be passed when callback is called.
	*
	* @return 0 on success
	*         EINVAL if the listener and data pointer were not previously added.
	*         EPERM if the required permission is not held.
	*         EPIPE if communication with the system service has failed.
	*/
	AThermal_unregisterThermalStatusListener :: proc(manager: ^AThermalManager, callback: AThermal_StatusCallback, data: rawptr) -> i32 ---

	/**
	* Provides an estimate of how much thermal headroom the device currently has before
	* hitting severe throttling.
	*
	* Note that this only attempts to track the headroom of slow-moving sensors, such as
	* the skin temperature sensor. This means that there is no benefit to calling this function
	* more frequently than about once per second, and attempted to call significantly
	* more frequently may result in the function returning {@code NaN}.
	*
	* In addition, in order to be able to provide an accurate forecast, the system does
	* not attempt to forecast until it has multiple temperature samples from which to
	* extrapolate. This should only take a few seconds from the time of the first call,
	* but during this time, no forecasting will occur, and the current headroom will be
	* returned regardless of the value of {@code forecastSeconds}.
	*
	* The value returned is a non-negative float that represents how much of the thermal envelope
	* is in use (or is forecasted to be in use). A value of 1.0 indicates that the device is
	* (or will be) throttled at {@link #ATHERMAL_STATUS_SEVERE}. Such throttling can affect the
	* CPU, GPU, and other subsystems. Values may exceed 1.0, but there is no implied mapping
	* to specific thermal levels beyond that point. This means that values greater than 1.0
	* may correspond to {@link #ATHERMAL_STATUS_SEVERE}, but may also represent heavier throttling.
	*
	* A value of 0.0 corresponds to a fixed distance from 1.0, but does not correspond to any
	* particular thermal status or temperature. Values on (0.0, 1.0] may be expected to scale
	* linearly with temperature, though temperature changes over time are typically not linear.
	* Negative values will be clamped to 0.0 before returning.
	*
	* Available since API level 31.
	*
	* @param manager The manager instance to use.
	*                Acquired via {@link AThermal_acquireManager}.
	* @param forecastSeconds how many seconds into the future to forecast. Given that device
	*                        conditions may change at any time, forecasts from further in the
	*                        future will likely be less accurate than forecasts in the near future.
	* @return a value greater than equal to 0.0, where 1.0 indicates the SEVERE throttling threshold,
	*         as described above. Returns NaN if the device does not support this functionality or
	*         if this function is called significantly faster than once per second.
	*/
	AThermal_getThermalHeadroom :: proc(manager: ^AThermalManager, forecastSeconds: i32) -> f32 ---
}
