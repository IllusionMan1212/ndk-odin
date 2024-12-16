package mediandk

foreign import mediandk "system:mediandk"

/**
* String property name: identifies the maker of the DRM engine plugin
*/
PROPERTY_VENDOR :: "vendor"

/**
* String property name: identifies the version of the DRM engine plugin
*/
PROPERTY_VERSION :: "version"

/**
* String property name: describes the DRM engine plugin
*/
PROPERTY_DESCRIPTION :: "description"

/**
* String property name: a comma-separated list of cipher and mac algorithms
* supported by CryptoSession.  The list may be empty if the DRM engine
* plugin does not support CryptoSession operations.
*/
PROPERTY_ALGORITHMS :: "algorithms"

/**
* Byte array property name: the device unique identifier is established during
* device provisioning and provides a means of uniquely identifying each device.
*/
PROPERTY_DEVICE_UNIQUE_ID :: "deviceUniqueId"

AMediaDrm :: struct{}

AMediaDrmByteArray :: struct {
    ptr: [^]byte,
    length: uint,
}

AMediaDrmSessionId :: AMediaDrmByteArray
AMediaDrmScope :: AMediaDrmByteArray
AMediaDrmKeySetId :: AMediaDrmByteArray
AMediaDrmSecureStop :: AMediaDrmByteArray
AMediaDrmKeyId :: AMediaDrmByteArray

AMediaDrmEventType :: enum {
    /**
     * This event type indicates that the app needs to request a certificate from
     * the provisioning server.  The request message data is obtained using
     * AMediaDrm_getProvisionRequest.
     */
    PROVISION_REQUIRED = 1,

    /**
     * This event type indicates that the app needs to request keys from a license
     * server.  The request message data is obtained using AMediaDrm_getKeyRequest.
     */
    KEY_REQUIRED = 2,

    /**
     * This event type indicates that the licensed usage duration for keys in a session
     * has expired.  The keys are no longer valid.
     */
    KEY_EXPIRED = 3,

    /**
     * This event may indicate some specific vendor-defined condition, see your
     * DRM provider documentation for details
     */
    VENDOR_DEFINED = 4,

    /**
     * This event indicates that a session opened by the app has been reclaimed
     * by the resource manager.
     */
    SESSION_RECLAIMED = 5,
}

AMediaDrmKeyType :: enum {
    /**
     * This key request type specifies that the keys will be for online use, they will
     * not be saved to the device for subsequent use when the device is not connected
     * to a network.
     */
    STREAMING = 1,

    /**
     * This key request type specifies that the keys will be for offline use, they
     * will be saved to the device for use when the device is not connected to a network.
     */
    OFFLINE = 2,

    /**
     * This key request type specifies that previously saved offline keys should be released.
     */
    RELEASE = 3
}

/**
 * Introduced in API 33.
 */
AMediaDrmKeyRequestType :: enum i32 {
    /**
     * Key request type is initial license request.
     * An initial license request is necessary to load keys.
     */
    INITIAL,

    /**
     * Key request type is license renewal.
     * A renewal license request is necessary to prevent the keys from expiring.
     */
    RENEWAL,

    /**
     * Key request type is license release.
     * A license release request indicates that keys are removed.
     */
    RELEASE,

    /**
     * Keys are already loaded and are available for use. No license request is necessary, and
     * no key request data is returned.
     */
    NONE,

    /**
     * Keys have been loaded but an additional license request is needed
     * to update their values.
     */
    UPDATE
}

/**
 *  Data type containing {key, value} pair
 */
AMediaDrmKeyValue :: struct {
	mKey: cstring,
    mValue: cstring,
}

AMediaDrmKeyStatusType :: enum {
    /**
     * The key is currently usable to decrypt media data.
     */
    USABLE,

    /**
     * The key is no longer usable to decrypt media data because its expiration
     * time has passed.
     */
    EXPIRED,

    /**
     * The key is not currently usable to decrypt media data because its output
     * requirements cannot currently be met.
     */
    OUTPUTNOTALLOWED,

    /**
     * The status of the key is not yet known and is being determined.
     */
    STATUSPENDING,

    /**
     * The key is not currently usable to decrypt media data because of an
     * internal error in processing unrelated to input parameters.
     */
    INTERNALERROR,
}

AMediaDrmKeyStatus :: struct {
	keyId: AMediaDrmKeyId,
    keyType: AMediaDrmKeyStatusType,
}

AMediaDrmEventListener :: #type proc "c" (drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId, eventType: AMediaDrmEventType, extra: i32, data: [^]byte, dataSize: uint)

AMediaDrmExpirationUpdateListener :: #type proc "c" (drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId, expiryTimeInMS: i64)

AMediaDrmKeysChangeListener :: #type proc "c" (drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId, keyStatus: ^AMediaDrmKeyStatus, numKeys: uint, hasNewUsableKey: bool)

foreign mediandk {
	/**
	 * Query if the given scheme identified by its UUID is supported on this device, and
	 * whether the drm plugin is able to handle the media container format specified by mimeType.
	 *
	 * uuid identifies the universal unique ID of the crypto scheme. uuid must be 16 bytes.
	 * mimeType is the MIME type of the media container, e.g. "video/mp4".  If mimeType
	 * is not known or required, it can be provided as NULL.
	 *
	 * Available since API level 21.
	 */
	AMediaDrm_isCryptoSchemeSupported :: proc(uuid: [^]byte, mimeType: cstring) -> bool ---

	/**
	* Create a MediaDrm instance from a UUID.
	* uuid identifies the universal unique ID of the crypto scheme. uuid must be 16 bytes.
	*
	* Available since API level 21.
	*/
	AMediaDrm_createByUUID :: proc(uuid: [^]byte) -> ^AMediaDrm ---

	/**
	* Release a MediaDrm object.
	*
	* Available since API level 21.
	*/
	AMediaDrm_release :: proc(drm: ^AMediaDrm) ---

	/**
	* Register a callback to be invoked when an event occurs.
	*
	* listener is the callback that will be invoked on event.
	*
	* Available since API level 21.
	*/
	AMediaDrm_setOnEventListener :: proc(drm: ^AMediaDrm, listener: AMediaDrmEventListener) -> media_status_t ---

	/**
	* Register a callback to be invoked when an expiration update event occurs.
	*
	* listener is the callback that will be invoked on event.
	*
	* Available since API level 29.
	*/
	AMediaDrm_setOnExpirationUpdateListener :: proc(drm: ^AMediaDrm, listener: AMediaDrmExpirationUpdateListener) -> media_status_t ---

	/**
	* Register a callback to be invoked when a key status change event occurs.
	*
	* listener is the callback that will be invoked on event.
	*
	* Available since API level 29.
	*/
	AMediaDrm_setOnKeysChangeListener :: proc(drm: ^AMediaDrm, listener: AMediaDrmKeysChangeListener) -> media_status_t ---

	/**
	* Open a new session with the MediaDrm object.  A session ID is returned.
	*
	* Returns AMEDIA_DRM_NOT_PROVISIONED if provisioning is needed.
	* Returns AMEDIA_DRM_RESOURCE_BUSY if required resources are in use.
	*
	* Available since API level 21.
	*/
	AMediaDrm_openSession :: proc(drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId) -> media_status_t ---

	/**
	* Close a session on the MediaDrm object that was previously opened
	* with AMediaDrm_openSession.
	*
	* Available since API level 21.
	*/
	AMediaDrm_closeSession :: proc(drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId) -> media_status_t ---

	/**
	* A key request/response exchange occurs between the app and a license server
	* to obtain or release keys used to decrypt encrypted content.
	* AMediaDrm_getKeyRequest is used to obtain an opaque key request byte array that
	* is delivered to the license server.  The opaque key request byte array is
	* returned in *keyRequest and the number of bytes in the request is
	* returned in *keyRequestSize.
	* This API has same functionality as AMediaDrm_getKeyRequestWithDefaultUrlAndType()
	* when defaultUrl and keyRequestType are passed in as NULL.
	*
	* After the app has received the key request response from the server,
	* it should deliver to the response to the DRM engine plugin using the method
	* AMediaDrm_provideKeyResponse.
	*
	* scope may be a sessionId or a keySetId, depending on the specified keyType.
	* When the keyType is KEY_TYPE_STREAMING or KEY_TYPE_OFFLINE, scope should be set
	* to the sessionId the keys will be provided to.  When the keyType is
	* KEY_TYPE_RELEASE, scope should be set to the keySetId of the keys being released.
	* Releasing keys from a device invalidates them for all sessions.
	*
	* init container-specific data, its meaning is interpreted based on the mime type
	* provided in the mimeType parameter.  It could contain, for example, the content
	* ID, key ID or other data obtained from the content metadata that is required in
	* generating the key request. init may be null when keyType is KEY_TYPE_RELEASE.
	*
	* initSize is the number of bytes of initData
	*
	* mimeType identifies the mime type of the content.
	*
	* keyType specifes the type of the request. The request may be to acquire keys for
	*   streaming or offline content, or to release previously acquired keys, which are
	*   identified by a keySetId.
	*
	* optionalParameters are included in the key request message to allow a client
	*   application to provide additional message parameters to the server.
	*
	* numOptionalParameters indicates the number of optional parameters provided
	*   by the caller
	*
	* On exit:
	*   If this returns AMEDIA_OK,
	*   1. The keyRequest pointer will reference the opaque key request data.  It
	*       will reside in memory owned by the AMediaDrm object, and will remain
	*       accessible until the next call to AMediaDrm_getKeyRequest
	*       or AMediaDrm_getKeyRequestWithDefaultUrlAndType or until the
	*       MediaDrm object is released.
	*   2. keyRequestSize will be set to the size of the request
	*   If this does not return AMEDIA_OK, value of these parameters should not be used.
	*
	* Returns AMEDIA_DRM_NOT_PROVISIONED if reprovisioning is needed, due to a
	* problem with the device certificate.
	*
	* Available since API level 21.
	*/
	AMediaDrm_getKeyRequest :: proc(
	drm: ^AMediaDrm,
	scope: ^AMediaDrmScope,
	init: [^]byte,
	initSize: uint,
	mimeType: cstring,
	keyType: AMediaDrmKeyType,
	optionalParameters: [^]AMediaDrmKeyValue,
	numOptionalParameters: uint,
	keyRequest: ^[^]byte,
	keyRequestSize: ^uint) -> media_status_t ---

	/**
	* A key request/response exchange occurs between the app and a license server
	* to obtain or release keys used to decrypt encrypted content.
	* AMediaDrm_getKeyRequest is used to obtain an opaque key request byte array that
	* is delivered to the license server.  The opaque key request byte array is
	* returned in *keyRequest and the number of bytes in the request is
	* returned in *keyRequestSize.
	*
	* After the app has received the key request response from the server,
	* it should deliver to the response to the DRM engine plugin using the method
	* AMediaDrm_provideKeyResponse.
	*
	* scope may be a sessionId or a keySetId, depending on the specified keyType.
	* When the keyType is KEY_TYPE_STREAMING or KEY_TYPE_OFFLINE, scope should be set
	* to the sessionId the keys will be provided to.  When the keyType is
	* KEY_TYPE_RELEASE, scope should be set to the keySetId of the keys being released.
	* Releasing keys from a device invalidates them for all sessions.
	*
	* init container-specific data, its meaning is interpreted based on the mime type
	* provided in the mimeType parameter.  It could contain, for example, the content
	* ID, key ID or other data obtained from the content metadata that is required in
	* generating the key request. init may be null when keyType is KEY_TYPE_RELEASE.
	*
	* initSize is the number of bytes of initData
	*
	* mimeType identifies the mime type of the content.
	*
	* keyType specifes the type of the request. The request may be to acquire keys for
	*   streaming or offline content, or to release previously acquired keys, which are
	*   identified by a keySetId.
	*
	* optionalParameters are included in the key request message to allow a client
	*   application to provide additional message parameters to the server.
	*
	* numOptionalParameters indicates the number of optional parameters provided
	*   by the caller
	*
	* On exit:
	*   If this returns AMEDIA_OK,
	*   1. The keyRequest pointer will reference the opaque key request data.  It
	*       will reside in memory owned by the AMediaDrm object, and will remain
	*       accessible until the next call to either AMediaDrm_getKeyRequest
	*       or AMediaDrm_getKeyRequestWithDefaultUrlAndType or until the
	*       MediaDrm object is released.
	*   2. keyRequestSize will be set to the size of the request.
	*   3. defaultUrl will be set to the recommended URL to deliver the key request.
	*      The defaultUrl pointer will reference a NULL terminated URL string.
	*      It will be UTF-8 encoded and have same lifetime with the key request data
	*      KeyRequest pointer references to. Passing in NULL means you don't need it
	*      to be reported.
	*   4. keyRequestType will be set to the key request type. Passing in NULL means
	*       you don't need it to be reported.
	*
	* Returns AMEDIA_DRM_NOT_PROVISIONED if reprovisioning is needed, due to a
	* problem with the device certificate.
	*
	* Available since API level 33.
	*/
	AMediaDrm_getKeyRequestWithDefaultUrlAndType :: proc(
	drm: ^AMediaDrm,
	scope: ^AMediaDrmScope,
	init: [^]byte,
	initSize: uint,
	mimeType: cstring,
	keyType: AMediaDrmKeyType,
	optionalParameters: [^]AMediaDrmKeyValue,
	numOptionalParameters: uint,
	keyRequest: ^[^]byte,
	keyRequestSize: ^uint,
	defaultUrl: ^cstring,
	keyRequestType: ^AMediaDrmKeyRequestType) -> media_status_t ---

	/**
	* A key response is received from the license server by the app, then it is
	* provided to the DRM engine plugin using provideKeyResponse.  When the
	* response is for an offline key request, a keySetId is returned that can be
	* used to later restore the keys to a new session with AMediaDrm_restoreKeys.
	* When the response is for a streaming or release request, a null keySetId is
	* returned.
	*
	* scope may be a sessionId or keySetId depending on the type of the
	* response.  Scope should be set to the sessionId when the response is for either
	* streaming or offline key requests.  Scope should be set to the keySetId when
	* the response is for a release request.
	*
	* response points to the opaque response from the server
	* responseSize should be set to the size of the response in bytes
	*
	* Available since API level 21.
	*/
	AMediaDrm_provideKeyResponse :: proc(
	drm: ^AMediaDrm,
	scope: ^AMediaDrmScope,
	response: [^]byte,
	responseSize: uint,
	keySetId: ^AMediaDrmKeySetId) -> media_status_t ---

	/**
	* Restore persisted offline keys into a new session.  keySetId identifies the
	* keys to load, obtained from a prior call to AMediaDrm_provideKeyResponse.
	*
	* sessionId is the session ID for the DRM session.
	* keySetId identifies the saved key set to restore.
	*
	* Available since API level 21.
	*/
	AMediaDrm_restoreKeys :: proc(drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId, keySetId: ^AMediaDrmKeySetId) -> media_status_t ---

	/**
	* Remove the current keys from a session.
	*
	* keySetId identifies keys to remove.
	*
	* Available since API level 21.
	*/
	AMediaDrm_removeKeys :: proc(drm: ^AMediaDrm, keySetId: ^AMediaDrmSessionId) -> media_status_t ---

	/**
	* Request an informative description of the key status for the session.  The status is
	* in the form of {key, value} pairs.  Since DRM license policies vary by vendor,
	* the specific status field names are determined by each DRM vendor.  Refer to your
	* DRM provider documentation for definitions of the field names for a particular
	* DRM engine plugin.
	*
	* On entry, numPairs should be set by the caller to the maximum number of pairs
	* that can be returned (the size of the array).  On exit, numPairs will be set
	* to the number of entries written to the array.  If the number of {key, value} pairs
	* to be returned is greater than *numPairs, AMEDIA_DRM_SHORT_BUFFER will be returned
	* and numPairs will be set to the number of pairs available.
	*
	* Available since API level 21.
	*/
	AMediaDrm_queryKeyStatus :: proc(drm: ^AMediaDrm, sessionId: ^AMediaDrmSessionId, keyValuePairs: [^]AMediaDrmKeyValue, numPairs: ^uint) -> media_status_t ---


	/**
	* A provision request/response exchange occurs between the app and a provisioning
	* server to retrieve a device certificate.  If provisionining is required, the
	* EVENT_PROVISION_REQUIRED event will be sent to the event handler.
	* getProvisionRequest is used to obtain the opaque provision request byte array that
	* should be delivered to the provisioning server.
	* On exit:
	*    1. The provision request data will be referenced by provisionRequest, in
	*        memory owned by the AMediaDrm object.  It will remain accessible until the
	*        next call to getProvisionRequest.
	*    2. provisionRequestSize will be set to the size of the request data.
	*    3. serverUrl will reference a NULL terminated string containing the URL
	*       the provisioning request should be sent to.  It will remain accessible until
	*       the next call to getProvisionRequest.
	*
	* Available since API level 21.
	*/
	AMediaDrm_getProvisionRequest :: proc(drm: ^AMediaDrm, provisionRequest: ^[^]byte, provisionRequestSize: ^uint, serverUrl: ^cstring) -> media_status_t ---

	/**
	* After a provision response is received by the app, it is provided to the DRM
	* engine plugin using this method.
	*
	* response is the opaque provisioning response byte array to provide to the
	*   DRM engine plugin.
	* responseSize is the length of the provisioning response in bytes.
	*
	* Returns AMEDIA_DRM_DEVICE_REVOKED if the response indicates that the
	* server rejected the request
	*
	* Available since API level 21.
	*/
	AMediaDrm_provideProvisionResponse :: proc(drm: ^AMediaDrm, response: [^]byte, responseSize: uint) -> media_status_t ---

	/**
	* A means of enforcing limits on the number of concurrent streams per subscriber
	* across devices is provided via SecureStop. This is achieved by securely
	* monitoring the lifetime of sessions.
	*
	* Information from the server related to the current playback session is written
	* to persistent storage on the device when each MediaCrypto object is created.
	*
	* In the normal case, playback will be completed, the session destroyed and the
	* Secure Stops will be queried. The app queries secure stops and forwards the
	* secure stop message to the server which verifies the signature and notifies the
	* server side database that the session destruction has been confirmed. The persisted
	* record on the client is only removed after positive confirmation that the server
	* received the message using releaseSecureStops().
	*
	* numSecureStops is set by the caller to the maximum number of secure stops to
	* return.  On exit, *numSecureStops will be set to the number actually returned.
	* If *numSecureStops is too small for the number of secure stops available,
	* AMEDIA_DRM_SHORT_BUFFER will be returned and *numSecureStops will be set to the
	* number required.
	*
	* Available since API level 21.
	*/
	AMediaDrm_getSecureStops :: proc(drm: ^AMediaDrm, secureStops: ^AMediaDrmSecureStop, numSecureStops: ^uint) -> media_status_t ---

	/**
	* Process the SecureStop server response message ssRelease.  After authenticating
	* the message, remove the SecureStops identified in the response.
	*
	* ssRelease is the server response indicating which secure stops to release
	*
	* Available since API level 21.
	*/
	AMediaDrm_releaseSecureStops :: proc(drm: ^AMediaDrm, ssRelease: ^AMediaDrmSecureStop) -> media_status_t ---

	/**
	* Read a DRM engine plugin String property value, given the property name string.
	*
	* propertyName identifies the property to query
	* On return, propertyValue will be set to point to the property value.  The
	* memory that the value resides in is owned by the NDK MediaDrm API and
	* will remain valid until the next call to AMediaDrm_getPropertyString.
	*
	* Available since API level 21.
	*/
	AMediaDrm_getPropertyString :: proc(drm: ^AMediaDrm, propertyName: cstring, propertyValue: ^cstring) -> media_status_t ---

	/**
	* Read a DRM engine plugin byte array property value, given the property name string.
	* On return, *propertyValue will be set to point to the property value.  The
	* memory that the value resides in is owned by the NDK MediaDrm API and
	* will remain valid until the next call to AMediaDrm_getPropertyByteArray.
	*
	* Available since API level 21.
	*/
	AMediaDrm_getPropertyByteArray :: proc(drm: ^AMediaDrm, propertyName: cstring, propertyValue: ^AMediaDrmByteArray) -> media_status_t ---

	/**
	* Set a DRM engine plugin String property value.
	*
	* Available since API level 21.
	*/
	AMediaDrm_setPropertyString :: proc(drm: ^AMediaDrm, propertyName: cstring, value: cstring) -> media_status_t ---

	/**
	* Set a DRM engine plugin byte array property value.
	*
	* Available since API level 21.
	*/
	AMediaDrm_setPropertyByteArray :: proc(drm: ^AMediaDrm, propertyName: cstring, value: [^]byte, valueSize: uint) -> media_status_t ---

	/**
	* In addition to supporting decryption of DASH Common Encrypted Media, the
	* MediaDrm APIs provide the ability to securely deliver session keys from
	* an operator's session key server to a client device, based on the factory-installed
	* root of trust, and then perform encrypt, decrypt, sign and verify operations
	* with the session key on arbitrary user data.
	*
	* Operators create session key servers that receive session key requests and provide
	* encrypted session keys which can be used for general purpose crypto operations.
	*
	* Generic encrypt/decrypt/sign/verify methods are based on the established session
	* keys.  These keys are exchanged using the getKeyRequest/provideKeyResponse methods.
	*
	* Applications of this capability include securing various types of purchased or
	* private content, such as applications, books and other media, photos or media
	* delivery protocols.
	*/

	/*
	* Encrypt the data referenced by input of length dataSize using algorithm specified
	* by cipherAlgorithm, and write the encrypted result into output.  The caller must
	* ensure that the output buffer is large enough to accept dataSize bytes. The key
	* to use is identified by the 16 byte keyId.  The key must have been loaded into
	* the session using provideKeyResponse.
	*
	* Available since API level 21.
	*/
	AMediaDrm_encrypt :: proc(
	drm: ^AMediaDrm,
	sessionId: ^AMediaDrmSessionId,
	cipherAlgorithm: cstring,
	keyId: [^]byte,
	iv: [^]byte,
	input: [^]byte,
	output: [^]byte,
	dataSize: uint) -> media_status_t ---

	/*
	* Decrypt the data referenced by input of length dataSize using algorithm specified
	* by cipherAlgorithm, and write the decrypted result into output.  The caller must
	* ensure that the output buffer is large enough to accept dataSize bytes.  The key
	* to use is identified by the 16 byte keyId.  The key must have been loaded into
	* the session using provideKeyResponse.
	*
	* Available since API level 21.
	*/
	AMediaDrm_decrypt :: proc(
	drm: ^AMediaDrm,
	sessionId: ^AMediaDrmSessionId,
	cipherAlgorithm: cstring,
	keyId: [^]byte,
	iv: [^]byte,
	input: [^]byte,
	output: [^]byte,
	dataSize: uint) -> media_status_t ---

	/*
	* Generate a signature using the specified macAlgorithm over the message data
	* referenced by message of size messageSize and store the signature in the
	* buffer referenced signature of max size *signatureSize.  If the buffer is not
	* large enough to hold the signature, AMEDIA_DRM_SHORT_BUFFER is returned and
	* *signatureSize is set to the buffer size required.  The key to use is identified
	* by the 16 byte keyId.  The key must have been loaded into the session using
	* provideKeyResponse.
	*
	* Available since API level 21.
	*/
	AMediaDrm_sign :: proc(
	drm: ^AMediaDrm,
	sessionId: ^AMediaDrmSessionId,
	macAlgorithm: cstring,
	keyId: [^]byte,
	message: [^]byte,
	messageSize: uint,
	signature: [^]byte,
	signatureSize: ^uint) -> media_status_t ---

	/*
	* Perform a signature verification using the specified macAlgorithm over the message
	* data referenced by the message parameter of size messageSize. Returns AMEDIA_OK
	* if the signature matches, otherwise MEDAIDRM_VERIFY_FAILED is returned. The key to
	* use is identified by the 16 byte keyId.  The key must have been loaded into the
	* session using provideKeyResponse.
	*
	* Available since API level 21.
	*/
	AMediaDrm_verify :: proc(
	drm: ^AMediaDrm,
	sessionId: ^AMediaDrmSessionId,
	macAlgorithm: cstring,
	keyId: [^]byte,
	message: [^]byte,
	messageSize: uint,
	signature: [^]byte,
	signatureSize: uint) -> media_status_t ---
}
