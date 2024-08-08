//+build android
package amidi

foreign import amidi "system:amidi"

/*
 * Message Op Codes. Used to parse MIDI data packets
 */
AMidiOpcode :: enum i32 {
    DATA = 1,      /* The MIDI packet contains normal MIDI data */
    FLUSH = 2,     /* The MIDI packet contains just a MIDI FLUSH command. */
                                /* Forces the send of any pending MIDI data. */
}

/*
 * Type IDs for various MIDI devices.
 */
AMidiDeviceType :: enum i32 {
    USB = 1,      /* A MIDI device connected to the Android USB port */
    VIRTUAL = 2,  /* A software object implementing MidiDeviceService */
    BLUETOOTH = 3 /* A MIDI device connected via BlueTooth */
}

/*
 * Protocol IDs for various MIDI devices.
 *
 * Introduced in API 33.
 */
AMidiDevice_Protocol :: enum i32 {
    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use UMP to negotiate with the device with MIDI-CI.
     * MIDI-CI is defined in "MIDI Capability Inquiry (MIDI-CI)" spec.
     */
    UMP_USE_MIDI_CI = 0,

    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 1.0 through UMP with packet sizes up to 64 bits.
     */
    UMP_MIDI_1_0_UP_TO_64_BITS = 1,

    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 1.0 through UMP with packet sizes up to 64 bits and jitter reduction timestamps.
     */
    UMP_MIDI_1_0_UP_TO_64_BITS_AND_JRTS = 2,

    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 1.0 through UMP with packet sizes up to 128 bits.
     */
    UMP_MIDI_1_0_UP_TO_128_BITS = 3,

    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 1.0 through UMP with packet sizes up to 128 bits and jitter reduction timestamps.
     */
    UMP_MIDI_1_0_UP_TO_128_BITS_AND_JRTS = 4,

    /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 2.0 through UMP.
     */
    UMP_MIDI_2_0 = 17,

     /**
     * Constant representing a default protocol with Universal MIDI Packets (UMP).
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * All UMP data should be a multiple of 4 bytes.
     * Use MIDI 2.0 through UMP and jitter reduction timestamps.
     */
    UMP_MIDI_2_0_AND_JRTS = 18,

    /**
     * Constant representing a device with an unknown default protocol.
     * If Universal MIDI Packets (UMP) are needed, use MIDI-CI through MIDI 1.0.
     * UMP is defined in "Universal MIDI Packet (UMP) Format and MIDI 2.0 Protocol" spec.
     * MIDI-CI is defined in "MIDI Capability Inquiry (MIDI-CI)" spec.
     */
    UNKNOWN = -1
}

AMidiDevice :: struct{}
AMidiInputPort :: struct{}
AMidiOutputPort :: struct{}

foreign amidi {
	/*
	 * Device API
	 */
	/**
	 * Connects a native Midi Device object to the associated Java MidiDevice object. Use this
	 * AMidiDevice to access the rest of the native MIDI API. Use AMidiDevice_release() to
	 * disconnect from the Java object when not being used any more.
	 *
	 * @param env   Points to the Java Environment.
	 * @param midiDeviceObj   The Java MidiDevice Object.
	 * @param outDevicePtrPtr  Points to the pointer to receive the AMidiDevice
	 *
	 * @return AMEDIA_OK on success, or a negative error value:
	 *  @see AMEDIA_ERROR_INVALID_OBJECT - the midiDeviceObj
	 *    is null or already connected to a native AMidiDevice
	  *  @see AMEDIA_ERROR_UNKNOWN - an unknown error occurred.
	*
	* Available since API level 29.
	 */
	AMidiDevice_fromJava :: proc(env: ^JNIEnv, midiDeviceObj: jobject, outDevicePtrPtr: ^^AMidiDevice) -> media_status_t ---

	/**
	* Disconnects the native Midi Device Object from the associated Java MidiDevice object.
	*
	* @param midiDevice Points to the native AMIDI_MidiDevice.
	*
	* @return AMEDIA_OK on success,
	* or a negative error value:
	*  @see AMEDIA_ERROR_INVALID_PARAMETER - the device parameter is NULL.
	*  @see AMEDIA_ERROR_INVALID_OBJECT - the device is not consistent with the associated Java MidiDevice.
	*  @see AMEDIA_ERROR_INVALID_OBJECT - the JNI interface initialization to the associated java MidiDevice failed.
	*  @see AMEDIA_ERROR_UNKNOWN - couldn't retrieve the device info.
	*
	* Available since API level 29.
	*/
	AMidiDevice_release :: proc(midiDevice: ^AMidiDevice) -> media_status_t ---

	/**
	* Gets the MIDI device type.
	*
	* @param device Specifies the MIDI device.
	*
	* @return The identifier of the MIDI device type:
	*  AMIDI_DEVICE_TYPE_USB
	*  AMIDI_DEVICE_TYPE_VIRTUAL
	*  AMIDI_DEVICE_TYPE_BLUETOOTH
	* or a negative error value:
	*  @see AMEDIA_ERROR_INVALID_PARAMETER - the device parameter is NULL.
	*  @see AMEDIA_ERROR_UNKNOWN - Unknown error.
	*
	* Available since API level 29.
	*/
	AMidiDevice_getType :: proc(device: ^AMidiDevice) -> i32 ---

	/**
	* Gets the number of input (sending) ports available on the specified MIDI device.
	*
	* @param device Specifies the MIDI device.
	*
	* @return If successful, returns the number of MIDI input (sending) ports available on the
	* device. If an error occurs, returns a negative value indicating the error:
	*  @see AMEDIA_ERROR_INVALID_PARAMETER - the device parameter is NULL.
	*  @see AMEDIA_ERROR_UNKNOWN - couldn't retrieve the device info.
	*
	* Available since API level 29.
	*/
	AMidiDevice_getNumInputPorts :: proc(device: ^AMidiDevice) -> int ---

	/**
	* Gets the number of output (receiving) ports available on the specified MIDI device.
	*
	* @param device Specifies the MIDI device.
	*
	* @return If successful, returns the number of MIDI output (receiving) ports available on the
	* device. If an error occurs, returns a negative value indicating the error:
	*  @see AMEDIA_ERROR_INVALID_PARAMETER - the device parameter is NULL.
	*  @see AMEDIA_ERROR_UNKNOWN - couldn't retrieve the device info.
	*
	* Available since API level 29.
	*/
	AMidiDevice_getNumOutputPorts :: proc(device: ^AMidiDevice) -> int ---

	/**
	* Gets the MIDI device default protocol.
	*
	* @param device Specifies the MIDI device.
	*
	* @return The identifier of the MIDI device default protocol:
	* AMIDI_DEVICE_PROTOCOL_UMP_USE_MIDI_CI
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_1_0_UP_TO_64_BITS
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_1_0_UP_TO_64_BITS_AND_JRTS
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_1_0_UP_TO_128_BITS
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_1_0_UP_TO_128_BITS_AND_JRTS
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_2_0
	* AMIDI_DEVICE_PROTOCOL_UMP_MIDI_2_0_AND_JRTS
	* AMIDI_DEVICE_PROTOCOL_UNKNOWN
	*
	* Most devices should return PROTOCOL_UNKNOWN (-1). This is intentional as devices
	* with default UMP support are not backwards compatible. When the device is null,
	* return AMIDI_DEVICE_PROTOCOL_UNKNOWN.
	*
	* Available since API 33.
	*/
	AMidiDevice_getDefaultProtocol :: proc(device: AMidiDevice) -> AMidiDevice_Protocol ---

	/*
	* API for receiving data from the Output port of a device.
	*/
	/**
	* Opens the output port so that the client can receive data from it. The port remains open and
	* valid until AMidiOutputPort_close() is called for the returned AMidiOutputPort.
	*
	* @param device    Specifies the MIDI device.
	* @param portNumber Specifies the zero-based port index on the device to open. This value ranges
	*                  between 0 and one less than the number of output ports reported by the
	*                  AMidiDevice_getNumOutputPorts function.
	* @param outOutputPortPtr Receives the native API port identifier of the opened port.
	*
	* @return AMEDIA_OK, or a negative error code:
	*  @see AMEDIA_ERROR_UNKNOWN - Unknown Error.
	*
	* Available since API level 29.
	*/
	AMidiOutputPort_open :: proc(device: ^AMidiDevice, portNumber: i32, outOutputPortPtr: ^^AMidiOutputPort) -> media_status_t ---

	/**
	* Closes the output port.
	*
	* @param outputPort    The native API port identifier of the port.
	*
	* Available since API level 29.
	*/
	AMidiOutputPort_close :: proc(outputPort: ^AMidiOutputPort) ---

	/**
	* Receives the next pending MIDI message. To retrieve all pending messages, the client should
	* repeatedly call this method until it returns 0.
	*
	* Note that this is a non-blocking call. If there are no Midi messages are available, the function
	* returns 0 immediately (for 0 messages received).
	*
	* @param outputPort   Identifies the port to receive messages from.
	* @param opcodePtr  Receives the message Op Code.
	* @param buffer    Points to the buffer to receive the message data bytes.
	* @param maxBytes  Specifies the size of the buffer pointed to by the buffer parameter.
	* @param numBytesReceivedPtr  On exit, receives the actual number of bytes stored in buffer.
	* @param outTimestampPtr  If non-NULL, receives the timestamp associated with the message.
	*  (the current value of the running Java Virtual Machine's high-resolution time source,
	*  in nanoseconds)
	* @return the number of messages received (either 0 or 1), or a negative error code:
	*  @see AMEDIA_ERROR_UNKNOWN - Unknown Error.
	*
	* Available since API level 29.
	*/
	AMidiOutputPort_receive :: proc(outputPort: ^AMidiOutputPort, opcodePtr: ^AMidiOpcode, buffer: [^]byte, maxBytes: uint, numBytesReceivedPtr: ^uint, outTimestampPtr: ^i64) -> int ---

	/*
	* API for sending data to the Input port of a device.
	*/
	/**
	* Opens the input port so that the client can send data to it. The port remains open and
	* valid until AMidiInputPort_close() is called for the returned AMidiInputPort.
	*
	* @param device    Specifies the MIDI device.
	* @param portNumber Specifies the zero-based port index on the device to open. This value ranges
	*                  between 0 and one less than the number of input ports reported by the
	*                  AMidiDevice_getNumInputPorts() function..
	* @param outInputPortPtr Receives the native API port identifier of the opened port.
	*
	* @return AMEDIA_OK, or a negative error code:
	*  @see AMEDIA_ERROR_UNKNOWN - Unknown Error.
	*
	* Available since API level 29.
	*/
	AMidiInputPort_open :: proc(device: ^AMidiDevice, portNumber: i32, outInputPortPtr: ^^AMidiInputPort) -> media_status_t ---

	/**
	* Sends data to the specified input port.
	*
	* @param inputPort    The identifier of the port to send data to.
	* @param buffer       Points to the array of bytes containing the data to send.
	* @param numBytes     Specifies the number of bytes to write.
	*
	* @return The number of bytes sent, which could be less than specified or a negative error code:
	* @see AMEDIA_ERROR_INVALID_PARAMETER - The specified port was NULL, the specified buffer was NULL.
	*
	* Available since API level 29.
	*/
	AMidiInputPort_send :: proc(inputPort: ^AMidiInputPort, buffer: [^]byte, numBytes: uint) -> int ---

	/**
	* Sends data to the specified input port with a timestamp.
	*
	* @param inputPort    The identifier of the port to send data to.
	* @param buffer       Points to the array of bytes containing the data to send.
	* @param numBytes     Specifies the number of bytes to write.
	* @param timestamp    The CLOCK_MONOTONIC time in nanoseconds to associate with the sent data.
	*
	* @return The number of bytes sent, which could be less than specified or a negative error code:
	* @see AMEDIA_ERROR_INVALID_PARAMETER - The specified port was NULL, the specified buffer was NULL.
	*
	* Available since API level 29.
	*/
	AMidiInputPort_sendWithTimestamp :: proc(inputPort: ^AMidiInputPort, buffer: [^]byte, numBytes: uint, timestamp: i64) -> int ---

	/**
	* Sends a message with a 'MIDI flush command code' to the specified port. This should cause
	* a receiver to discard any pending MIDI data it may have accumulated and not processed.
	*
	* @param inputPort The identifier of the port to send the flush command to.
	*
	* @returns @see AMEDIA_OK if successful, otherwise a negative error code:
	* @see AMEDIA_ERROR_INVALID_PARAMETER - The specified port was NULL
	* @see AMEDIA_ERROR_UNSUPPORTED - The FLUSH command couldn't
	* be sent.
	*
	* Available since API level 29.
	*/
	AMidiInputPort_sendFlush :: proc(inputPort: ^AMidiInputPort) -> media_status_t ---

	/**
	* Closes the input port.
	*
	* @param inputPort Identifies the input (sending) port to close.
	*
	* Available since API level 29.
	*/
	AMidiInputPort_close :: proc(inputPort: ^AMidiInputPort) ---
}
