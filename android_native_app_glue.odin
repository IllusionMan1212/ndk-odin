package android

import "core:c"
import "core:sys/posix"

foreign import android "system:android"

// NOTE: As far as I know and have tested, pthread from sys/unix SHOULD work fine on android.
// Android doesn't support thread cancellation so those procs need to be commented out when compiling the native shared lib.
// Odin's threading library has been tested with Cat & Onion and it seems to work just fine there.
 
AppCmd :: enum c.int32_t {
    /**
     * Command from main thread: the AInputQueue has changed.  Upon processing
     * this command, android_app->inputQueue will be updated to the new queue
     * (or NULL).
     */
    INPUT_CHANGED,

    /**
     * Command from main thread: a new ANativeWindow is ready for use.  Upon
     * receiving this command, android_app->window will contain the new window
     * surface.
     */
    INIT_WINDOW,

    /**
     * Command from main thread: the existing ANativeWindow needs to be
     * terminated.  Upon receiving this command, android_app->window still
     * contains the existing window; after calling android_app_exec_cmd
     * it will be set to NULL.
     */
    TERM_WINDOW,

    /**
     * Command from main thread: the current ANativeWindow has been resized.
     * Please redraw with its new size.
     */
    WINDOW_RESIZED,

    /**
     * Command from main thread: the system needs that the current ANativeWindow
     * be redrawn.  You should redraw the window before handing this to
     * android_app_exec_cmd() in order to avoid transient drawing glitches.
     */
    WINDOW_REDRAW_NEEDED,

    /**
     * Command from main thread: the content area of the window has changed,
     * such as from the soft input window being shown or hidden.  You can
     * find the new content rect in android_app::contentRect.
     */
    CONTENT_RECT_CHANGED,

    /**
     * Command from main thread: the app's activity window has gained
     * input focus.
     */
    GAINED_FOCUS,

    /**
     * Command from main thread: the app's activity window has lost
     * input focus.
     */
    LOST_FOCUS,

    /**
     * Command from main thread: the current device configuration has changed.
     */
    CONFIG_CHANGED,

    /**
     * Command from main thread: the system is running low on memory.
     * Try to reduce your memory use.
     */
    LOW_MEMORY,

    /**
     * Command from main thread: the app's activity has been started.
     */
    START,

    /**
     * Command from main thread: the app's activity has been resumed.
     */
    RESUME,

    /**
     * Command from main thread: the app should generate a new saved state
     * for itself, to restore from later if needed.  If you have saved state,
     * allocate it with malloc and place it in android_app.savedState with
     * the size in android_app.savedStateSize.  The will be freed for you
     * later.
     */
    SAVE_STATE,

    /**
     * Command from main thread: the app's activity has been paused.
     */
    PAUSE,

    /**
     * Command from main thread: the app's activity has been stopped.
     */
    STOP,

    /**
     * Command from main thread: the app's activity is being destroyed,
     * and waiting for the app thread to clean up and exit before proceeding.
     */
    DESTROY,
}

android_poll_source :: struct {
    // The identifier of this source.  May be LOOPER_ID_MAIN or
    // LOOPER_ID_INPUT.
	id: c.int32_t,

    // The android_app this ident is associated with.
    app: ^android_app,

    // Function to call to perform the standard processing of data from
    // this source.
    process: #type proc "c" (app: ^android_app, source: ^android_poll_source),
}

android_app :: struct {
    // The application can place a pointer to its own state object
    // here if it likes.
	userData: rawptr,

    // Fill this in with the function to process main app commands (APP_CMD_*)
    onAppCmd: #type proc "c" (app: ^android_app, cmd: AppCmd),

    // Fill this in with the function to process input events.  At this point
    // the event has already been pre-dispatched, and it will be finished upon
    // return.  Return 1 if you have handled the event, 0 for any default
    // dispatching.
    onInputEvent: #type proc "c" (app: ^android_app, event: ^AInputEvent) -> c.int32_t,

    // The ANativeActivity object instance that this app is running in.
    activity: ^ANativeActivity,

    // The current configuration the app is running in.
    config: ^AConfiguration,

    // This is the last instance's saved state, as provided at creation time.
    // It is NULL if there was no state.  You can use this as you need, the
    // memory will remain around until you call android_app_exec_cmd() for
    // APP_CMD_RESUME, at which point it will be freed and savedState set to NULL.
    // These variables should only be changed when processing a APP_CMD_SAVE_STATE,
    // at which point they will be initialized to NULL and you can malloc your
    // state and place the information here.  In that case the memory will be
    // freed for you later.
    savedState: rawptr,
    savedStateSize: c.size_t,

    // The ALooper associated with the app's thread.
    looper: ^ALooper,

    // When non-NULL, this is the input queue from which the app will
    // receive user input events.
    inputQueue: ^AInputQueue,

    // When non-NULL, this is the window surface that the app can draw in.
    window: ^ANativeWindow,

    // Current content rectangle of the window, this is the area where the
    // window's content should be placed to be seen by the user.
    contentRect: ARect,

    // Current state of the app's activity.  May be either APP_CMD_START,
    // APP_CMD_RESUME, APP_CMD_PAUSE, or APP_CMD_STOP, see below.
    activityState: c.int,

    // This is non-zero when the application's NativeActivity is being
    // destroyed and waiting for the app thread to complete.
    // The android_main function must return to its caller if this is non-zero.
    destroyRequested: c.int,

    // -------------------------------------------------
    // Below are "private" implementation of the glue code.

    mutex: posix.pthread_mutex_t,
    cond: posix.pthread_cond_t,

    msgread: c.int,
    msgwrite: c.int,

    thread: posix.pthread_t,

    cmdPollSource: android_poll_source,
    inputPollSource: android_poll_source,

    running: c.int,
    stateSaved: c.int,
    destroyed: c.int,
    redrawNeeded: c.int,
    pendingInputQueue: ^AInputQueue,
    pendingWindow: ^ANativeWindow,
    pendingContentRect: ARect,
}

foreign android {
	app_dummy :: proc() ---
}
