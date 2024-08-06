//+build android
package android

import "core:c"

/**
 * This structure defines the native side of an android.app.NativeActivity.
 * It is created by the framework, and handed to the application's native
 * code as it is being launched.
 */
ANativeActivity :: struct {
    /**
     * Pointer to the callback function table of the native application.
     * You can set the functions here to your own callbacks.  The callbacks
     * pointer itself here should not be changed, it is allocated and managed
     * for you by the framework.
     */
    callbacks: ^ANativeActivityCallbacks,

    /**
     * The global handle on the process's Java VM.
     */
    vm: ^JavaVM,

    /**
     * JNI context for the main thread of the app.  Note that this field
     * can ONLY be used from the main thread of the process, that is, the
     * thread that calls into the ANativeActivityCallbacks.
     */
    env: ^JNIEnv,

    /**
     * The NativeActivity object handle.
     *
     * IMPORTANT NOTE: This member is mis-named. It should really be named
     * 'activity' instead of 'clazz', since it's a reference to the
     * NativeActivity instance created by the system for you.
     *
     * We unfortunately cannot change this without breaking NDK
     * source-compatibility.
     */
    clazz: jobject,

    /**
     * Path to this application's internal data directory.
     */
    internalDataPath: cstring,

    /**
     * Path to this application's external (removable/mountable) data directory.
     */
    externalDataPath: cstring,

    /**
     * The platform's SDK version code.
     */
    sdkVersion: c.int32_t,

    /**
     * This is the native instance of the application.  It is not used by
     * the framework, but can be set by the application to its own instance
     * state.
     */
    instance: rawptr,

    /**
     * Pointer to the Asset Manager instance for the application.  The application
     * uses this to access binary assets bundled inside its own .apk file.
     */
    assetManager: ^AAssetManager,

    /**
     * Available starting with Honeycomb: path to the directory containing
     * the application's OBB files (if any).  If the app doesn't have any
     * OBB files, this directory may not exist.
     */
    obbPath: cstring,
}

/**
 * These are the callbacks the framework makes into a native application.
 * All of these callbacks happen on the main thread of the application.
 * By default, all callbacks are NULL; set to a pointer to your own function
 * to have it called.
 */
ANativeActivityCallbacks :: struct {
    /**
     * NativeActivity has started.  See Java documentation for Activity.onStart()
     * for more information.
	 */
	onStart: #type proc "c" (activity: ^ANativeActivity),

    /**
     * NativeActivity has resumed.  See Java documentation for Activity.onResume()
     * for more information.
     */
    onResume: #type proc "c" (activity: ^ANativeActivity),

    /**
     * Framework is asking NativeActivity to save its current instance state.
     * See Java documentation for Activity.onSaveInstanceState() for more
     * information.  The returned pointer needs to be created with malloc(),
     * the framework will call free() on it for you.  You also must fill in
     * outSize with the number of bytes in the allocation.  Note that the
     * saved state will be persisted, so it can not contain any active
     * entities (pointers to memory, file descriptors, etc).
     */
    onSaveInstanceState: #type proc "c" (activity: ^ANativeActivity, outSize: ^c.size_t) -> rawptr,

    /**
     * NativeActivity has paused.  See Java documentation for Activity.onPause()
     * for more information.
     */
    onPause: #type proc "c" (activity: ^ANativeActivity),

    /**
     * NativeActivity has stopped.  See Java documentation for Activity.onStop()
     * for more information.
     */
    onStop: #type proc "c" (activity: ^ANativeActivity),

    /**
     * NativeActivity is being destroyed.  See Java documentation for Activity.onDestroy()
     * for more information.
     */
    onDestroy: #type proc "c" (activity: ^ANativeActivity),

    /**
     * Focus has changed in this NativeActivity's window.  This is often used,
     * for example, to pause a game when it loses input focus.
     */
    onWindowFocusChanged: #type proc "c" (activity: ^ANativeActivity, hasFocus: c.int),

    /**
     * The drawing window for this native activity has been created.  You
     * can use the given native window object to start drawing.
     */
    onNativeWindowCreated: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),

    /**
     * The drawing window for this native activity has been resized.  You should
     * retrieve the new size from the window and ensure that your rendering in
     * it now matches.
     */
    onNativeWindowResized: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),

    /**
     * The drawing window for this native activity needs to be redrawn.  To avoid
     * transient artifacts during screen changes (such resizing after rotation),
     * applications should not return from this function until they have finished
     * drawing their window in its current state.
     */
    onNativeWindowRedrawNeeded: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),

    /**
     * The drawing window for this native activity is going to be destroyed.
     * You MUST ensure that you do not touch the window object after returning
     * from this function: in the common case of drawing to the window from
     * another thread, that means the implementation of this callback must
     * properly synchronize with the other thread to stop its drawing before
     * returning from here.
     */
    onNativeWindowDestroyed: #type proc "c" (activity: ^ANativeActivity, window: ^ANativeWindow),

    /**
     * The input queue for this native activity's window has been created.
     * You can use the given input queue to start retrieving input events.
     */
    onInputQueueCreated: #type proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue),

    /**
     * The input queue for this native activity's window is being destroyed.
     * You should no longer try to reference this object upon returning from this
     * function.
     */
    onInputQueueDestroyed: #type proc "c" (activity: ^ANativeActivity, queue: ^AInputQueue),

    /**
     * The rectangle in the window in which content should be placed has changed.
     */
    onContentRectChanged: #type proc "c" (activity: ^ANativeActivity, #by_ptr rect: ARect),

    /**
     * The current device AConfiguration has changed.  The new configuration can
     * be retrieved from assetManager.
     */
    onConfigurationChanged: #type proc "c" (activity: ^ANativeActivity),

    /**
     * The system is running low on memory.  Use this callback to release
     * resources you do not need, to help the system avoid killing more
     * important processes.
     */
    onLowMemory: #type proc "c" (activity: ^ANativeActivity),
}
