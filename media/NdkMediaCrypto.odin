//+build android
package mediandk

foreign import mediandk "system:mediandk"

AMediaCrypto :: struct{}
AMediaUUID :: [16]u8

foreign mediandk {
	/**
	 * Available since API level 21.
	 */
	AMediaCrypto_isCryptoSchemeSupported :: proc(uuid: AMediaUUID) -> bool ---

	/**
	* Available since API level 21.
	*/
	AMediaCrypto_requiresSecureDecoderComponent :: proc(mime: cstring) -> bool ---

	/**
	* Available since API level 21.
	*/
	AMediaCrypto_new :: proc(uuid: AMediaUUID, initData: rawptr, initDataSize: uint) -> ^AMediaCrypto ---

	/**
	* Available since API level 21.
	*/
	AMediaCrypto_delete :: proc(crypto: ^AMediaCrypto) ---
}
