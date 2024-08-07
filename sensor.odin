//+build android
package android

foreign import android "system:android"

/*
 * A few useful constants
 */

/** Earth's gravity in m/s^2 */
ASENSOR_STANDARD_GRAVITY          ::  (9.80665)
/** Maximum magnetic field on Earth's surface in uT */
ASENSOR_MAGNETIC_FIELD_EARTH_MAX  ::  (60.0)
/** Minimum magnetic field on Earth's surface in uT*/
ASENSOR_MAGNETIC_FIELD_EARTH_MIN  ::  (30.0)


ASENSOR_RESOLUTION_INVALID  ::  f32(0h7ff80000_00000001)
ASENSOR_FIFO_COUNT_INVALID  ::  (-1)
ASENSOR_DELAY_INVALID       ::  min(i32)
ASENSOR_INVALID             ::  (-1)

/**
 * Sensor types.
 *
 * See
 * [android.hardware.SensorEvent#values](https://developer.android.com/reference/android/hardware/SensorEvent.html#values)
 * for detailed explanations of the data returned for each of these types.
 */
SensorType :: enum i32 {
    /**
     * Invalid sensor type. Returned by {@link ASensor_getType} as error value.
     */
    INVALID = -1,
    /**
     * {@link ASENSOR_TYPE_ACCELEROMETER}
     * reporting-mode: continuous
     *
     *  All values are in SI units (m/s^2) and measure the acceleration of the
     *  device minus the force of gravity.
     */
    ACCELEROMETER       = 1,
    /**
     * {@link ASENSOR_TYPE_MAGNETIC_FIELD}
     * reporting-mode: continuous
     *
     *  All values are in micro-Tesla (uT) and measure the geomagnetic
     *  field in the X, Y and Z axis.
     */
    MAGNETIC_FIELD      = 2,
    /**
     * {@link ASENSOR_TYPE_GYROSCOPE}
     * reporting-mode: continuous
     *
     *  All values are in radians/second and measure the rate of rotation
     *  around the X, Y and Z axis.
     */
    GYROSCOPE           = 4,
    /**
     * {@link ASENSOR_TYPE_LIGHT}
     * reporting-mode: on-change
     *
     * The light sensor value is returned in SI lux units.
     */
    LIGHT               = 5,
    /**
     * {@link ASENSOR_TYPE_PRESSURE}
     *
     * The pressure sensor value is returned in hPa (millibar).
     */
    PRESSURE            = 6,
    /**
     * {@link ASENSOR_TYPE_PROXIMITY}
     * reporting-mode: on-change
     *
     * The proximity sensor which turns the screen off and back on during calls is the
     * wake-up proximity sensor. Implement wake-up proximity sensor before implementing
     * a non wake-up proximity sensor. For the wake-up proximity sensor set the flag
     * SENSOR_FLAG_WAKE_UP.
     * The value corresponds to the distance to the nearest object in centimeters.
     */
    PROXIMITY           = 8,
    /**
     * {@link ASENSOR_TYPE_GRAVITY}
     *
     * All values are in SI units (m/s^2) and measure the direction and
     * magnitude of gravity. When the device is at rest, the output of
     * the gravity sensor should be identical to that of the accelerometer.
     */
    GRAVITY             = 9,
    /**
     * {@link ASENSOR_TYPE_LINEAR_ACCELERATION}
     * reporting-mode: continuous
     *
     *  All values are in SI units (m/s^2) and measure the acceleration of the
     *  device not including the force of gravity.
     */
    LINEAR_ACCELERATION = 10,
    /**
     * {@link ASENSOR_TYPE_ROTATION_VECTOR}
     */
    ROTATION_VECTOR     = 11,
    /**
     * {@link ASENSOR_TYPE_RELATIVE_HUMIDITY}
     *
     * The relative humidity sensor value is returned in percent.
     */
    RELATIVE_HUMIDITY   = 12,
    /**
     * {@link ASENSOR_TYPE_AMBIENT_TEMPERATURE}
     *
     * The ambient temperature sensor value is returned in Celcius.
     */
    AMBIENT_TEMPERATURE = 13,
    /**
     * {@link ASENSOR_TYPE_MAGNETIC_FIELD_UNCALIBRATED}
     */
    MAGNETIC_FIELD_UNCALIBRATED = 14,
    /**
     * {@link ASENSOR_TYPE_GAME_ROTATION_VECTOR}
     */
    GAME_ROTATION_VECTOR = 15,
    /**
     * {@link ASENSOR_TYPE_GYROSCOPE_UNCALIBRATED}
     */
    GYROSCOPE_UNCALIBRATED = 16,
    /**
     * {@link ASENSOR_TYPE_SIGNIFICANT_MOTION}
     */
    SIGNIFICANT_MOTION = 17,
    /**
     * {@link ASENSOR_TYPE_STEP_DETECTOR}
     */
    STEP_DETECTOR = 18,
    /**
     * {@link ASENSOR_TYPE_STEP_COUNTER}
     */
    STEP_COUNTER = 19,
    /**
     * {@link ASENSOR_TYPE_GEOMAGNETIC_ROTATION_VECTOR}
     */
    GEOMAGNETIC_ROTATION_VECTOR = 20,
    /**
     * {@link ASENSOR_TYPE_HEART_RATE}
     */
    HEART_RATE = 21,
    /**
     * {@link ASENSOR_TYPE_POSE_6DOF}
     */
    POSE_6DOF = 28,
    /**
     * {@link ASENSOR_TYPE_STATIONARY_DETECT}
     */
    STATIONARY_DETECT = 29,
    /**
     * {@link ASENSOR_TYPE_MOTION_DETECT}
     */
    MOTION_DETECT = 30,
    /**
     * {@link ASENSOR_TYPE_HEART_BEAT}
     */
    HEART_BEAT = 31,
    /**
     * A constant describing a dynamic sensor meta event sensor.
     *
     * A sensor event of this type is received when a dynamic sensor is added to or removed from
     * the system. This sensor type should always use special trigger report mode.
     */
    DYNAMIC_SENSOR_META = 32,
    /**
     * This sensor type is for delivering additional sensor information aside
     * from sensor event data.
     *
     * Additional information may include:
     *     - {@link ASENSOR_ADDITIONAL_INFO_INTERNAL_TEMPERATURE}
     *     - {@link ASENSOR_ADDITIONAL_INFO_SAMPLING}
     *     - {@link ASENSOR_ADDITIONAL_INFO_SENSOR_PLACEMENT}
     *     - {@link ASENSOR_ADDITIONAL_INFO_UNTRACKED_DELAY}
     *     - {@link ASENSOR_ADDITIONAL_INFO_VEC3_CALIBRATION}
     *
     * This type will never bind to a sensor. In other words, no sensor in the
     * sensor list can have the type {@link ASENSOR_TYPE_ADDITIONAL_INFO}.
     *
     * If a device supports the sensor additional information feature, it will
     * report additional information events via {@link ASensorEvent} and will
     * have the type of {@link ASensorEvent} set to
     * {@link ASENSOR_TYPE_ADDITIONAL_INFO} and the sensor of {@link ASensorEvent} set
     * to the handle of the reporting sensor.
     *
     * Additional information reports consist of multiple frames ordered by
     * {@link ASensorEvent#timestamp}. The first frame in the report will have
     * a {@link AAdditionalInfoEvent#type} of
     * {@link ASENSOR_ADDITIONAL_INFO_BEGIN}, and the last frame in the report
     * will have a {@link AAdditionalInfoEvent#type} of
     * {@link ASENSOR_ADDITIONAL_INFO_END}.
     *
     */
    ADDITIONAL_INFO = 33,
    /**
     * {@link ASENSOR_TYPE_LOW_LATENCY_OFFBODY_DETECT}
     */
    LOW_LATENCY_OFFBODY_DETECT = 34,
    /**
     * {@link ASENSOR_TYPE_ACCELEROMETER_UNCALIBRATED}
     */
    ACCELEROMETER_UNCALIBRATED = 35,
    /**
     * {@link ASENSOR_TYPE_HINGE_ANGLE}
     * reporting-mode: on-change
     *
     * The hinge angle sensor value is returned in degrees.
     */
    HINGE_ANGLE = 36,
    /**
     * {@link ASENSOR_TYPE_HEAD_TRACKER}
     * reporting-mode: continuous
     *
     * Measures the orientation and rotational velocity of a user's head. Only for internal use
     * within the Android system.
     */
    HEAD_TRACKER = 37,
    /**
     * {@link ASENSOR_TYPE_ACCELEROMETER_LIMITED_AXES}
     * reporting-mode: continuous
     *
     * The first three values are in SI units (m/s^2) and measure the acceleration of the device
     * minus the force of gravity. The last three values indicate which acceleration axes are
     * supported. A value of 1.0 means supported and a value of 0 means not supported.
     */
    ACCELEROMETER_LIMITED_AXES = 38,
    /**
     * {@link ASENSOR_TYPE_GYROSCOPE_LIMITED_AXES}
     * reporting-mode: continuous
     *
     * The first three values are in radians/second and measure the rate of rotation around the X,
     * Y and Z axis. The last three values indicate which rotation axes are supported. A value of
     * 1.0 means supported and a value of 0 means not supported.
     */
    GYROSCOPE_LIMITED_AXES = 39,
    /**
     * {@link ASENSOR_TYPE_ACCELEROMETER_LIMITED_AXES_UNCALIBRATED}
     * reporting-mode: continuous
     *
     * The first three values are in SI units (m/s^2) and measure the acceleration of the device
     * minus the force of gravity. The middle three values represent the estimated bias for each
     * axis. The last three values indicate which acceleration axes are supported. A value of 1.0
     * means supported and a value of 0 means not supported.
     */
    ACCELEROMETER_LIMITED_AXES_UNCALIBRATED = 40,
    /**
     * {@link ASENSOR_TYPE_GYROSCOPE_LIMITED_AXES_UNCALIBRATED}
     * reporting-mode: continuous
     *
     * The first three values are in radians/second and measure the rate of rotation around the X,
     * Y and Z axis. The middle three values represent the estimated drift around each axis in
     * rad/s. The last three values indicate which rotation axes are supported. A value of 1.0 means
     * supported and a value of 0 means not supported.
     */
    GYROSCOPE_LIMITED_AXES_UNCALIBRATED = 41,
    /**
     * {@link ASENSOR_TYPE_HEADING}
     * reporting-mode: continuous
     *
     * A heading sensor measures the direction in which the device is pointing
     * relative to true north in degrees.
     */
    HEADING = 42,
}

/**
 * Sensor accuracy measure.
 */
SensorStatus :: enum i8 {
    NO_CONTACT       = -1,
    UNRELIABLE       = 0,
    ACCURACY_LOW     = 1,
    ACCURACY_MEDIUM  = 2,
    ACCURACY_HIGH    = 3
}

/**
 * Sensor Reporting Modes.
 */
SensorReportingMode :: enum i32 {
    INVALID = -1,
    CONTINUOUS = 0,
    ON_CHANGE = 1,
    ONE_SHOT = 2,
    SPECIAL_TRIGGER = 3
}

/**
 * Sensor Direct Report Rates.
 */
 SensorDirectReportRate :: enum i32 {
    /** stopped */
    STOP = 0,
    /** nominal 50Hz */
    NORMAL = 1,
    /** nominal 200Hz */
    FAST = 2,
    /** nominal 800Hz */
    VERY_FAST = 3
}

/**
 * Sensor Direct Channel Type.
 */
 SensorDirectChannelType :: enum i32 {
    /** shared memory created by ASharedMemory_create */
    SHARED_MEMORY = 1,
    /** AHardwareBuffer */
    HARDWARE_BUFFER = 2
}

/**
 * Sensor Additional Info Types.
 *
 * Used to populate {@link AAdditionalInfoEvent#type}.
 */
SensorAdditionalInfo :: enum i32 {
    /** Marks the beginning of additional information frames */
    BEGIN = 0,

    /** Marks the end of additional information frames */
    END = 1,

    /**
     * Estimation of the delay that is not tracked by sensor timestamps. This
     * includes delay introduced by sensor front-end filtering, data transport,
     * etc.
     * float[2]: delay in seconds, standard deviation of estimated value
     */
    UNTRACKED_DELAY = 0x10000,

    /** float: Celsius temperature */
    INTERNAL_TEMPERATURE,

    /**
     * First three rows of a homogeneous matrix, which represents calibration to
     * a three-element vector raw sensor reading.
     * float[12]: 3x4 matrix in row major order
     */
    VEC3_CALIBRATION,

    /**
     * Location and orientation of sensor element in the device frame: origin is
     * the geometric center of the mobile device screen surface; the axis
     * definition corresponds to Android sensor definitions.
     * float[12]: 3x4 matrix in row major order
     */
    SENSOR_PLACEMENT,

    /**
     * float[2]: raw sample period in seconds,
     *           standard deviation of sampling period
     */
    SAMPLING,
}

/**
 * A sensor event.
 */

/* NOTE: changes to these structs have to be backward compatible */
ASensorVector :: struct {
    using _: struct #raw_union {
		v: [3]f32,
        using _: struct {
			x: f32,
            y: f32,
            z: f32,
        },
		using _: struct {
			azimuth: f32,
            pitch: f32,
            roll: f32,
        },
    },
	status: SensorStatus,
    reserved: [3]u8,
}

// TODO: sensor might be SensorType here, will need some code to confirm though.
// Not sure what "what" is, maybe code will confirm this too.
AMetaDataEvent :: struct {
	what: i32,
    sensor: i32,
}

AUncalibratedEvent :: struct {
    using _: struct #raw_union {
		uncalib: [3]f32,
        using _: struct {
			x_uncalib: f32,
            y_uncalib: f32,
            z_uncalib: f32,
        },
    },
    using _: struct #raw_union {
		bias: [3]f32,
        using _: struct {
			x_bias: f32,
            y_bias: f32,
            z_bias: f32,
        },
    },
}

AHeartRateEvent :: struct {
	bpm: f32,
    status: SensorStatus,
}

ADynamicSensorEvent :: struct {
	connected: i32,
    handle: i32,
}

AAdditionalInfoEvent :: struct {
    /**
     * Event type, such as ASENSOR_ADDITIONAL_INFO_BEGIN, ASENSOR_ADDITIONAL_INFO_END and others.
     * Refer to {@link ASENSOR_TYPE_ADDITIONAL_INFO} for the expected reporting behavior.
     */
	type: SensorAdditionalInfo,
    serial: i32,
    using _: struct #raw_union {
		data_int32: [14]i32,
        data_float: [14]f32,
    },
}

AHeadTrackerEvent :: struct {
    /**
     * The fields rx, ry, rz are an Euler vector (rotation vector, i.e. a vector
     * whose direction indicates the axis of rotation and magnitude indicates
     * the angle to rotate around that axis) representing the transform from
     * the (arbitrary, possibly slowly drifting) reference frame to the
     * head frame. Expressed in radians. Magnitude of the vector must be
     * in the range [0, pi], while the value of individual axes are
     * in the range [-pi, pi].
     */
	rx: f32,
    ry: f32,
    rz: f32,

    /**
     * The fields vx, vy, vz are an Euler vector (rotation vector) representing
     * the angular velocity of the head (relative to itself), in radians per
     * second. The direction of this vector indicates the axis of rotation, and
     * the magnitude indicates the rate of rotation.
     */
    vx: f32,
    vy: f32,
    vz: f32,

    /**
     * This value changes each time the reference frame is suddenly and
     * significantly changed, for example if an orientation filter algorithm
     * used for determining the orientation has had its state reset.
     */
    discontinuity_count: i32,
}

ALimitedAxesImuEvent :: struct {
    using _: struct #raw_union {
		calib: [3]f32,
        using _: struct {
			x: f32,
            y: f32,
            z: f32,
        },
    },
    using _: struct #raw_union {
		supported: [3]f32,
        using _: struct {
			x_supported: f32,
            y_supported: f32,
            z_supported: f32,
        },
    },
}

ALimitedAxesImuUncalibratedEvent :: struct {
    using _: struct #raw_union {
		uncalib: [3]f32,
        using _: struct {
			x_uncalib: f32,
            y_uncalib: f32,
            z_uncalib: f32,
        },
    },
    using _: struct #raw_union {
		bias: [3]f32,
        using _: struct {
			x_bias: f32,
            y_bias: f32,
            z_bias: f32,
        },
    },
    using _: struct #raw_union {
		supported: [3]f32,
        using _: struct {
			x_supported: f32,
            y_supported: f32,
            z_supported: f32,
        },
    },
}

AHeadingEvent :: struct {
    /**
     * The direction in which the device is pointing relative to true north in
     * degrees. The value must be between 0.0 (inclusive) and 360.0 (exclusive),
     * with 0 indicating north, 90 east, 180 south, and 270 west.
     */
	heading: f32,
    /**
     * Accuracy is defined at 68% confidence. In the case where the underlying
     * distribution is assumed Gaussian normal, this would be considered one
     * standard deviation. For example, if the heading returns 60 degrees, and
     * accuracy returns 10 degrees, then there is a 68 percent probability of
     * the true heading being between 50 degrees and 70 degrees.
     */
    accuracy: f32,
}

// LINT.IfChange
/**
 * Information that describes a sensor event, refer to
 * <a href="/reference/android/hardware/SensorEvent">SensorEvent</a> for additional
 * documentation.
 *
 * NOTE: changes to this struct has to be backward compatible and reflected in
 * sensors_event_t
 */
ASensorEvent :: struct {
	version: i32, /* sizeof(struct ASensorEvent) */
    sensor: i32,  /** The sensor that generates this event */
    type: SensorType,    /** Sensor type for the event, such as {@link ASENSOR_TYPE_ACCELEROMETER} */
    reserved0: i32, /** do not use */
    /**
     * The time in nanoseconds at which the event happened, and its behavior
     * is identical to <a href="/reference/android/hardware/SensorEvent#timestamp">
     * SensorEvent::timestamp</a> in Java API.
     */
    timestamp: i64,
    using _: struct #raw_union {
        using _: struct #raw_union {
			data: [16]f32,
            vector: ASensorVector,
            acceleration: ASensorVector,
            gyro: ASensorVector,
            magnetic: ASensorVector,
            temperature: f32,
            distance: f32,
            light: f32,
            pressure: f32,
            relative_humidity: f32,
            uncalibrated_acceleration: AUncalibratedEvent,
            uncalibrated_gyro: AUncalibratedEvent,
            uncalibrated_magnetic: AUncalibratedEvent,
            meta_data: AMetaDataEvent,
            heart_rate: AHeartRateEvent,
            dynamic_sensor_meta: ADynamicSensorEvent,
			additional_info: AAdditionalInfoEvent,
            head_tracker: AHeadTrackerEvent,
            limited_axes_imu: ALimitedAxesImuEvent,
            limited_axes_imu_uncalibrated: ALimitedAxesImuUncalibratedEvent,
            heading: AHeadingEvent,
        },
        u64: struct #raw_union {
			data: [8]u64,
            step_counter: u64,
        },
    },

	flags: u32,
    reserved1: [3]i32,
}

/**
 * {@link ASensorManager} is an opaque type to manage sensors and
 * events queues.
 *
 * {@link ASensorManager} is a singleton that can be obtained using
 * ASensorManager_getInstance().
 *
 * This file provides a set of functions that uses {@link
 * ASensorManager} to access and list hardware sensors, and
 * create and destroy event queues:
 * - ASensorManager_getSensorList()
 * - ASensorManager_getDefaultSensor()
 * - ASensorManager_getDefaultSensorEx()
 * - ASensorManager_createEventQueue()
 * - ASensorManager_destroyEventQueue()
 */
ASensorManager :: struct{}


/**
 * {@link ASensorEventQueue} is an opaque type that provides access to
 * {@link ASensorEvent} from hardware sensors.
 *
 * A new {@link ASensorEventQueue} can be obtained using ASensorManager_createEventQueue().
 *
 * This file provides a set of functions to enable and disable
 * sensors, check and get events, and set event rates on a {@link
 * ASensorEventQueue}.
 * - ASensorEventQueue_enableSensor()
 * - ASensorEventQueue_disableSensor()
 * - ASensorEventQueue_hasEvents()
 * - ASensorEventQueue_getEvents()
 * - ASensorEventQueue_setEventRate()
 * - ASensorEventQueue_requestAdditionalInfoEvents()
 */
ASensorEventQueue :: struct{}

/**
 * {@link ASensor} is an opaque type that provides information about
 * an hardware sensors.
 *
 * A {@link ASensor} pointer can be obtained using
 * ASensorManager_getDefaultSensor(),
 * ASensorManager_getDefaultSensorEx() or from a {@link ASensorList}.
 *
 * This file provides a set of functions to access properties of a
 * {@link ASensor}:
 * - ASensor_getName()
 * - ASensor_getVendor()
 * - ASensor_getType()
 * - ASensor_getResolution()
 * - ASensor_getMinDelay()
 * - ASensor_getFifoMaxEventCount()
 * - ASensor_getFifoReservedEventCount()
 * - ASensor_getStringType()
 * - ASensor_getReportingMode()
 * - ASensor_isWakeUpSensor()
 * - ASensor_getHandle()
 */
ASensor :: struct{}
/**
 * {@link ASensorRef} is a type for constant pointers to {@link ASensor}.
 *
 * This is used to define entry in {@link ASensorList} arrays.
 */
ASensorRef :: ^ASensor
/**
 * {@link ASensorList} is an array of reference to {@link ASensor}.
 *
 * A {@link ASensorList} can be initialized using ASensorManager_getSensorList().
 */
ASensorList :: [^]ASensorRef

foreign android {
	/**
	 * Get a reference to the sensor manager. ASensorManager is a singleton
	 * per package as different packages may have access to different sensors.
	 *
	 * Deprecated: Use ASensorManager_getInstanceForPackage(const char*) instead.
	 * Deprecated since API level 26
	 *
	 * Example:
	 *
	 *     ASensorManager* sensorManager = ASensorManager_getInstance()
	 *
	 */
	@(deprecated="Use ASensorManager_getInstanceForPackage instead. Deprecated since API level 26.")
	ASensorManager_getInstance :: proc() -> ^ASensorManager ---

	/**
	* Get a reference to the sensor manager. ASensorManager is a singleton
	* per package as different packages may have access to different sensors.
	*
	* Example:
	*
	*     ASensorManager* sensorManager = ASensorManager_getInstanceForPackage("foo.bar.baz")
	*
	* Available since API level 26.
	*/
	ASensorManager_getInstanceForPackage :: proc(packageName: cstring) -> ^ASensorManager ---

	/**
	* Returns the list of available sensors. The returned list is owned by the
	* sensor manager and will not change between calls to this function.
	*
	* \param manager the {@link ASensorManager} instance obtained from
	*                {@link ASensorManager_getInstanceForPackage}.
	* \param list    the returned list of sensors.
	* \return positive number of returned sensors or negative error code.
	*         BAD_VALUE: manager is NULL.
	*/
	ASensorManager_getSensorList :: proc(manager: ^ASensorManager, list: ^ASensorList) -> i32 ---

	/**
	* Returns the list of available dynamic sensors. If there are no dynamic
	* sensors available, returns nullptr in list.
	*
	* Each time this is called, the previously returned list is deallocated and
	* must no longer be used.
	*
	* Clients should call this if they receive a sensor update from
	* {@link ASENSOR_TYPE_DYNAMIC_SENSOR_META} indicating the sensors have changed.
	* If this happens, previously received lists from this method will be stale.
	*
	* Available since API level 33.
	*
	* \param manager the {@link ASensorManager} instance obtained from
	*                {@link ASensorManager_getInstanceForPackage}.
	* \param list    the returned list of dynamic sensors.
	* \return positive number of returned sensors or negative error code.
	*         BAD_VALUE: manager is NULL.
	*/
	ASensorManager_getDynamicSensorList :: proc(manager: ^ASensorManager, list: ^ASensorList) -> int ---

	/**
	* Returns the default sensor for the given type, or NULL if no sensor
	* of that type exists.
	*/
	ASensorManager_getDefaultSensor :: proc(manager: ^ASensorManager, type: SensorType) -> ^ASensor ---

	/**
	* Returns the default sensor with the given type and wakeUp properties or NULL if no sensor
	* of this type and wakeUp properties exists.
	*
	* Available since API level 21.
	*/
	ASensorManager_getDefaultSensorEx :: proc(manager: ^ASensorManager, type: SensorType, wakeUp: bool) -> ^ASensor ---

	/**
	* Creates a new sensor event queue and associate it with a looper.
	*
	* "ident" is a identifier for the events that will be returned when
	* calling ALooper_pollOnce(). The identifier must be >= 0, or
	* ALOOPER_POLL_CALLBACK if providing a non-NULL callback.
	*/
	ASensorManager_createEventQueue :: proc(manager: ^ASensorManager, looper: ^ALooper, ident: i32, callback: ALooper_callbackFunc, data: rawptr) -> ^ASensorEventQueue ---

	/**
	* Destroys the event queue and free all resources associated to it.
	*/
	ASensorManager_destroyEventQueue :: proc(manager: ^ASensorManager, queue: ^ASensorEventQueue) -> i32 ---

	/**
	* Create direct channel based on shared memory
	*
	* Create a direct channel of {@link ASENSOR_DIRECT_CHANNEL_TYPE_SHARED_MEMORY} to be used
	* for configuring sensor direct report.
	*
	* Available since API level 26.
	*
	* \param manager the {@link ASensorManager} instance obtained from
	*                {@link ASensorManager_getInstanceForPackage}.
	* \param fd      file descriptor representing a shared memory created by
	*                {@link ASharedMemory_create}
	* \param size    size to be used, must be less or equal to size of shared memory.
	*
	* \return a positive integer as a channel id to be used in
	*         {@link ASensorManager_destroyDirectChannel} and
	*         {@link ASensorManager_configureDirectReport}, or value less or equal to 0 for failures.
	*/
	ASensorManager_createSharedMemoryDirectChannel :: proc(manager: ^ASensorManager, fd: i32, size: uint) -> i32 ---

	/**
	* Create direct channel based on AHardwareBuffer
	*
	* Create a direct channel of {@link ASENSOR_DIRECT_CHANNEL_TYPE_HARDWARE_BUFFER} type to be used
	* for configuring sensor direct report.
	*
	* Available since API level 26.
	*
	* \param manager the {@link ASensorManager} instance obtained from
	*                {@link ASensorManager_getInstanceForPackage}.
	* \param buffer  {@link AHardwareBuffer} instance created by {@link AHardwareBuffer_allocate}.
	* \param size    the intended size to be used, must be less or equal to size of buffer.
	*
	* \return a positive integer as a channel id to be used in
	*         {@link ASensorManager_destroyDirectChannel} and
	*         {@link ASensorManager_configureDirectReport}, or value less or equal to 0 for failures.
	*/
	ASensorManager_createHardwareBufferDirectChannel :: proc(manager: ^ASensorManager, buffer: ^AHardwareBuffer, size: uint) -> i32 ---

	/**
	* Destroy a direct channel
	*
	* Destroy a direct channel previously created by using one of
	* ASensorManager_create*DirectChannel() derivative functions.
	* Note that the buffer used for creating the direct channel does not get destroyed with
	* ASensorManager_destroyDirectChannel and has to be closed or released separately.
	*
	* Available since API level 26.
	*
	* \param manager the {@link ASensorManager} instance obtained from
	*                {@link ASensorManager_getInstanceForPackage}.
	* \param channelId channel id (a positive integer) returned from
	*                  {@link ASensorManager_createSharedMemoryDirectChannel} or
	*                  {@link ASensorManager_createHardwareBufferDirectChannel}.
	*/
	ASensorManager_destroyDirectChannel :: proc(manager: ^ASensorManager, channelId: i32) ---

	/**
	* Configure direct report on channel
	*
	* Configure sensor direct report on a direct channel: set rate to value other than
	* {@link ASENSOR_DIRECT_RATE_STOP} so that sensor event can be directly
	* written into the shared memory region used for creating the buffer. It returns a positive token
	* which can be used for identify sensor events from different sensors on success. Calling with rate
	* {@link ASENSOR_DIRECT_RATE_STOP} will stop direct report of the sensor specified in the channel.
	*
	* To stop all active sensor direct report configured to a channel, set sensor to NULL and rate to
	* {@link ASENSOR_DIRECT_RATE_STOP}.
	*
	* In order to successfully configure a direct report, the sensor has to support the specified rate
	* and the channel type, which can be checked by {@link ASensor_getHighestDirectReportRateLevel} and
	* {@link ASensor_isDirectChannelTypeSupported}, respectively.
	*
	* Example:
	*
	*     ASensorManager *manager = ...
	*     ASensor *sensor = ...
	*     int channelId = ...
	*
	*     ASensorManager_configureDirectReport(manager, sensor, channel_id, ASENSOR_DIRECT_RATE_FAST)
	*
	* Available since API level 26.
	*
	* \param manager   the {@link ASensorManager} instance obtained from
	*                  {@link ASensorManager_getInstanceForPackage}.
	* \param sensor    a {@link ASensor} to denote which sensor to be operate. It can be NULL if rate
	*                  is {@link ASENSOR_DIRECT_RATE_STOP}, denoting stopping of all active sensor
	*                  direct report.
	* \param channelId channel id (a positive integer) returned from
	*                  {@link ASensorManager_createSharedMemoryDirectChannel} or
	*                  {@link ASensorManager_createHardwareBufferDirectChannel}.
	* \param rate      one of predefined ASENSOR_DIRECT_RATE_... that is supported by the sensor.
	* \return positive token for success or negative error code.
	*/
	ASensorManager_configureDirectReport :: proc(manager: ^ASensorManager, sensor: ^ASensor, channelId: i32, rate: SensorDirectReportRate) -> i32 ---

	/*****************************************************************************/

	/**
	* Enable the selected sensor with sampling and report parameters
	*
	* Enable the selected sensor at a specified sampling period and max batch report latency.
	* To disable  sensor, use {@link ASensorEventQueue_disableSensor}.
	*
	* \param queue {@link ASensorEventQueue} for sensor event to be report to.
	* \param sensor {@link ASensor} to be enabled.
	* \param samplingPeriodUs sampling period of sensor in microseconds.
	* \param maxBatchReportLatencyUs maximum time interval between two batches of sensor events are
	*                                delievered in microseconds. For sensor streaming, set to 0.
	* \return 0 on success or a negative error code on failure.
	*/
	ASensorEventQueue_registerSensor :: proc(queue: ^ASensorEventQueue, sensor: ^ASensor, samplingPeriodUs: i32, maxBatchReportLatencyUs: i64) -> i32 ---

	/**
	* Enable the selected sensor at default sampling rate.
	*
	* Start event reports of a sensor to specified sensor event queue at a default rate.
	*
	* \param queue {@link ASensorEventQueue} for sensor event to be report to.
	* \param sensor {@link ASensor} to be enabled.
	*
	* \return 0 on success or a negative error code on failure.
	*/
	ASensorEventQueue_enableSensor :: proc(queue: ^ASensorEventQueue, sensor: ^ASensor) -> i32 ---

	/**
	* Disable the selected sensor.
	*
	* Stop event reports from the sensor to specified sensor event queue.
	*
	* \param queue {@link ASensorEventQueue} to be changed
	* \param sensor {@link ASensor} to be disabled
	* \return 0 on success or a negative error code on failure.
	*/
	ASensorEventQueue_disableSensor :: proc(queue: ^ASensorEventQueue, sensor: ^ASensor) -> i32 ---

	/**
	* Sets the delivery rate of events in microseconds for the given sensor.
	*
	* This function has to be called after {@link ASensorEventQueue_enableSensor}.
	* Note that this is a hint only, generally event will arrive at a higher
	* rate. It is an error to set a rate inferior to the value returned by
	* ASensor_getMinDelay().
	*
	* \param queue {@link ASensorEventQueue} to which sensor event is delivered.
	* \param sensor {@link ASensor} of which sampling rate to be updated.
	* \param usec sensor sampling period (1/sampling rate) in microseconds
	* \return 0 on sucess or a negative error code on failure.
	*/
	ASensorEventQueue_setEventRate :: proc(queue: ^ASensorEventQueue, sensor: ^ASensor, usec: i32) -> i32 ---

	/**
	* Determine if a sensor event queue has pending event to be processed.
	*
	* \param queue {@link ASensorEventQueue} to be queried
	* \return 1 if the queue has events 0 if it does not have events
	*         or a negative value if there is an error.
	*/
	ASensorEventQueue_hasEvents :: proc(queue: ^ASensorEventQueue) -> i32 ---

	/**
	* Retrieve pending events in sensor event queue
	*
	* Retrieve next available events from the queue to a specified event array.
	*
	* \param queue {@link ASensorEventQueue} to get events from
	* \param events pointer to an array of {@link ASensorEvent}.
	* \param count max number of event that can be filled into array event.
	* \return number of events returned on success negative error code when
	*         no events are pending or an error has occurred.
	*
	* Examples:
	*
	*     ASensorEvent event
	*     ssize_t numEvent = ASensorEventQueue_getEvents(queue, &event, 1)
	*
	*     ASensorEvent eventBuffer[8]
	*     ssize_t numEvent = ASensorEventQueue_getEvents(queue, eventBuffer, 8)
	*
	*/
	ASensorEventQueue_getEvents :: proc(queue: ^ASensorEventQueue, events: [^]ASensorEvent, count: uint) -> int ---

	/**
	* Request that {@link ASENSOR_TYPE_ADDITIONAL_INFO} events to be delivered on
	* the given {@link ASensorEventQueue}.
	*
	* Sensor data events are always delivered to the {@link ASensorEventQueue}.
	*
	* The {@link ASENSOR_TYPE_ADDITIONAL_INFO} events will be returned through
	* {@link ASensorEventQueue_getEvents}. The client is responsible for checking
	* {@link ASensorEvent#type} to determine the event type prior to handling of
	* the event.
	*
	* The client must be tolerant of any value for
	* {@link AAdditionalInfoEvent#type}, as new values may be defined in the future
	* and may delivered to the client.
	*
	* Available since API level 29.
	*
	* \param queue {@link ASensorEventQueue} to configure
	* \param enable true to request {@link ASENSOR_TYPE_ADDITIONAL_INFO} events,
	*        false to stop receiving events
	* \return 0 on success or a negative error code on failure
	*/
	ASensorEventQueue_requestAdditionalInfoEvents :: proc(queue: ^ASensorEventQueue, enable: bool) -> i32 ---

	/*****************************************************************************/

	/**
	* Returns this sensor's name (non localized)
	*/
	ASensor_getName :: proc(sensor: ^ASensor) -> cstring ---

	/**
	* Returns this sensor's vendor's name (non localized)
	*/
	ASensor_getVendor :: proc(sensor: ^ASensor) -> cstring ---

	/**
	* Return this sensor's type
	*/
	ASensor_getType :: proc(sensor: ^ASensor) -> SensorType ---

	/**
	* Returns this sensors's resolution
	*/
	ASensor_getResolution :: proc(sensor: ^ASensor) -> f32 ---

	/**
	* Returns the minimum delay allowed between events in microseconds.
	* A value of zero means that this sensor doesn't report events at a
	* constant rate, but rather only when a new data is available.
	*/
	ASensor_getMinDelay :: proc(sensor: ^ASensor) -> i32 ---

	/**
	* Returns the maximum size of batches for this sensor. Batches will often be
	* smaller, as the hardware fifo might be used for other sensors.
	*
	* Available since API level 21.
	*/
	ASensor_getFifoMaxEventCount :: proc(sensor: ^ASensor) -> i32 ---

	/**
	* Returns the hardware batch fifo size reserved to this sensor.
	*
	* Available since API level 21.
	*/
	ASensor_getFifoReservedEventCount :: proc(sensor: ^ASensor) -> i32 ---

	/**
	* Returns this sensor's string type.
	*
	* Available since API level 21.
	*/
	ASensor_getStringType :: proc(sensor: ^ASensor) -> cstring ---

	/**
	* Returns the reporting mode for this sensor. One of AREPORTING_MODE_* constants.
	*
	* Available since API level 21.
	*/
	ASensor_getReportingMode :: proc(sensor: ^ASensor) -> SensorReportingMode ---

	/**
	* Returns true if this is a wake up sensor, false otherwise.
	*
	* Available since API level 21.
	*/
	ASensor_isWakeUpSensor :: proc(sensor: ^ASensor) -> bool ---

	/**
	* Test if sensor supports a certain type of direct channel.
	*
	* Available since API level 26.
	*
	* \param sensor  a {@link ASensor} to denote the sensor to be checked.
	* \param channelType  Channel type constant, either
	*                     {@link ASENSOR_DIRECT_CHANNEL_TYPE_SHARED_MEMORY}
	*                     or {@link ASENSOR_DIRECT_CHANNEL_TYPE_HARDWARE_BUFFER}.
	* \returns true if sensor supports the specified direct channel type.
	*/
	ASensor_isDirectChannelTypeSupported :: proc(sensor: ^ASensor, channelType: SensorDirectChannelType) -> bool ---

	/**
	* Get the highest direct rate level that a sensor supports.
	*
	* Available since API level 26.
	*
	* \param sensor  a {@link ASensor} to denote the sensor to be checked.
	*
	* \return a ASENSOR_DIRECT_RATE_... enum denoting the highest rate level supported by the sensor.
	*         If return value is {@link ASENSOR_DIRECT_RATE_STOP}, it means the sensor
	*         does not support direct report.
	*/
	ASensor_getHighestDirectReportRateLevel :: proc(sensor: ^ASensor) -> SensorDirectReportRate ---

	/**
	* Returns the sensor's handle.
	*
	* The handle identifies the sensor within the system and is included in the
	* sensor field of {@link ASensorEvent}, including those sent with type
	* {@link ASENSOR_TYPE_ADDITIONAL_INFO}.
	*
	* A sensor's handle is able to be used to map {@link ASENSOR_TYPE_ADDITIONAL_INFO} events to the
	* sensor that generated the event.
	*
	* It is important to note that the value returned by {@link ASensor_getHandle} is not the same as
	* the value returned by the Java API <a href="/reference/android/hardware/Sensor#getId()">
	* android.hardware.Sensor's getId()</a> and no mapping exists between the values.
	*
	* Available since API level 29.
	*/
	ASensor_getHandle :: proc(sensor: ^ASensor) -> i32 ---
}
