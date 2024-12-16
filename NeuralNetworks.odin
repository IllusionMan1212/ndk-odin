package android

foreign import android "system:android"

foreign android {
	/**
	 * Create a {@link ANeuralNetworksMemoryDesc} with no properties.
	 *
	 * This only creates the memory descriptor. Its properties should be set with calls to
	 * {@link ANeuralNetworksMemoryDesc_addInputRole},
	 * {@link ANeuralNetworksMemoryDesc_addOutputRole}, and
	 * {@link ANeuralNetworksMemoryDesc_setDimensions}.
	 *
	 * {@link ANeuralNetworksMemoryDesc_finish} must be called once all properties have been set.
	 *
	 * {@link ANeuralNetworksMemoryDesc_free} must be called once the memory descriptor
	 * is no longer needed.
	 *
	 * Available since NNAPI feature level 4.
	 * Available since API level 30.
	 *
	 * @param desc The {@link ANeuralNetworksMemoryDesc} to be created.
	 *             Set to NULL if unsuccessful.
	 *
	 * @return ANEURALNETWORKS_NO_ERROR if successful.
	 */
	ANeuralNetworksMemoryDesc_create :: proc(desc: ^^ANeuralNetworksMemoryDesc) -> NNResultCode ---

	/**
	* Destroy a memory descriptor.
	*
	* The memory descriptor need not have been finished by a call to
	* {@link ANeuralNetworksMemoryDesc_finish}.
	*
	* See {@link ANeuralNetworksMemoryDesc} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor to be destroyed. Passing NULL is acceptable and
	*             results in no operation.
	*/
	ANeuralNetworksMemoryDesc_free :: proc(desc: ^ANeuralNetworksMemoryDesc) ---

	/**
	* Specify that a memory object will be playing the role of an input to an execution created from a
	* particular compilation.
	*
	* The compilation and the input index fully specify an input operand. This function
	* may be invoked multiple times on the same memory descriptor with different input operands,
	* and the same input operand may be specified on multiple memory descriptors. However,
	* specifying the same input operand on the same memory descriptor more than once will
	* return an error.
	*
	* The dimensions of the corresponding model operands of all the roles specified by
	* {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole} must be compatible with each other. Two
	* dimensions are incompatible if both ranks are fully specified but have different values, or if
	* there is at least one axis that is fully specified in both but has different values.
	*
	* At least one of {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole} must be called on a memory descriptor
	* before invoking {@link ANeuralNetworksMemoryDesc_finish}.
	*
	* Attempting to modify a memory descriptor once {@link ANeuralNetworksMemoryDesc_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksMemoryDesc} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor to be modified.
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}, and must outlive the memory
	*                    descriptor.
	* @param index The index of the input argument we are referencing from the compilation. It is
	*              an index into the inputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param frequency A floating-point value within the range (0.0, 1.0]. Describes how likely the
	*                  memory is to be used in the specified role. This is provided as a hint to
	*                  optimize the case when different roles prefer different memory locations or data
	*                  layouts.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksMemoryDesc_addInputRole :: proc(desc: ^ANeuralNetworksMemoryDesc, compilation: ^ANeuralNetworksCompilation, index: u32, frequency: f32) -> NNResultCode ---

	/**
	* Specify that a memory object will be playing the role of an output to an execution created from a
	* particular compilation.
	*
	* The compilation and the output index fully specify an output operand. This function
	* may be invoked multiple times on the same memory descriptor with different output operands,
	* and the same output operand may be specified on multiple memory descriptors. However,
	* specifying the same output operand on the same memory descriptor object more than once will
	* return an error.
	*
	* The dimensions of the corresponding model operands of all the roles specified by
	* {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole} must be compatible with each other. Two
	* dimensions are incompatible if both ranks are fully specified but have different values, or if
	* there is at least one axis that is fully specified in both but has different values.
	*
	* At least one of {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole} must be called on the memory descriptor
	* before invoking {@link ANeuralNetworksMemoryDesc_finish}.
	*
	* Attempting to modify a memory descriptor once {@link ANeuralNetworksMemoryDesc_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksMemoryDesc} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor to be modified.
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}, and must outlive the memory
	*                    descriptor.
	* @param index The index of the output argument we are referencing from the compilation. It is
	*              an index into the outputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param frequency A floating-point value within the range (0.0, 1.0]. Describes how likely the
	*                  memory is to be used in the specified role. This is provided as a hint to
	*                  optimize the case when multiple roles prefer different memory locations or data
	*                  layouts.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksMemoryDesc_addOutputRole :: proc(desc: ^ANeuralNetworksMemoryDesc, compilation: ^ANeuralNetworksCompilation, index: u32, frequency: f32) -> NNResultCode ---

	/**
	* Set the dimensional information of the memory descriptor.
	*
	* The specified dimensions must be compatible with the dimensions of the corresponding model
	* operands of all the roles specified by {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole}. Two dimensions are incompatible if both ranks
	* are fully specified but have different values, or if there is at least one axis that is fully
	* specified in both but has different values.
	*
	* Attempting to modify a memory descriptor once {@link ANeuralNetworksMemoryDesc_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksMemoryDesc} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor to be modified.
	* @param rank The number of dimensions. Must be 0 for scalars.
	* @param dimensions An array of dimensions. An entry with the value 0 indicates that the
	*                   corresponding axis has an unknown size.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksMemoryDesc_setDimensions :: proc(desc: ^ANeuralNetworksMemoryDesc, rank: u32, dimensions: [^]u32) -> NNResultCode ---

	/**
	* Indicate that we have finished modifying a memory descriptor. Required before calling
	* {@link ANeuralNetworksMemory_createFromDesc}.
	*
	* This function must only be called once for a given memory descriptor.
	*
	* See {@link ANeuralNetworksMemoryDesc} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor to be finished.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksMemoryDesc_finish :: proc(desc: ^ANeuralNetworksMemoryDesc) -> NNResultCode ---

	/**
	* Creates a memory object from a memory descriptor.
	*
	* The memory object is created with an uninitialized buffer. A memory object with an uninitialized
	* buffer may only be used according to the roles specified by {@link
	* ANeuralNetworksMemoryDesc_addOutputRole}, or as the destination memory in {@link
	* ANeuralNetworksMemory_copy}. The buffer of a memory object is initialized after the memory object
	* is used as an output in a successful execution, or used as the destination memory in a successful
	* {@link ANeuralNetworksMemory_copy}. A memory object with an initialized buffer may be used
	* according to all roles specified in {@link ANeuralNetworksMemoryDesc}, or as the source or
	* destination memory in {@link ANeuralNetworksMemory_copy}. The buffer of a memory object will
	* return to the uninitialized state if the memory object is used as an output in a failed
	* execution, or used as the destination memory in a failed {@link ANeuralNetworksMemory_copy}.
	*
	* The dimensions of the memory descriptor are deduced from the dimensions of the corresponding
	* model operands of all the roles specified by {@link ANeuralNetworksMemoryDesc_addInputRole} and
	* {@link ANeuralNetworksMemoryDesc_addOutputRole}, as well as the dimensions set by the call to
	* {@link ANeuralNetworksMemoryDesc_setDimensions}, if any. The memory descriptor may have
	* unspecified dimensions or rank. In such a case, the same memory object may be used with different
	* shapes of outputs in different executions. When the memory is used as an input, the input shape
	* must be the same as the output shape from the last execution using this memory object as an
	* output, or the last {@link ANeuralNetworksMemory_copy} using this memory object as the
	* destination memory. Creating a memory object with unspecified dimensions or rank may fail for
	* certain sets of roles.
	*
	* Using the memory in roles or shapes that are not compatible with the rules specified above will
	* return an error.
	*
	* When calling {@link ANeuralNetworksExecution_setInputFromMemory} or
	* {@link ANeuralNetworksExecution_setOutputFromMemory} with the memory object,
	* both offset and length must be set to zero and the entire memory region will be
	* associated with the specified input or output operand.
	*
	* Calling {@link ANeuralNetworksModel_setOperandValueFromMemory} with the memory created from this
	* function will return an error.
	*
	* {@link ANeuralNetworksMemory_free} must be called once the memory is no longer needed.
	*
	* Attempting to create memory from an unfinished memory descriptor will return an error.
	*
	* The provided {@link ANeuralNetworksMemoryDesc} need not outlive the {@link ANeuralNetworksMemory}
	* object.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param desc The memory descriptor.
	* @param memory The memory object to be created.
	*               Set to NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful ANEURALNETWORKS_OP_FAILED if the memory is
	*         created with unspecified dimensions or rank and it is not supported for this set of
	*         roles.
	*/
	ANeuralNetworksMemory_createFromDesc :: proc(desc: ^ANeuralNetworksMemoryDesc, memory: ^^ANeuralNetworksMemory) -> NNResultCode ---

	/**
	* Copies data from one memory object to another.
	*
	* If at most one of the src and dst is created from {@link ANeuralNetworksMemory_createFromDesc},
	* the src and dst must have the same logical size:
	* - If the memory is created from {@link ANeuralNetworksMemory_createFromFd}, or if it is created
	*   from {@link ANeuralNetworksMemory_createFromAHardwareBuffer} with format of
	*   AHARDWAREBUFFER_FORMAT_BLOB, the logical size equals the size of the memory.
	* - If the memory is created from {@link ANeuralNetworksMemory_createFromAHardwareBuffer} with a
	*   format other than AHARDWAREBUFFER_FORMAT_BLOB, the logical size equals the size when there is
	*   no padding and the data is tightly packed. This function may fail if the AHardwareBuffer
	*   cannot be accessed.
	* - If the memory is created from {@link ANeuralNetworksMemory_createFromDesc}, the logical size
	*   equals the size indicated by the {@link OperandCode} multiplied by the number of elements. This
	*   function will fail if the number of elements is unknown.
	*
	* If both src and dst are created from {@link ANeuralNetworksMemory_createFromDesc}, they must have
	* compatible dimensions. Two dimensions are incompatible if both ranks are fully specified but
	* have different values, or if there is at least one axis that is fully specified in both but has
	* different values. The dst may have unspecified dimensions or rank. In such a case, the dimensions
	* of dst will get updated according to the dimensions of the src.
	*
	* In both cases, if the src is created from {@link ANeuralNetworksMemory_createFromDesc}, it must
	* have been used as an output in a successful execution, or used as the destination memory in a
	* successful {@link ANeuralNetworksMemory_copy}.
	*
	* The src and dst may have different data layout, in which case the data copying is performed
	* logically with data layout transformation.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param src The source memory object.
	* @param dst The destination memory object.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksMemory_copy :: proc(src: ^ANeuralNetworksMemory, dst: ^ANeuralNetworksMemory) -> NNResultCode ---

	/**
	* Get the number of available devices.
	*
	* @param numDevices Used to return the number of devices.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworks_getDeviceCount :: proc(numDevices: ^u32) -> NNResultCode ---

	/**
	* Get the representation of the specified device.
	*
	* @param devIndex The index of the specified device. Must be less than the
	number of available devices.
	* @param device The representation of the specified device.
	*               The same representation will always be returned for the specified
	*               device.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworks_getDevice :: proc(devIndex: u32, device: ^^ANeuralNetworksDevice) -> NNResultCode ---

	/**
	* Get the name of the specified device.
	*
	* @param device The representation of the specified device.
	* @param name   The returned name of the specified device. The name will be in UTF-8
	*               and will be null-terminated. It will be recognizable as a known device name
	*               rather than a cryptic string. For devices with feature level reported by
	*               {@link ANeuralNetworksDevice_getFeatureLevel} that is
	*               {@link ANEURALNETWORKS_FEATURE_LEVEL_3} and higher, the format of the name is
	*               {VENDOR}-{DEVICE}. For devices with feature level
	*               {@link ANEURALNETWORKS_FEATURE_LEVEL_2} or lower, the format of the name is
	*               undefined. The name will remain valid for the duration of the application.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksDevice_getName :: proc(device: ^ANeuralNetworksDevice, name: ^cstring) -> NNResultCode ---

	/**
	* Get the type of a given device.
	*
	* The device type can be used to help application developers to distribute Machine Learning
	* workloads and other workloads such as graphical rendering.
	* E.g., for an app which renders AR scenes based on real time object detection results,
	* the developer could choose an ACCELERATOR type device for ML workloads, and reserve GPU
	* for graphical rendering.
	*
	* @param device The representation of the specified device.
	* @param type The returned {@link DeviceTypeCode} of the specified device.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksDevice_getType :: proc(device: ^ANeuralNetworksDevice, type: ^DeviceTypeCode) -> NNResultCode ---

	/**
	* Get the version of the driver implementation of the specified device.
	*
	* It’s the responsibility of the driver implementor to insure that this version string
	* uniquely distinguishes this implementation from all previous implementations.
	*
	* This version string must not be confused with the feature level which is solely defined
	* by {@link ANeuralNetworksDevice_getFeatureLevel}. There is no implicit ordering of the versions.
	* For example, it is not possible to filter all drivers older than a certain version.
	*
	* Application developers may use this version string to avoid or prefer specific driver
	* implementations. For example, an application may want to do so because:
	*     - A specific version of the driver does not provide the required performance,
	*       perhaps because of a performance regression.
	*     - A specific version of the driver has a bug or returns results that don’t match
	*       the minimum precision requirement for the application.
	*
	* @param device The representation of the specified device.
	* @param version The returned version string of the driver for the specified device. The
	*                string will be in UTF-8 and will be null-terminated. For devices with feature
	*                level 28 or lower, "UNKNOWN" will be returned. The version string will remain
	*                valid for the duration of the application.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksDevice_getVersion :: proc(device: ^ANeuralNetworksDevice, version: ^cstring) -> NNResultCode ---

	/**
	* Get the NNAPI feature level of the specified NNAPI device.
	*
	* Each device has a supported feature level, which is the most advanced NNAPI specification
	* and features this driver implements. For example, if the driver implements the features
	* introduced in {@link ANEURALNETWORKS_FEATURE_LEVEL_2}, but does not implement the features
	* introduced after {@link ANEURALNETWORKS_FEATURE_LEVEL_2}, the value would be
	* {@link ANEURALNETWORKS_FEATURE_LEVEL_2}. Developers could decide whether or not the specified
	* device should be used for a model that has certain feature requirements.
	*
	* NNAPI device feature level is closely related to NNAPI runtime feature level
	* ({@link ANeuralNetworks_getRuntimeFeatureLevel}), which indicates an NNAPI runtime feature
	* level (the most advanced NNAPI specification and features that the runtime implements).
	* An NNAPI device feature level is always less than or equal to the runtime feature level.
	*
	* This function produces a {@link FeatureLevelCode} enum value, NOT an Android API level.
	*
	* @param device The representation of the specified device.
	* @param featureLevel {@link FeatureLevelCode} of the most advanced feature this driver implements.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksDevice_getFeatureLevel :: proc(device: ^ANeuralNetworksDevice, featureLevel: ^FeatureLevelCode) -> NNResultCode ---

	/**
	* Wait until the device is in a live state.
	*
	* A device may encounter internal errors and temporarily enter a dead state. A
	* call that uses a device in such a state will return with the error
	* {@link ANEURALNETWORKS_DEAD_OBJECT}. ANeuralNetworksDevice_wait will block until
	* the device is in a live state.
	*
	* @param device The representation of the specified device.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksDevice_wait :: proc(device: ^ANeuralNetworksDevice) -> NNResultCode ---

	/**
	* Get the supported operations for a specified set of devices. If multiple devices
	* are selected, the supported operation list is a union of supported operations of all
	* selected devices.
	*
	* @param model The model to be queried.
	* @param devices The set of devices. Must not contain duplicates.
	* @param numDevices The number of devices in the set.
	* @param supportedOps The boolean array to be filled. True means supported. The size of the
	*                     boolean array must be at least as large as the number of operations
	*                     in the model. The order of elements in the supportedOps array matches
	*                     the order in which the corresponding operations were added to the model.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksModel_getSupportedOperationsForDevices :: proc(model: ^ANeuralNetworksModel, devices: [^]^ANeuralNetworksDevice, numDevices: u32, supportedOps: [^]bool) -> NNResultCode ---

	/**
	* Create a {@link ANeuralNetworksCompilation} to compile the given model for a specified set
	* of devices. If more than one device is specified, the compilation will
	* distribute the workload automatically across the devices. The model must be fully
	* supported by the specified set of devices. This means that
	* ANeuralNetworksModel_getSupportedOperationsForDevices() must have returned true for every
	* operation for that model/devices pair.
	*
	* The user must handle all compilation and execution failures from the
	* specified set of devices. This is in contrast to a use of {@link
	* ANeuralNetworksCompilation_create}, where the runtime will attempt to recover
	* from such failures.
	*
	* The model passed to this function is termed the "main model" of the
	* compilation, to distinguish it from other models referred to by an Operand
	* of type {@link ANEURALNETWORKS_MODEL} within this compilation.
	*
	* @param model The {@link ANeuralNetworksModel} to be compiled.
	* @param devices The set of devices. Must not contain duplicates.
	* @param numDevices The number of devices in the set.
	* @param compilation The newly created object or NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA
	*         if the model is invalid.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksCompilation_createForDevices :: proc(model: ^ANeuralNetworksModel, devices: [^]^ANeuralNetworksDevice, numDevices: u32, compilation: ^^ANeuralNetworksCompilation) -> NNResultCode ---

	/**
	* Sets the compilation caching signature and the cache directory.
	*
	* Provides optional caching information to the runtime for faster repeated
	* compilation.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* @param compilation The compilation to be modified.
	* @param cacheDir The cache directory for the runtime to store and retrieve caching
	*                 data. It is recommended to use the code cache directory provided
	*                 by the Android runtime. If not using the code cache directory, the
	*                 user should choose a directory local to the application, and is
	*                 responsible for managing the cache entries.
	* @param token The token provided by the user to specify a model must be of length
	*              ANEURALNETWORKS_BYTE_SIZE_OF_CACHE_TOKEN. The user should ensure that
	*              the token is unique to a model within the application. The NNAPI
	*              runtime cannot detect token collisions a collision will result in a
	*              failed execution or in a successful execution that produces incorrect
	*              output values.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksCompilation_setCaching :: proc(compilation: ^ANeuralNetworksCompilation, cacheDir: cstring, token: [^]byte) -> NNResultCode ---

	/**
	* Schedule synchronous evaluation of the execution.
	*
	* <p>Schedules synchronous evaluation of the execution. Returns once the
	* execution has completed and the outputs are ready to be consumed.
	* </p>
	*
	* If {@link ANeuralNetworksExecution_setTimeout} was called on this execution,
	* and the execution is not able to complete before the timeout duration is
	* exceeded, then execution may be aborted, in which case
	* ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be returned. If the device has
	* a feature level reported by {@link ANeuralNetworksDevice_getFeatureLevel}
	* that is lower than 30, then the timeout duration hint will be ignored.
	*
	* If this execution contains a {@link ANEURALNETWORKS_WHILE} operation, and
	* the condition model does not output false within the loop timeout duration,
	* then execution will be aborted and ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}
	* will be returned.
	*
	* Before NNAPI feature level 5, this function may only be invoked when the execution is in the
	* preparation state. Starting at NNAPI feature level 5, if the user sets the execution to be
	* reusable by {@link ANeuralNetworksExecution_setReusable}, this function may also be invoked when
	* the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* See {@link ANeuralNetworksExecution_burstCompute} for burst synchronous execution.
	* See {@link ANeuralNetworksExecution_startCompute} for regular asynchronous execution.
	* See {@link ANeuralNetworksExecution_startComputeWithDependencies} for
	* asynchronous execution with dependencies.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param execution The execution to be scheduled and executed.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the execution completed normally.
	*         ANEURALNETWORKS_UNMAPPABLE if the execution input or output memory cannot
	*         be properly mapped.
	*/
	ANeuralNetworksExecution_compute :: proc(execution: ^ANeuralNetworksExecution) -> NNResultCode ---

	/**
	* Get the dimensional information of the specified output operand of the model of the
	* latest computation evaluated on {@link ANeuralNetworksExecution}.
	*
	* This function may only be invoked when the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states.
	*
	* @param execution The execution to be queried.
	* @param index The index of the output argument we are querying. It is
	*              an index into the lists passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param rank The rank of the output operand.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_OUTPUT_INSUFFICIENT_SIZE
	*         if the target output is provided an insufficient buffer at execution time,
	*         ANEURALNETWORKS_BAD_DATA if the index is invalid.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksExecution_getOutputOperandRank :: proc(execution: ^ANeuralNetworksExecution, index: i32, rank: ^u32) -> NNResultCode ---

	/**
	* Get the dimensional information of the specified output operand of the model of the
	* latest computation evaluated on {@link ANeuralNetworksExecution}. The target output operand
	* cannot be a scalar.
	*
	* This function may only be invoked when the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states.
	*
	* @param execution The execution to be queried.
	* @param index The index of the output argument we are querying. It is an index into the lists
	*              passed to {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param dimensions The dimension array to be filled. The size of the array must be exactly as
	*                   large as the rank of the output operand to be queried in the model.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_OUTPUT_INSUFFICIENT_SIZE
	*         if the target output is provided an insufficient buffer at execution time,
	*         ANEURALNETWORKS_BAD_DATA if the index is invalid or if the target is a scalar.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksExecution_getOutputOperandDimensions :: proc(execution: ^ANeuralNetworksExecution, index: i32, dimensions: [^]u32) -> NNResultCode ---

	/**
	* Create a {@link ANeuralNetworksBurst} to apply the given compilation.
	* This only creates the burst object. Computation is only performed once
	* {@link ANeuralNetworksExecution_burstCompute} is invoked with a valid
	* {@link ANeuralNetworksExecution} and {@link ANeuralNetworksBurst}.
	*
	* <p>The provided compilation must outlive the burst object.</p>
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param compilation The {@link ANeuralNetworksCompilation} to be evaluated.
	* @param burst The newly created object or NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA
	*         if the compilation is invalid.
	*/
	ANeuralNetworksBurst_create :: proc(compilation: ^ANeuralNetworksCompilation, burst: ^^ANeuralNetworksBurst) -> NNResultCode ---

	/**
	* Destroys the burst object.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param burst The burst object to be destroyed. Passing NULL is acceptable and
	*              results in no operation.
	*/
	ANeuralNetworksBurst_free :: proc(burst: ^ANeuralNetworksBurst) ---

	/**
	* Schedule synchronous evaluation of the execution on a burst object.
	*
	* <p>Schedules synchronous evaluation of the execution. Returns once the
	* execution has completed and the outputs are ready to be consumed.</p>
	*
	* If {@link ANeuralNetworksExecution_setTimeout} was called on the execution,
	* and the execution is not able to complete before the timeout duration is
	* exceeded, then execution may be aborted, in which case
	* ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be returned.
	*
	* If the execution contains a {@link ANEURALNETWORKS_WHILE} operation, and
	* the condition model does not output false within the loop timeout duration,
	* then execution will be aborted and ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}
	* will be returned. If the device has a feature level reported by
	* {@link ANeuralNetworksDevice_getFeatureLevel} that is lower than
	* {@link ANEURALNETWORKS_FEATURE_LEVEL_4}, then the timeout duration hint will be ignored.
	*
	* <p>There must be at most one {@link ANeuralNetworksExecution} processing at
	* any given time for any given burst object. Any
	* {@link ANeuralNetworksExecution} launched before the previous has finished
	* will result in ANEURALNETWORKS_BAD_STATE.</p>
	*
	* Before NNAPI feature level 5, this function may only be invoked when the execution is in the
	* preparation state. Starting at NNAPI feature level 5, if the user sets the execution to be
	* reusable by {@link ANeuralNetworksExecution_setReusable}, this function may also be invoked when
	* the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* See {@link ANeuralNetworksExecution_compute} for synchronous execution.
	* See {@link ANeuralNetworksExecution_startCompute} for regular asynchronous execution.
	* See {@link ANeuralNetworksExecution_startComputeWithDependencies} for
	* asynchronous execution with dependencies.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param burst The burst object to execute on.
	* @param execution The execution to be scheduled and executed. The execution
	*                  must be created from the same {@link
	*                  ANeuralNetworksCompilation} as the burst object.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the execution completed normally.
	*/
	ANeuralNetworksExecution_burstCompute :: proc(execution: ^ANeuralNetworksExecution, burst: ^ANeuralNetworksBurst) -> NNResultCode ---

	/**
	* Creates a shared memory object from an AHardwareBuffer handle.
	*
	* If the shared memory is backed by an AHardwareBuffer of AHARDWAREBUFFER_FORMAT_BLOB
	* format, it can be used the same way as shared memory created from a file handle. See
	* {@link ANeuralNetworksMemory} for a description on how to use this shared memory.
	*
	* If the shared memory is backed by an AHardwareBuffer of a format other than
	* AHARDWAREBUFFER_FORMAT_BLOB, it can only be used for model inputs and outputs.
	* When calling {@link ANeuralNetworksExecution_setInputFromMemory} or
	* {@link ANeuralNetworksExecution_setOutputFromMemory} with the shared memory, both
	* offset and length must be set to zero and the entire memory region will be
	* associated with the specified input or output operand. There is no guarantee
	* that an arbitrary AHardwareBuffer_Format and AHardwareBuffer_UsageFlags combination
	* can be used by arbitrary devices. The execution will fail if the selected set of
	* devices cannot consume the buffer.
	*
	* Calling {@link ANeuralNetworksModel_setOperandValueFromMemory} with shared memory
	* backed by an AHardwareBuffer of a format other than AHARDWAREBUFFER_FORMAT_BLOB is
	* disallowed.
	*
	* The provided AHardwareBuffer must outlive the ANeuralNetworksMemory object.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param ahwb The AHardwareBuffer handle.
	* @param memory The memory object to be created.
	*               Set to NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the request completed normally.
	*
	* @see AHardwareBuffer
	*/
	ANeuralNetworksMemory_createFromAHardwareBuffer :: proc(ahwb: ^AHardwareBuffer, memory: ^^ANeuralNetworksMemory) -> NNResultCode ---

	/**

	* Specifies whether duration of the {@link ANeuralNetworksExecution} is to be
	* measured. Evaluation of the execution must not have been scheduled.
	*
	* By default, duration is not measured.
	*
	* The {@link ANeuralNetworksExecution} must have been created from an
	* {@link ANeuralNetworksCompilation} which in turn was created from
	* {@link ANeuralNetworksCompilation_createForDevices} with numDevices = 1.
	* If the device has a feature level reported by
	* {@link ANeuralNetworksDevice_getFeatureLevel} that is lower than
	* {@link ANEURALNETWORKS_FEATURE_LEVEL_3}, then the duration will not be measured.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param execution The execution to be modified.
	* @param measure 'true' if duration is to be measured, 'false' if not.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksExecution_setMeasureTiming :: proc(execution: ^ANeuralNetworksExecution, measure: bool) -> NNResultCode ---

	/**
	* Get the time spent in the latest computation evaluated on the specified
	* {@link ANeuralNetworksExecution}, in nanoseconds.
	*
	* This function may only be invoked when the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states.
	*
	* @param execution The execution to be queried.
	* @param durationCode The measurement to be queried, specified by {@link DurationCode}.
	* @param duration The returned duration. If no measurement was requested by
	*                 {@link ANeuralNetworksExecution_setMeasureTiming}, if the
	*                 device is has a feature level reported by
	*                 {@link ANeuralNetworksDevice_getFeatureLevel} that is lower
	*                 than {@link ANEURALNETWORKS_FEATURE_LEVEL_3}, or for some other
	*                 reason the duration is not available, UINT64_MAX will be returned.
	*                 A particular device need not support any given measurement.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*/
	ANeuralNetworksExecution_getDuration :: proc(execution: ^ANeuralNetworksExecution, durationCode: DurationCode, duration: ^u64) -> NNResultCode ---

	/**
	* Creates a shared memory object from a file descriptor.
	*
	* The shared memory is backed by a file descriptor via mmap.
	* See {@link ANeuralNetworksMemory} for a description on how to use
	* this shared memory.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param size The requested size in bytes.
	*             Must not be larger than the file size.
	* @param protect The desired memory protection for the mapping.
	*             It is either PROT_NONE or the bitwise OR of one or
	*             more of the following flags: PROT_READ, PROT_WRITE.
	* @param fd The requested file descriptor.
	*           The file descriptor has to be mmap-able. The file
	*           descriptor will be duplicated.
	* @param offset The offset to the beginning of the file of the area to map.
	*               The offset has to be aligned to a page size.
	* @param memory The memory object to be created.
	*               Set to NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the request completed normally.
	*/
	ANeuralNetworksMemory_createFromFd :: proc(size: uint, protect: i32, fd: i32, offset: uint, memory: ^^ANeuralNetworksMemory) -> NNResultCode ---

	/**
	* Delete a memory object.
	*
	* Destroys the object used by the run time to keep track of the memory.
	* This will free the underlying actual memory if no other code has open
	* handles to this memory.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param memory The memory object to be freed. Passing NULL is acceptable and
	*               results in no operation.
	*/
	ANeuralNetworksMemory_free :: proc(memory: ^ANeuralNetworksMemory) ---

	/**
	* Create an empty {@link ANeuralNetworksModel}.
	*
	* <p>This only creates the object. Computation is performed once
	* {@link ANeuralNetworksExecution_burstCompute},
	* {@link ANeuralNetworksExecution_compute},
	* {@link ANeuralNetworksExecution_startCompute} or
	* {@link ANeuralNetworksExecution_startComputeWithDependencies} is invoked.
	*
	* The model should be constructed with calls to
	* {@link ANeuralNetworksModel_addOperation} and
	* {@link ANeuralNetworksModel_addOperand}
	*
	* <p>{@link ANeuralNetworksModel_finish} should be called once the model
	* has been fully constructed.</p>
	*
	* <p>{@link ANeuralNetworksModel_free} should be called once the model
	* is no longer needed.</p>
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The {@link ANeuralNetworksModel} to be created.
	*              Set to NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_create :: proc(model: ^^ANeuralNetworksModel) -> NNResultCode ---

	/**
	* Destroy a model.
	*
	* The model need not have been finished by a call to
	* {@link ANeuralNetworksModel_finish}.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The model to be destroyed. Passing NULL is acceptable and
	*              results in no operation.
	*/
	ANeuralNetworksModel_free :: proc(model: ^ANeuralNetworksModel) ---

	/**
	* Indicate that we have finished modifying a model. Required before
	* calling {@link ANeuralNetworksCompilation_create} and
	* {@link ANeuralNetworksCompilation_createForDevices}.
	*
	* An application must ensure that no other thread uses the model at the same
	* time.
	*
	* This function must only be called once for a given model.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The model to be finished.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_finish :: proc(model: ^ANeuralNetworksModel) -> NNResultCode ---

	/**
	* Add an operand to a model.
	*
	* The order in which the operands are added is important. The first one added
	* to a model will have the index value 0, the second 1, etc. These indexes are
	* used as operand identifiers in
	* {@link ANeuralNetworksModel_addOperation},
	* {@link ANeuralNetworksModel_identifyInputsAndOutputs},
	* {@link ANeuralNetworksModel_setOperandValue},
	* {@link ANeuralNetworksModel_setOperandValueFromMemory},
	* {@link ANeuralNetworksExecution_setInput},
	* {@link ANeuralNetworksExecution_setInputFromMemory},
	* {@link ANeuralNetworksExecution_setOutput}, and
	* {@link ANeuralNetworksExecution_setOutputFromMemory}.
	*
	* <p>Every operand must be referenced in exactly one of the following
	* ways:<ul>
	*    <li>It is identified as a model input with
	*        {@link ANeuralNetworksModel_identifyInputsAndOutputs}.</li>
	*    <li>It is identified as a constant with
	*        {@link ANeuralNetworksModel_setOperandValue} or
	*        {@link ANeuralNetworksModel_setOperandValueFromMemory}.</li>
	*    <li>It is identified as an output of exactly one operation with
	*        {@link ANeuralNetworksModel_addOperation}.</li>
	*    </ul></p>
	* <p>An operand that is identified as a model input or as a constant
	* must not also be identified as a model output with
	* {@link ANeuralNetworksModel_identifyInputsAndOutputs}.</p>
	*
	* To build a model that can accommodate inputs of various sizes, as
	* you may want to do for a CNN, leave unspecified the dimensions that
	* will vary at run time.  If you do so, fully specify dimensions
	* when calling {@link ANeuralNetworksExecution_setInput} or
	* {@link ANeuralNetworksExecution_setInputFromMemory}.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The model to be modified.
	* @param type The {@link ANeuralNetworksOperandType} that describes the shape
	*             of the operand.  Neither the {@link ANeuralNetworksOperandType}
	*             nor the dimensions it points to need to outlive the call to
	*             {@link ANeuralNetworksModel_addOperand}.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_addOperand :: proc(model: ^ANeuralNetworksModel, type: ^ANeuralNetworksOperandType) -> NNResultCode ---

	/**
	* Sets an operand to a constant value.
	*
	* Values of length smaller or equal to
	* ANEURALNETWORKS_MAX_SIZE_OF_IMMEDIATELY_COPIED_VALUES
	* are immediately copied into the model.
	*
	* For values of length greater than
	* ANEURALNETWORKS_MAX_SIZE_OF_IMMEDIATELY_COPIED_VALUES, a pointer to
	* the buffer is stored within the model. The application must not change the
	* content of this region until all executions using this model have
	* completed. As the data may be copied during processing, modifying the data
	* after this call yields undefined results. The provided buffer must outlive
	* this model.
	*
	* For large tensors, using {@link ANeuralNetworksModel_setOperandValueFromMemory}
	* is likely to be more efficient.
	*
	* To indicate that an optional operand should be considered missing,
	* pass nullptr for buffer and 0 for length.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The model to be modified.
	* @param index The index of the model operand we're setting.
	* @param buffer A pointer to the data to use.
	* @param length The size in bytes of the data value.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_setOperandValue :: proc(model: ^ANeuralNetworksModel, index: i32, buffer: rawptr, length: uint) -> NNResultCode ---

	/**
	* Sets an operand's per channel quantization parameters.
	*
	* Sets parameters required by a tensor of type
	* {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL}.
	* This function must be called for every tensor of type
	* {@link ANEURALNETWORKS_TENSOR_QUANT8_SYMM_PER_CHANNEL} before
	* calling {@link ANeuralNetworksModel_finish}.
	*
	* Available since NNAPI feature level 3.
	* Available since API level 29.
	*
	* @param model The model to be modified.
	* @param index The index of the model operand we're setting.
	* @param channelQuant The per channel quantization parameters for the operand.
	*                    No memory in this struct needs to outlive the call to
	*                    this function.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_setOperandSymmPerChannelQuantParams :: proc(model: ^ANeuralNetworksModel, index: i32, channelQuant: ^ANeuralNetworksSymmPerChannelQuantParams) -> NNResultCode ---

	/**
	* Sets an operand to a value stored in a memory object.
	*
	* The content of the memory is not copied. A reference to that memory is stored
	* inside the model. The application must not change the content of the memory
	* region until all executions using this model have completed.  As the data may
	* be copied during processing, modifying the data after this call yields
	* undefined results.
	*
	* <p>The provided memory must outlive this model.</p>
	*
	* To indicate that an optional operand should be considered missing,
	* use {@link ANeuralNetworksModel_setOperandValue} instead, passing nullptr for buffer.
	*
	* It is disallowed to set an operand value with shared memory backed by an AHardwareBuffer
	* of a format other than AHARDWAREBUFFER_FORMAT_BLOB.
	*
	* It is disallowed to set an operand value with memory created from
	* {@link ANeuralNetworksMemory_createFromDesc}.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	* See {@link ANeuralNetworksMemory_createFromAHardwareBuffer} for information on
	* AHardwareBuffer usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The model to be modified.
	* @param index The index of the model operand we're setting.
	* @param memory The memory containing the data.
	* @param offset This specifies the location of the data within the memory.
	*               The offset is in bytes from the start of memory.
	* @param length The size in bytes of the data value.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_setOperandValueFromMemory :: proc(model: ^ANeuralNetworksModel, index: i32, memory: ^ANeuralNetworksMemory, offset: uint, length: uint) -> NNResultCode ---

	/**
	* Sets an operand to a value that is a reference to another NNAPI model.
	*
	* The referenced model must already have been finished by a call to
	* {@link ANeuralNetworksModel_finish}.
	*
	* The {@link ANeuralNetworksModel_relaxComputationFloat32toFloat16} setting of
	* referenced models is overridden by that setting of the main model of a
	* compilation.
	*
	* The referenced model must outlive the model referring to it.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has
	* been called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param model The model to be modified.
	* @param index The index of the model operand we're setting.
	* @param value The model to be referenced.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_setOperandValueFromModel :: proc(model: ^ANeuralNetworksModel, index: i32, value: ^ANeuralNetworksModel) -> NNResultCode ---

	/**
	* Add an operation to a model.
	*
	* @param model The model to be modified.
	* @param type The {@link ANeuralNetworksOperationType} of the operation.
	* @param inputCount The number of entries in the inputs array.
	* @param inputs An array of indexes identifying each operand.
	* @param outputCount The number of entries in the outputs array.
	* @param outputs An array of indexes identifying each operand.
	*
	* The operands specified by inputs and outputs must have been
	* previously added by calls to {@link ANeuralNetworksModel_addOperand}.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksModel_addOperation :: proc(model: ^ANeuralNetworksModel, type: ANeuralNetworksOperationType, inputCount: u32, inputs: [^]u32, outputCount: u32, outputs: [^]u32) -> NNResultCode ---

	/**
	* Specifies which operands will be the model's inputs and
	* outputs. Every model must have at least one input and one output.
	*
	* An operand cannot be used for both input and output. Doing so will
	* return an error.
	*
	* @param model The model to be modified.
	* @param inputCount The number of entries in the inputs array.
	* @param inputs An array of indexes identifying the input operands.
	* @param outputCount The number of entries in the outputs array.
	* @param outputs An array of indexes identifying the output operands.
	*
	* The operands specified by inputs and outputs must have been
	* previously added by calls to {@link ANeuralNetworksModel_addOperand}.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	*/
	ANeuralNetworksModel_identifyInputsAndOutputs :: proc(model: ^ANeuralNetworksModel, inputCount: u32, inputs: [^]u32, outputCount: u32, outputs: [^]u32) -> NNResultCode ---

	/**
	* Specifies whether {@link ANEURALNETWORKS_TENSOR_FLOAT32} is allowed to be
	* calculated with range and/or precision as low as that of the IEEE 754 16-bit
	* floating-point format. By default, {@link ANEURALNETWORKS_TENSOR_FLOAT32}
	* must be calculated using at least the range and precision of the IEEE 754
	* 32-bit floating-point format.
	*
	* The relaxComputationFloat32toFloat16 setting of the main model of
	* a compilation overrides the values of the referenced models.
	*
	* @param model The model to be modified.
	* @param allow 'true' indicates {@link ANEURALNETWORKS_TENSOR_FLOAT32} may be
	*              calculated with range and/or precision as low as that of the
	*              IEEE 754 16-bit floating point format. 'false' indicates
	*              {@link ANEURALNETWORKS_TENSOR_FLOAT32} must be calculated using
	*              at least the range and precision of the IEEE 754 32-bit floating
	*              point format.
	*
	* Attempting to modify a model once {@link ANeuralNetworksModel_finish} has been
	* called will return an error.
	*
	* Available since NNAPI feature level 2.
	* Available since API level 28.
	*
	* See {@link ANeuralNetworksModel} for information on multithreaded usage.
	*/
	ANeuralNetworksModel_relaxComputationFloat32toFloat16 :: proc(model: ^ANeuralNetworksModel, allow: bool) -> NNResultCode ---

	/**
	* Create a {@link ANeuralNetworksCompilation} to compile the given model.
	*
	* The model passed to this function is termed the "main model" of the
	* compilation, to distinguish it from other models referred to by an Operand
	* of type {@link ANEURALNETWORKS_MODEL} within this compilation.
	*
	* <p>This function only creates the object. Compilation is only performed once
	* {@link ANeuralNetworksCompilation_finish} is invoked.</p>
	*
	* <p>{@link ANeuralNetworksCompilation_finish} should be called once
	* all desired properties have been set on the compilation.</p>
	*
	* <p>{@link ANeuralNetworksModel_free} should be called once the compilation
	* is no longer needed.</p>
	*
	* <p>The provided model must outlive the compilation.</p>
	*
	* The model must already have been finished by a call to
	* {@link ANeuralNetworksModel_finish}.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param model The {@link ANeuralNetworksModel} to be compiled.
	* @param compilation The newly created object or NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA
	*         if the model is invalid.
	*/
	ANeuralNetworksCompilation_create :: proc(model: ^ANeuralNetworksModel, compilation: ^^ANeuralNetworksCompilation) -> NNResultCode ---

	/**
	* Destroy a compilation.
	*
	* The compilation need not have been finished by a call to
	* {@link ANeuralNetworksCompilation_finish}.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param compilation The compilation to be destroyed. Passing NULL is acceptable and
	*                    results in no operation.
	*/
	ANeuralNetworksCompilation_free :: proc(compilation: ^ANeuralNetworksCompilation) ---

	/**
	* Sets the execution preference.
	*
	* <p>Provides guidance to the runtime when trade-offs are possible. By default the runtime
	* uses PREFER_SINGLE_FAST_ANSWER</p>
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param compilation The compilation to be modified.
	* @param preference Either {@link ANEURALNETWORKS_PREFER_LOW_POWER},
	*                  {@link ANEURALNETWORKS_PREFER_FAST_SINGLE_ANSWER}, or
	*                  {@link ANEURALNETWORKS_PREFER_SUSTAINED_SPEED}.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksCompilation_setPreference :: proc(compilation: ^ANeuralNetworksCompilation, preference: PreferenceCode) -> NNResultCode ---

	/**
	* Indicate that we have finished modifying a compilation. Required before
	* calling {@link ANeuralNetworksBurst_create} or
	* {@link ANeuralNetworksExecution_create}.
	*
	* An application must ensure that no other thread uses the compilation at the
	* same time.
	*
	* This function must only be called once for a given compilation.
	*
	* If {@link ANeuralNetworksCompilation_setTimeout} was called on this
	* compilation, and the compilation is not able to be finished before the
	* timeout duration is exceeded, then compilation may be aborted, in which case
	* ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be returned.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param compilation The compilation to be finished.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksCompilation_finish :: proc(compilation: ^ANeuralNetworksCompilation) -> NNResultCode ---

	/**
	* Set the execution priority.
	*
	* Execution priorities are relative to other executions created by the same
	* application (specifically same uid) for the same device. Specifically,
	* priorities of executions from one application will not affect executions from
	* another application. Similarly, priorities of executions on one device will
	* not affect executions on another device.
	*
	* Higher priority executions may use more compute resources than lower priority
	* executions, and may preempt or starve lower priority executions.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*
	* @param compilation The compilation to be modified.
	* @param priority The relative priority of the execution compared to other
	*     executions created by the application. Must be one of
	*     ANEURALNETWORKS_PRIORITY_*.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*/
	ANeuralNetworksCompilation_setPriority :: proc(compilation: ^ANeuralNetworksCompilation, priority: PriorityCode) -> NNResultCode ---

	/**
	* Set the maximum expected duration for compiling the model.
	*
	* If the device is not able to complete the compilation within the specified
	* duration, the compilation may be aborted. The timeout duration begins at the
	* call to {@link ANeuralNetworksCompilation_finish}.
	*
	* This timeout duration acts as a hint to drivers, and can be used to both free
	* up compute resources within the driver and return control back to the
	* application quicker than is possible without the hint. It enables drivers
	* that are able to estimate how long a compilation will take to abort the
	* compilation before it has even started if the driver believes the compilation
	* cannot be completed within the timeout duration. Similarly, it enables
	* drivers to abort an ongoing compilation if it is taking too long. However,
	* this call does not guarantee that the compilation will complete or abort
	* within the timeout duration.
	*
	* By default (i.e., unless ANeuralNetworksCompilation_setTimeout is called),
	* the timeout duration for compiling the model is considered infinite.
	*
	* The {@link ANeuralNetworksCompilation} must have been created with
	* {@link ANeuralNetworksCompilation_createForDevices} with numDevices = 1,
	* otherwise this function will fail with ANEURALNETWORKS_BAD_DATA. If the
	* device has a feature level reported by
	* {@link ANeuralNetworksDevice_getFeatureLevel} that is lower than
	* {@link ANEURALNETWORKS_FEATURE_LEVEL_4}, then the timeout duration hint will
	* be ignored.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* @param compilation The compilation to be modified.
	* @param duration The maximum amount of time in nanoseconds that is expected to
	*     be spent finishing a compilation. If this duration is exceeded, the
	*     compilation may be aborted. If set to 0, the timeout duration is
	*     considered infinite.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksCompilation_setTimeout :: proc(compilation: ^ANeuralNetworksCompilation, duration: u64) -> NNResultCode ---

	/**
	* Create a {@link ANeuralNetworksExecution} to apply the given compilation.
	* This only creates the object. Computation is only performed once
	* {@link ANeuralNetworksExecution_burstCompute},
	* {@link ANeuralNetworksExecution_compute},
	* {@link ANeuralNetworksExecution_startCompute} or
	* {@link ANeuralNetworksExecution_startComputeWithDependencies} is invoked.
	*
	* <p>The provided compilation must outlive the execution.</p>
	*
	* See {@link ANeuralNetworksExecution} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param compilation The {@link ANeuralNetworksCompilation} to be evaluated.
	* @param execution The newly created object or NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA
	*         if the compilation is invalid.
	*/
	ANeuralNetworksExecution_create :: proc(compilation: ^ANeuralNetworksCompilation, execution: ^^ANeuralNetworksExecution) -> NNResultCode ---

	/**
	* Destroy an execution.
	*
	* <p>The execution need not have been scheduled by a call to
	* {@link ANeuralNetworksExecution_burstCompute},
	* {@link ANeuralNetworksExecution_compute},
	* {@link ANeuralNetworksExecution_startCompute} or
	* {@link ANeuralNetworksExecution_startComputeWithDependencies} but if it has been scheduled,
	* then the application must not call {@link ANeuralNetworksExecution_free}
	* until the execution has completed (i.e.,
	* {@link ANeuralNetworksExecution_burstCompute},
	* {@link ANeuralNetworksExecution_compute}, or
	* {@link ANeuralNetworksEvent_wait} has returned).
	*
	* See {@link ANeuralNetworksExecution} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be destroyed. Passing NULL is acceptable and
	*                  results in no operation.
	*/
	ANeuralNetworksExecution_free :: proc(execution: ^ANeuralNetworksExecution) ---

	/**
	* Associate a user buffer with an input of the model of the
	* {@link ANeuralNetworksExecution}. Evaluation of the execution must not have
	* been scheduled. Once evaluation of the execution has been scheduled, the
	* application must not change the content of the buffer until the execution has
	* completed. Evaluation of the execution will not change the content of the
	* buffer.
	*
	* <p>The provided buffer must outlive the execution.</p>
	*
	* If the input is optional, you can indicate that it is omitted by
	* passing nullptr for buffer and 0 for length.
	*
	* Otherwise, if the user has not set the execution to accept padded input buffers by
	* calling {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, then the length argument
	* must be equal to the raw size of the input (i.e. the size of an element multiplied by the
	* number of elements). Passing a length argument with value not equal to the raw size of the input
	* will result in ANEURALNETWORKS_BAD_DATA.
	*
	* Otherwise, if the user has set the execution to accept padded input buffers by calling
	* {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, the length argument may be greater
	* than the raw size of the input, and the extra bytes at the end of the buffer may be used
	* by the driver to access data in chunks, for efficiency. Passing a length argument with value
	* less than the raw size of the input will result in ANEURALNETWORKS_BAD_DATA.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	* See {@link ANeuralNetworksCompilation_getPreferredMemoryAlignmentForInput} and
	* {@link ANeuralNetworksCompilation_getPreferredMemoryPaddingForInput} for information on getting
	* preferred buffer alignment and padding, to improve performance.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be modified.
	* @param index The index of the input argument we are setting. It is
	*              an index into the lists passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with
	*              {@link ANeuralNetworksModel_addOperand}.
	* @param type The {@link ANeuralNetworksOperandType} of the
	*             operand. Unless the input is omitted, this should be
	*             used to specify the dimensions that were left
	*             unspecified when the operand was added to the
	*             model. All other properties of the type must be the
	*             same as specified in the model. If the type is the same
	*             as specified when the model was built, NULL can be
	*             passed. Neither the {@link ANeuralNetworksOperandType}
	*             nor the dimensions it points to need to outlive the call
	*             to {@link ANeuralNetworksExecution_setInput}.
	* @param buffer The buffer containing the data.
	* @param length The size of the data value in bytes plus any end padding.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA if the
	*         name is not recognized or the buffer is too small for the input.
	*/
	ANeuralNetworksExecution_setInput :: proc(execution: ^ANeuralNetworksExecution, index: i32, type: ^ANeuralNetworksOperandType, buffer: rawptr, length: uint) -> NNResultCode ---

	/**
	* Associate a region of a memory object with an input of the model of the
	* {@link ANeuralNetworksExecution}. Evaluation of the execution must not have
	* been scheduled. Once evaluation of the execution has been scheduled, the
	* application must not change the content of the region until the execution has
	* completed. Evaluation of the execution will not change the content of the
	* region.
	*
	* <p>The provided memory must outlive the execution.</p>
	*
	* If the input is optional, you can indicate that it is omitted by
	* using {@link ANeuralNetworksExecution_setInput} instead, passing nullptr for
	* buffer and 0 for length.
	*
	* If the memory is an AHardwareBuffer of a format other than AHARDWAREBUFFER_FORMAT_BLOB created
	* from {@link ANeuralNetworksMemory_createFromAHardwareBuffer}, or an opaque memory object created
	* from {@link ANeuralNetworksMemory_createFromDesc}, both offset and length must be 0, indicating
	* the whole memory is used.
	*
	* Otherwise, if the user has not set the execution to accept padded input memory objects by
	* calling {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, then the length argument
	* must be equal to the raw size of the input (i.e. the size of an element multiplied by the
	* number of elements). Passing a length argument with value not equal to the raw size of the input
	* will result in ANEURALNETWORKS_BAD_DATA.
	*
	* Otherwise, if the user has set the execution to accept padded input memory objects by calling
	* {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, the length argument may be greater
	* than the raw size of the input, and the extra bytes at the end of the memory region may be used
	* by the driver to access data in chunks, for efficiency. Passing a length argument with value
	* less than the raw size of the input will result in ANEURALNETWORKS_BAD_DATA.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	* See {@link ANeuralNetworksMemory_createFromAHardwareBuffer} for information on
	* AHardwareBuffer usage.
	* See {@link ANeuralNetworksMemory_createFromDesc} for information on usage of memory objects
	* created from memory descriptors.
	* See {@link ANeuralNetworksCompilation_getPreferredMemoryAlignmentForInput} and
	* {@link ANeuralNetworksCompilation_getPreferredMemoryPaddingForInput} for information on getting
	* preferred memory alignment and padding, to improve performance.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be modified.
	* @param index The index of the input argument we are setting. It is
	*              an index into the lists passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param type The {@link ANeuralNetworksOperandType} of the
	*             operand. This should be used to specify the dimensions
	*             that were left unspecified when the operand was added
	*             to the model. All other properties of the type must be
	*             the same as specified in the model. If the type is the
	*             same as specified when the model was built, NULL can be
	*             passed. Neither the {@link ANeuralNetworksOperandType}
	*             nor the dimensions it points to need to outlive the call
	*             to {@link ANeuralNetworksExecution_setInputFromMemory}.
	* @param memory The memory containing the data.
	* @param offset This specifies the location of the data within the memory.
	*               The offset is in bytes from the start of memory.
	* @param length The size of the data value in bytes plus any end padding.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA if the
	*         name is not recognized or the buffer is too small for the input.
	*/
	ANeuralNetworksExecution_setInputFromMemory :: proc(execution: ^ANeuralNetworksExecution, index: i32, type: ^ANeuralNetworksOperandType, memory: ^ANeuralNetworksMemory, offset: uint, length: uint) -> NNResultCode ---

	/**
	* Associate a user buffer with an output of the model of the
	* {@link ANeuralNetworksExecution}. Evaluation of the execution must not have
	* been scheduled. Once evaluation of the execution has been scheduled, the
	* application must not change the content of the buffer until the execution has
	* completed.
	*
	* <p>The provided buffer must outlive the execution.</p>
	*
	* If the output is optional, you can indicate that it is omitted by
	* passing nullptr for buffer and 0 for length.
	*
	* Otherwise, if the user has not set the execution to accept padded output buffers by
	* calling {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, then the length argument
	* must be equal to the raw size of the output (i.e. the size of an element multiplied by the
	* number of elements). Passing a length argument with value not equal to the raw size of the output
	* will result in ANEURALNETWORKS_BAD_DATA.
	*
	* Otherwise, if the user has set the execution to accept padded output buffers by calling
	* {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, the length argument may be greater
	* than the raw size of the output, and the extra bytes at the end of the buffer may be used
	* by the driver to access data in chunks, for efficiency. Passing a length argument with value
	* less than the raw size of the output will result in ANEURALNETWORKS_BAD_DATA.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	* See {@link ANeuralNetworksCompilation_getPreferredMemoryAlignmentForOutput} and
	* {@link ANeuralNetworksCompilation_getPreferredMemoryPaddingForOutput} for information on getting
	* preferred buffer alignment and padding, to improve performance.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be modified.
	* @param index The index of the output argument we are setting. It is
	*              an index into the lists passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param type The {@link ANeuralNetworksOperandType} of the
	*             operand. Unless the output is omitted, this should be
	*             used to specify the dimensions that were left
	*             unspecified when the operand was added to the
	*             model. All other properties of the type must be the
	*             same as specified in the model. If the type is the same
	*             as specified when the model was built, NULL can be
	*             passed. Neither the {@link ANeuralNetworksOperandType}
	*             nor the dimensions it points to need to outlive the call
	*             to {@link ANeuralNetworksExecution_setOutput}.
	*             Since NNAPI feature level 3, the output operand can have unspecified
	*             dimensions or rank to be deduced dynamically during the execution.
	*             However, the user must provide a large enough buffer. The user
	*             can retrieve the output dimensional information after the execution
	*             by {@link ANeuralNetworksExecution_getOutputOperandRank} and
	*             {@link ANeuralNetworksExecution_getOutputOperandDimensions}.
	* @param buffer The buffer where the data is to be written.
	* @param length The size of the data value in bytes plus any end padding.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA if the
	*         name is not recognized or the buffer is too small for the output.
	*/
	ANeuralNetworksExecution_setOutput :: proc(execution: ^ANeuralNetworksExecution, index: i32, type: ^ANeuralNetworksOperandType, buffer: rawptr, length: uint) -> NNResultCode ---

	/**
	* Associate a region of a memory object with an output of the model of the
	* {@link ANeuralNetworksExecution}. Evaluation of the execution must not have
	* been scheduled. Once evaluation of the execution has been scheduled, the
	* application must not change the content of the region until the execution has
	* completed.
	*
	* <p>The provided memory must outlive the execution.</p>
	*
	* If the output is optional, you can indicate that it is omitted by
	* using {@link ANeuralNetworksExecution_setOutput} instead, passing nullptr for
	* buffer and 0 for length.
	*
	* If the memory is an AHardwareBuffer of a format other than AHARDWAREBUFFER_FORMAT_BLOB created
	* from {@link ANeuralNetworksMemory_createFromAHardwareBuffer}, or an opaque memory object created
	* from {@link ANeuralNetworksMemory_createFromDesc}, both offset and length must be 0, indicating
	* the whole memory is used.
	*
	* Otherwise, if the user has not set the execution to accept padded output memory objects by
	* calling {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, then the length argument
	* must be equal to the raw size of the output (i.e. the size of an element multiplied by the
	* number of elements). Passing a length argument with value not equal to the raw size of the output
	* will result in ANEURALNETWORKS_BAD_DATA.
	*
	* Otherwise, if the user has set the execution to accept padded output memory objects by calling
	* {@link ANeuralNetworksExecution_enableInputAndOutputPadding}, the length argument may be greater
	* than the raw size of the output, and the extra bytes at the end of the memory region may be used
	* by the driver to access data in chunks, for efficiency. Passing a length argument with value
	* less than the raw size of the output will result in ANEURALNETWORKS_BAD_DATA.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	* See {@link ANeuralNetworksMemory_createFromAHardwareBuffer} for information on
	* AHardwareBuffer usage.
	* See {@link ANeuralNetworksMemory_createFromDesc} for information on usage of memory objects
	* created from memory descriptors.
	* See {@link ANeuralNetworksCompilation_getPreferredMemoryAlignmentForOutput} and
	* {@link ANeuralNetworksCompilation_getPreferredMemoryPaddingForOutput} for information on getting
	* preferred memory alignment and padding, to improve performance.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be modified.
	* @param index The index of the output argument we are setting. It is
	*              an index into the lists passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param type The {@link ANeuralNetworksOperandType} of the operand. This should be
	*             used to specify the dimensions that were left
	*             unspecified when the operand was added to the
	*             model. All other properties of the type must be the
	*             same as specified in the model. If the type is the same
	*             as specified when the model was built, NULL can be
	*             passed. Neither the {@link ANeuralNetworksOperandType}
	*             nor the dimensions it points to need to outlive the call
	*             to {@link ANeuralNetworksExecution_setOutputFromMemory}.
	*             Since NNAPI feature level 3, the output operand can have unspecified
	*             dimensions or rank to be deduced dynamically during the execution.
	*             However, the user must provide a large enough memory. The user
	*             can retrieve the output dimensional information after the execution
	*             by {@link ANeuralNetworksExecution_getOutputOperandRank} and
	*             {@link ANeuralNetworksExecution_getOutputOperandDimensions}.
	* @param memory The memory where the data is to be stored.
	* @param offset This specifies the location of the data within the memory.
	*               The offset is in bytes from the start of memory.
	* @param length The size of the data value in bytes plus any end padding.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful, ANEURALNETWORKS_BAD_DATA if the
	*         name is not recognized or the buffer is too small for the output.
	*/
	ANeuralNetworksExecution_setOutputFromMemory :: proc(execution: ^ANeuralNetworksExecution, index: i32, type: ^ANeuralNetworksOperandType, memory: ^ANeuralNetworksMemory, offset: uint, length: uint) -> NNResultCode ---

	/**
	* Schedule asynchronous evaluation of the execution.
	*
	* <p>Schedules asynchronous evaluation of the execution. Once the execution
	* has completed and the outputs are ready to be consumed, the returned event
	* will be signaled. Use {@link ANeuralNetworksEvent_wait} to wait for that
	* event.
	* </p>
	*
	* ANeuralNetworksEvent_wait must be called to recuperate the resources used
	* by the execution.
	*
	* If {@link ANeuralNetworksExecution_setTimeout} was called on this execution,
	* and the execution is not able to complete before the timeout duration is
	* exceeded, then execution may be aborted, in which case
	* ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be returned through
	* {@link ANeuralNetworksExecution_startCompute} or
	* {@link ANeuralNetworksEvent_wait} on the event object. If the device has a
	* feature level reported by {@link ANeuralNetworksDevice_getFeatureLevel} that
	* is lower than {@link ANEURALNETWORKS_FEATURE_LEVEL_4}, then the timeout
	* duration hint will be ignored.
	*
	* If this execution contains a {@link ANEURALNETWORKS_WHILE} operation, and
	* the condition model does not output false within the loop timeout duration,
	* then execution will be aborted and ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}
	* will be returned through {@link ANeuralNetworksEvent_wait} on the event
	* object.
	*
	* If the device can detect before the execution has started that the execution
	* will not complete within the timeout duration, the device may choose to skip
	* the execution and instead return ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}.
	*
	* Before NNAPI feature level 5, this function may only be invoked when the execution is in the
	* preparation state. Starting at NNAPI feature level 5, if the user sets the execution to be
	* reusable by {@link ANeuralNetworksExecution_setReusable}, this function may also be invoked when
	* the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* See {@link ANeuralNetworksExecution_compute} for synchronous execution.
	* See {@link ANeuralNetworksExecution_burstCompute} for burst synchronous execution.
	* See {@link ANeuralNetworksExecution_startComputeWithDependencies} for
	* asynchronous execution with dependencies.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param execution The execution to be scheduled and executed.
	* @param event The event that will be signaled on completion. event is set to
	*              NULL if there's an error.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the evaluation is successfully scheduled.
	*/
	ANeuralNetworksExecution_startCompute :: proc(execution: ^ANeuralNetworksExecution, event: ^^ANeuralNetworksEvent) -> NNResultCode ---

	/**
	* Set the maximum expected duration of the specified execution.
	*
	* If the device is not able to complete the execution within the specified
	* duration, the execution may be aborted. The timeout duration begins at a
	* call to one of:
	* - {@link ANeuralNetworksExecution_burstCompute}
	* - {@link ANeuralNetworksExecution_compute}
	* - {@link ANeuralNetworksExecution_startCompute}
	* - {@link ANeuralNetworksExecution_startComputeWithDependencies}
	*
	* This timeout duration acts as a hint to drivers, and can be used to both free
	* up compute resources within the driver and return control back to the
	* application quicker than is possible without the hint. It enables drivers
	* that are able to estimate how long an execution will take to abort the
	* execution before it has even started if the driver believes the execution
	* cannot be completed within the timeout duration. Similarly, it enables
	* drivers to abort an ongoing execution if it is taking too long. However, this
	* call does not guarantee that the execution will complete or abort within the
	* timeout duration.
	*
	* By default (i.e., unless ANeuralNetworksExecution_setTimeout is called),
	* the timeout duration for execution is considered infinite.
	*
	* The {@link ANeuralNetworksExecution} must have been created from an
	* {@link ANeuralNetworksCompilation} which in turn was created from
	* {@link ANeuralNetworksCompilation_createForDevices} with numDevices = 1,
	* otherwise this function will fail with ANEURALNETWORKS_BAD_DATA. If the
	* device has a feature level reported by
	* {@link ANeuralNetworksDevice_getFeatureLevel} that is lower than
	* {@link ANEURALNETWORKS_FEATURE_LEVEL_4}, then the timeout duration hint will
	* be ignored.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* @param execution The execution to be modified.
	* @param duration The maximum amount of time in nanoseconds that is expected to
	*     be spent executing a model. If this duration is exceeded, the execution
	*     may be aborted. If set to 0, the timeout duration is considered infinite.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksExecution_setTimeout :: proc(execution: ^ANeuralNetworksExecution, duration: u64) -> NNResultCode ---

	/**
	* Set the maximum duration of WHILE loops in the specified execution.
	*
	* This is a fuzzy per-loop timeout intended to prevent infinite loops.
	*
	* If a WHILE loop condition model does not output false within the specified
	* duration, the execution will be aborted.
	*
	* See {@link ANeuralNetworks_getDefaultLoopTimeout} and
	* {@link ANeuralNetworks_getMaximumLoopTimeout} for the default
	* and maximum timeout values.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* @param execution The execution to be modified.
	* @param duration The maximum amount of time in nanoseconds that can be spent
	*     executing a WHILE loop. If the specified duration value exceeds the value
	*     produced by {@link ANeuralNetworks_getMaximumLoopTimeout}, it will be
	*     overridden by that value.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_BAD_STATE if execution has started.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if execution is NULL.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksExecution_setLoopTimeout :: proc(execution: ^ANeuralNetworksExecution, duration: u64) -> NNResultCode ---

	/**
	* Get the default timeout value for WHILE loops.
	*
	* @return The default timeout value in nanoseconds.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworks_getDefaultLoopTimeout :: proc() -> u64 ---

	/**
	* Get the maximum timeout value for WHILE loops.
	*
	* @return The maximum timeout value in nanoseconds.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworks_getMaximumLoopTimeout :: proc() -> u64 ---

	/**
	* Waits until the execution completes.
	*
	* More than one thread can wait on an event. When the execution completes,
	* all threads will be released.
	*
	* If {@link ANeuralNetworksExecution_setTimeout} was called on the execution
	* corresponding to this event, and the execution is not able to complete
	* before the duration is exceeded, the execution may be aborted, in which case
	* ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be returned here.
	*
	* If the execution contains a {@link ANEURALNETWORKS_WHILE} operation, and
	* the condition model does not output false within the loop timeout duration,
	* the execution will be aborted, and ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}
	* will be returned here.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param event The event that will be signaled on completion.
	* @return ANEURALNETWORKS_NO_ERROR if the execution completed normally.
	*         ANEURALNETWORKS_UNMAPPABLE if the execution input or output memory cannot
	*         be properly mapped.
	*/
	ANeuralNetworksEvent_wait :: proc(event: ^ANeuralNetworksEvent) -> NNResultCode ---

	/**
	* Destroys the event.
	*
	* See {@link ANeuralNetworksExecution} for information on multithreaded usage.
	*
	* Available since NNAPI feature level 1.
	* Available since API level 27.
	*
	* @param event The event object to be destroyed. Passing NULL is acceptable and
	*              results in no operation.
	*/
	ANeuralNetworksEvent_free :: proc(event: ^ANeuralNetworksEvent) ---

	/**
	* Create a {@link ANeuralNetworksEvent} from a sync_fence file descriptor.
	*
	* The newly created ANeuralNetworksEvent does not take ownership of the provided sync_fence_fd,
	* it will instead dup the provided sync_fence_fd and own the duplicate.
	*
	* @param sync_fence_fd The sync_fence file descriptor.
	* @param event The newly created object or NULL if unsuccessful.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksEvent_createFromSyncFenceFd :: proc(sync_fence_fd: i32, event: ^^ANeuralNetworksEvent) -> NNResultCode ---

	/**
	* Get sync_fence file descriptor from the event.
	*
	* If the ANeuralNetworksEvent is not backed by a sync fence, the sync_fence_fd
	* will be set to -1, and ANEURALNETWORKS_BAD_DATA will be returned.
	*
	* See {@link ANeuralNetworksEvent_createFromSyncFenceFd} and
	* {@link ANeuralNetworksExecution_startComputeWithDependencies} to see how to create
	* an event backed by a sync fence.
	*
	* The user takes ownership of the returned fd, and must close the returned file descriptor when
	* it is no longer needed.
	*
	* @param event An event that is backed by a sync fence.
	* @param sync_fence_fd The sync_fence file descriptor. The file descriptor will
	*                      be set to -1 if there is an error.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksEvent_getSyncFenceFd :: proc(event: ^ANeuralNetworksEvent, sync_fence_fd: ^i32) -> NNResultCode ---

	/**
	* Schedule asynchronous evaluation of the execution with dependencies.
	*
	* The execution will wait for all the depending events to be signaled before
	* starting the evaluation. Once the execution has completed and the outputs
	* are ready to be consumed, the returned event will be signaled. Depending on which
	* devices are handling the execution, the event could be backed by a sync fence.
	* Use {@link ANeuralNetworksEvent_wait} to wait for that event.
	*
	* ANeuralNetworksEvent_wait must be called to recurperate the resources used
	* by the execution.
	*
	* If parts of the execution are scheduled on devices that do not support fenced execution,
	* the function call may wait for such parts to finish before returning.
	*
	* The function will return an error if any of the events in dependencies is already in a bad
	* state. After the execution is scheduled, if any of the events in dependencies does not complete
	* normally, the execution will fail, and {@link ANeuralNetworksEvent_wait} on the returned
	* event will return an error.
	*
	* The function will return an error if any of the execution outputs has a tensor operand type
	* that is not fully specified.
	*
	* The function can be passed a timeout duration in nanoseconds. This timeout
	* duration acts as a hint to drivers in the same way that the timeout durations
	* in {@link ANeuralNetworksCompilation_setTimeout} and {@link
	* ANeuralNetworksExecution_setTimeout} act as hints to drivers. The duration
	* begins when all waitFor sync fences have been signaled, and can be used
	* together with {@link ANeuralNetworksExecution_setTimeout} which specifies the
	* maximum timeout duration beginning at the call to
	* {@link ANeuralNetworksExecution_startComputeWithDependencies}.
	* If the duration is non-zero, the {@link ANeuralNetworksExecution} must have been created
	* from an {@link ANeuralNetworksCompilation} which in turn was created from
	* {@link ANeuralNetworksCompilation_createForDevices} with numDevices = 1,
	* otherwise this function will fail with ANEURALNETWORKS_BAD_DATA. If either
	* the timeout duration from {@link ANeuralNetworksExecution_setTimeout} or the
	* timeout duration passed to this call is exceeded, the execution may be
	* aborted, in which case ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode} will be
	* returned through {@link ANeuralNetworksExecution_startComputeWithDependencies}
	* or {@link ANeuralNetworksEvent_wait} on the event object. If the device has a
	* feature level reported by {@link ANeuralNetworksDevice_getFeatureLevel} that
	* is lower than {@link ANEURALNETWORKS_FEATURE_LEVEL_4}, then the timeout duration
	* hints will be ignored.
	*
	* If this execution contains a {@link ANEURALNETWORKS_WHILE} operation, and
	* the condition model does not output false within the loop timeout duration,
	* then execution will be aborted and ANEURALNETWORKS_MISSED_DEADLINE_* {@link ResultCode}
	* will be returned through {@link ANeuralNetworksEvent_wait} on the event
	* object.
	*
	* Before NNAPI feature level 5, this function may only be invoked when the execution is in the
	* preparation state. Starting at NNAPI feature level 5, if the user sets the execution to be
	* reusable by {@link ANeuralNetworksExecution_setReusable}, this function may also be invoked when
	* the execution is in the completed state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* See {@link ANeuralNetworksExecution_compute} for synchronous execution.
	* See {@link ANeuralNetworksExecution_burstCompute} for burst synchronous execution.
	* See {@link ANeuralNetworksExecution_startCompute} for regular asynchronous execution.
	*
	* @param execution The execution to be scheduled and executed.
	* @param dependencies A set of depending events. The actual evaluation will not start
	*                     until all the events are signaled.
	* @param num_dependencies The number of events in the dependencies set.
	* @param duration The maximum amount of time in nanoseconds that is expected to
	*                 be spent executing the model after all dependencies are
	*                 signaled. If set to 0, the timeout duration is considered
	*                 infinite.
	* @param event The event that will be signaled on completion. event is set to
	*              NULL if there's an error.
	*
	* @return ANEURALNETWORKS_NO_ERROR if the evaluation is successfully scheduled.
	*
	* Available since NNAPI feature level 4.
	* Available since API level 30.
	*/
	ANeuralNetworksExecution_startComputeWithDependencies :: proc(execution: ^ANeuralNetworksExecution, dependencies: ^^ANeuralNetworksEvent, num_dependencies: u32, duration: u64, event: ^^ANeuralNetworksEvent) -> NNResultCode ---

	/**
	* Get the NNAPI runtime feature level.
	*
	* Since API level 31 (NNAPI feature level 5), the NNAPI runtime (libneuralnetworks.so) and its
	* API specification can be updated between Android API releases.
	*
	* On Android devices with API level 31 and newer, for NNAPI runtime feature discovery,
	* the NNAPI runtime feature level must be used instead of the Android device API level.
	*
	* On Android devices with API level 30 and older, the Android API level of the Android
	* device must be used for NNAPI runtime feature discovery. Enum values in
	* {@link FeatureLevelCode} from feature level 1 to 5 have their corresponding Android
	* API levels listed in their documentation, and each such enum value equals the corresponding
	* API level. This allows using the Android API level as the feature level.
	* This mapping between enum value and Android API level does not exist for feature levels
	* after NNAPI feature level 5 and API levels after S (31).
	*
	* Example usage:
	* int device_api_level = android_get_device_api_level()
	* int64_t runtime_feature_level = (device_api_level < __ANDROID_API_S__) ?
	*                                  device_api_level : ANeuralNetworks_getRuntimeFeatureLevel()
	*
	* Runtime feature level is closely related to NNAPI device feature level
	* ({@link ANeuralNetworksDevice_getFeatureLevel}), which indicates an NNAPI device feature level
	* (the most advanced NNAPI specification and features that the driver implements).
	* This function expresses NNAPI runtime feature level, which indicates the most advanced
	* NNAPI specification and features the runtime implements. An NNAPI device feature level is
	* always less than or equal to the runtime feature level.
	*
	* This function returns a {@link FeatureLevelCode} enum value,
	* which is the NNAPI specification version that this NNAPI runtime implements.
	* It is NOT an Android API level.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworks_getRuntimeFeatureLevel :: proc() -> FeatureLevelCode ---

	/**
	* Specifies whether the {@link ANeuralNetworksExecution} is able to accept padded input and output
	* buffers and memory objects.
	*
	* By default, the input and output buffers and memory objects of {@link ANeuralNetworksExecution}
	* do not allow padding.
	*
	* Setting the execution to accept padded input and output buffers and memory objects enables the
	* length argument of {@link ANeuralNetworksExecution_setInput},
	* {@link ANeuralNetworksExecution_setInputFromMemory}, {@link ANeuralNetworksExecution_setOutput},
	* and {@link ANeuralNetworksExecution_setOutputFromMemory} to be greater than the raw size of the
	* operand (i.e. the size of an element multiplied by the number of elements). The extra bytes
	* at the end of the buffer or memory region may be used by the driver to access data in chunks,
	* for efficiency.
	*
	* This method must not be called after {@link ANeuralNetworksExecution_setInput},
	* {@link ANeuralNetworksExecution_setInputFromMemory}, {@link ANeuralNetworksExecution_setOutput},
	* or {@link ANeuralNetworksExecution_setOutputFromMemory}.
	*
	* See {@link ANeuralNetworksExecution} for information on multithreaded usage.
	*
	* @param execution The execution to be modified.
	* @param enable 'true' if the execution is to be able to accept padded input and output buffers
	*               and memory objects, 'false' if not.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if execution is NULL.
	*         ANEURALNETWORKS_BAD_STATE if {@link ANeuralNetworksExecution_setInput},
	*         {@link ANeuralNetworksExecution_setInputFromMemory},
	*         {@link ANeuralNetworksExecution_setOutput}, or
	*         {@link ANeuralNetworksExecution_setOutputFromMemory} has been called on the execution.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksExecution_enableInputAndOutputPadding :: proc(execution: ^ANeuralNetworksExecution, enable: bool) -> NNResultCode ---

	/**
	* Get the preferred buffer and memory alignment of an input to an execution created from a
	* particular compilation.
	*
	* The user may use the returned alignment value to guide the layout of the input buffer or memory
	* pool. To achieve the best performance, make sure the address of the buffer passed in
	* {@link ANeuralNetworksExecution_setInput}, or the offset value passed in
	* {@link ANeuralNetworksExecution_setInputFromMemory}, is a multiple of the perferred alignment
	* value of the same input. A driver may choose to allocate a separate buffer and do memory copying
	* if the provided buffer or memory does not satisfy the preferred alignment.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}.
	* @param index The index of the input argument we are referencing from the compilation. It is
	*              an index into the inputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param alignment The returned preferred alignment in bytes. It will be a power of 2.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if either compilation or alignment is NULL.
	*         ANEURALNETWORKS_BAD_STATE if the compilation has not been finished.
	*         ANEURALNETWORKS_BAD_DATA if the index is out of range.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksCompilation_getPreferredMemoryAlignmentForInput :: proc(compilation: ^ANeuralNetworksCompilation, index: u32, alignment: ^u32) -> NNResultCode ---

	/**
	* Get the preferred buffer and memory end padding of an input to an execution created from a
	* particular compilation.
	*
	* The user may use the returned padding value to guide the layout of the input buffer or memory
	* pool. To achieve the best performance, make sure the length value passed in
	* {@link ANeuralNetworksExecution_setInput} or
	* {@link ANeuralNetworksExecution_setInputFromMemory} is greater than or equal to the raw size of
	* the input (i.e. the size of an element multiplied by the number of elements) rounding up to
	* a multiple of the perferred padding value of the same input. A driver may choose to allocate a
	* separate buffer and do memory copying if the provided buffer or memory value does not satisfy
	* the preferred padding.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	* See {@link ANeuralNetworksExecution_enableInputAndOutputPadding},
	* {@link ANeuralNetworksExecution_setInput}, and
	* {@link ANeuralNetworksExecution_setInputFromMemory} for information on passing
	* input buffer or memory padding to the driver.
	*
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}.
	* @param index The index of the input argument we are referencing from the compilation. It is
	*              an index into the inputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param padding The returned preferred padding in bytes. It will be a power of 2.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if either compilation or padding is NULL.
	*         ANEURALNETWORKS_BAD_STATE if the compilation has not been finished.
	*         ANEURALNETWORKS_BAD_DATA if the index is out of range.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksCompilation_getPreferredMemoryPaddingForInput :: proc(compilation: ^ANeuralNetworksCompilation, index: u32, padding: ^u32) -> NNResultCode ---

	/**
	* Get the preferred buffer and memory alignment of an output to an execution created from a
	* particular compilation.
	*
	* The user may use the returned alignment value to guide the layout of the output buffer or memory
	* pool. To achieve the best performance, make sure the address of the buffer passed in
	* {@link ANeuralNetworksExecution_setOutput}, or the offset value passed in
	* {@link ANeuralNetworksExecution_setOutputFromMemory}, is a multiple of the perferred alignment
	* value of the same output. A driver may choose to allocate a separate buffer and do memory copying
	* if the provided buffer or memory does not satisfy the preferred alignment.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	*
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}.
	* @param index The index of the output argument we are referencing from the compilation. It is
	*              an index into the outputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param alignment The returned perferred alignment in bytes. It will be a power of 2.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if either compilation or alignment is NULL.
	*         ANEURALNETWORKS_BAD_STATE if the compilation has not been finished.
	*         ANEURALNETWORKS_BAD_DATA if the index is out of range.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksCompilation_getPreferredMemoryAlignmentForOutput :: proc(compilation: ^ANeuralNetworksCompilation, index: u32, alignment: ^u32) -> NNResultCode ---

	/**
	* Get the preferred memory end padding of an output to an execution created from a particular
	* compilation.
	*
	* The user may use the returned padding value to guide the layout of the output buffer or memory
	* pool. To achieve the best performance, make sure the length value passed in
	* {@link ANeuralNetworksExecution_setOutput} or
	* {@link ANeuralNetworksExecution_setOutputFromMemory} is greater than or equal to the raw size of
	* the output (i.e. the size of an element multiplied by the number of elements) rounding up to
	* a multiple of the perferred padding value of the same output. A driver may choose to allocate a
	* separate buffer and do memory copying if the provided buffer or memory value does not satisfy
	* the preferred padding.
	*
	* See {@link ANeuralNetworksCompilation} for information on multithreaded usage.
	* See {@link ANeuralNetworksExecution_enableInputAndOutputPadding},
	* {@link ANeuralNetworksExecution_setOutput}, and
	* {@link ANeuralNetworksExecution_setOutputFromMemory} for information on passing
	* output buffer or memory padding to the driver.
	*
	* @param compilation The compilation object. It must already have been finished by calling
	*                    {@link ANeuralNetworksCompilation_finish}.
	* @param index The index of the output argument we are referencing from the compilation. It is
	*              an index into the outputs list passed to
	*              {@link ANeuralNetworksModel_identifyInputsAndOutputs}. It is not
	*              the index associated with {@link ANeuralNetworksModel_addOperand}.
	* @param padding The returned perferred padding in bytes. It will be a power of 2.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if either compilation or padding is NULL.
	*         ANEURALNETWORKS_BAD_STATE if the compilation has not been finished.
	*         ANEURALNETWORKS_BAD_DATA if the index is out of range.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksCompilation_getPreferredMemoryPaddingForOutput :: proc(compilation: ^ANeuralNetworksCompilation, index: u32, padding: ^u32) -> NNResultCode ---

	/**
	* Specifies whether the {@link ANeuralNetworksExecution} can be reused for multiple computations.
	*
	* By default, the {@link ANeuralNetworksExecution} is not reusable.
	*
	* Setting the execution to be reusable enables multiple computations to be scheduled and evaluated
	* on the same execution sequentially, either by means of
	* {@link ANeuralNetworksExecution_burstCompute}, {@link ANeuralNetworksExecution_compute},
	* {@link ANeuralNetworksExecution_startCompute} or
	* {@link ANeuralNetworksExecution_startComputeWithDependencies}: The application may schedule and
	* evaluate a computation again from the completed state of a reusable execution.
	*
	* This function may only be invoked when the execution is in the preparation state.
	*
	* See {@link ANeuralNetworksExecution} for information on execution states and multithreaded usage.
	*
	* @param execution The execution to be modified.
	* @param reusable 'true' if the execution is to be reusable, 'false' if not.
	*
	* @return ANEURALNETWORKS_NO_ERROR if successful.
	*         ANEURALNETWORKS_UNEXPECTED_NULL if execution is NULL.
	*         ANEURALNETWORKS_BAD_STATE if the execution is not in the preparation state.
	*
	* Available since NNAPI feature level 5.
	* Available since API level 31.
	*/
	ANeuralNetworksExecution_setReusable :: proc(execution: ^ANeuralNetworksExecution, reusable: bool) -> NNResultCode ---
}
