package android

foreign import android "system:android"

foreign android {
	/**
	* Given a Dalvik AssetManager object, obtain the corresponding native AAssetManager
	* object.  Note that the caller is responsible for obtaining and holding a VM reference
	* to the jobject to prevent its being garbage collected while the native object is
	* in use.
	*/
	AAssetManager_fromJava :: proc(env: ^JNIEnv, assetManager: jobject) -> ^AAssetManager ---
}
