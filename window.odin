package android

/**
 * Window flags, as per the Java API at android.view.WindowManager.LayoutParams.
 */
WindowFlagsBits :: enum u32 {
    /**
     * As long as this window is visible to the user, allow the lock
     * screen to activate while the screen is on.  This can be used
     * independently, or in combination with {@link
     * KEEP_SCREEN_ON} and/or {@link
     * SHOW_WHEN_LOCKED}
     */
    ALLOW_LOCK_WHILE_SCREEN_ON = 0,
    /** Everything behind this window will be dimmed. */
    DIM_BEHIND                 = 1,
    /**
     * Blur everything behind this window.
     * @deprecated Blurring is no longer supported.
     */
    BLUR_BEHIND                = 2,
    /**
     * This window won't ever get key input focus, so the
     * user can not send key or other button events to it.  Those will
     * instead go to whatever focusable window is behind it.  This flag
     * will also enable {@link NOT_TOUCH_MODAL} whether or not that
     * is explicitly set.
     *
     * Setting this flag also implies that the window will not need to
     * interact with
     * a soft input method, so it will be Z-ordered and positioned
     * independently of any active input method (typically this means it
     * gets Z-ordered on top of the input method, so it can use the full
     * screen for its content and cover the input method if needed.  You
     * can use {@link ALT_FOCUSABLE_IM} to modify this behavior.
     */
    NOT_FOCUSABLE              = 3,
    /** this window can never receive touch events. */
    NOT_TOUCHABLE              = 4,
    /**
     * Even when this window is focusable (its
     * {@link NOT_FOCUSABLE} is not set), allow any pointer events
     * outside of the window to be sent to the windows behind it.  Otherwise
     * it will consume all pointer events itself, regardless of whether they
     * are inside of the window.
     */
    NOT_TOUCH_MODAL            = 5,
    /**
     * When set, if the device is asleep when the touch
     * screen is pressed, you will receive this first touch event.  Usually
     * the first touch event is consumed by the system since the user can
     * not see what they are pressing on.
     *
     * @deprecated This flag has no effect.
     */
    TOUCHABLE_WHEN_WAKING      = 6,
    /**
     * As long as this window is visible to the user, keep
     * the device's screen turned on and bright.
     */
    KEEP_SCREEN_ON             = 7,
    /**
     * Place the window within the entire screen, ignoring
     * decorations around the border (such as the status bar).  The
     * window must correctly position its contents to take the screen
     * decoration into account.
     */
    LAYOUT_IN_SCREEN           = 8,
    /** allow window to extend outside of the screen. */
    LAYOUT_NO_LIMITS           = 9,
    /**
     * Hide all screen decorations (such as the status
     * bar) while this window is displayed.  This allows the window to
     * use the entire display space for itself -- the status bar will
     * be hidden when an app window with this flag set is on the top
     * layer. A fullscreen window will ignore a value of
     * <a href="/reference/android/view/WindowManager.LayoutParams#SOFT_INPUT_ADJUST_RESIZE">
     * SOFT_INPUT_ADJUST_RESIZE</a>; the window will stay
     * fullscreen and will not resize.
     */
    FULLSCREEN                 = 10,
    /**
     * Override {@link FULLSCREEN} and force the
     * screen decorations (such as the status bar) to be shown.
     */
    FORCE_NOT_FULLSCREEN       = 11,
    /**
     * Turn on dithering when compositing this window to
     * the screen.
     * @deprecated This flag is no longer used.
     */
    DITHER                     = 12,
    /**
     * Treat the content of the window as secure, preventing
     * it from appearing in screenshots or from being viewed on non-secure
     * displays.
     */
    SECURE                     = 13,
    /**
     * A special mode where the layout parameters are used
     * to perform scaling of the surface when it is composited to the
     * screen.
     */
    SCALED                     = 14,
    /**
     * Intended for windows that will often be used when the user is
     * holding the screen against their face, it will aggressively
     * filter the event stream to prevent unintended presses in this
     * situation that may not be desired for a particular window, when
     * such an event stream is detected, the application will receive
     * a {@link AMOTION_EVENT_ACTION_CANCEL} to indicate this so
     * applications can handle this accordingly by taking no action on
     * the event until the finger is released.
     */
    IGNORE_CHEEK_PRESSES       = 15,
    /**
     * A special option only for use in combination with
     * {@link LAYOUT_IN_SCREEN}.  When requesting layout in the
     * screen your window may appear on top of or behind screen decorations
     * such as the status bar.  By also including this flag, the window
     * manager will report the inset rectangle needed to ensure your
     * content is not covered by screen decorations.
     */
    LAYOUT_INSET_DECOR         = 16,
    /**
     * Invert the state of {@link NOT_FOCUSABLE} with
     * respect to how this window interacts with the current method.
     * That is, if FLAG_NOT_FOCUSABLE is set and this flag is set,
     * then the window will behave as if it needs to interact with the
     * input method and thus be placed behind/away from it; if {@link
     * NOT_FOCUSABLE} is not set and this flag is set,
     * then the window will behave as if it doesn't need to interact
     * with the input method and can be placed to use more space and
     * cover the input method.
     */
    ALT_FOCUSABLE_IM           = 17,
    /**
     * If you have set {@link NOT_TOUCH_MODAL}, you
     * can set this flag to receive a single special MotionEvent with
     * the action
     * {@link AMOTION_EVENT_ACTION_OUTSIDE} for
     * touches that occur outside of your window.  Note that you will not
     * receive the full down/move/up gesture, only the location of the
     * first down as an {@link AMOTION_EVENT_ACTION_OUTSIDE}.
     */
    WATCH_OUTSIDE_TOUCH        = 18,
    /**
     * Special flag to let windows be shown when the screen
     * is locked. This will let application windows take precedence over
     * key guard or any other lock screens. Can be used with
     * {@link KEEP_SCREEN_ON} to turn screen on and display windows
     * directly before showing the key guard window.  Can be used with
     * {@link DISMISS_KEYGUARD} to automatically fully dismisss
     * non-secure keyguards.  This flag only applies to the top-most
     * full-screen window.
     */
    SHOW_WHEN_LOCKED           = 19,
    /**
     * Ask that the system wallpaper be shown behind
     * your window.  The window surface must be translucent to be able
     * to actually see the wallpaper behind it; this flag just ensures
     * that the wallpaper surface will be there if this window actually
     * has translucent regions.
     */
    SHOW_WALLPAPER             = 20,
    /**
     * When set as a window is being added or made
     * visible, once the window has been shown then the system will
     * poke the power manager's user activity (as if the user had woken
     * up the device) to turn the screen on.
     */
    TURN_SCREEN_ON             = 21,
    /**
     * When set the window will cause the keyguard to
     * be dismissed, only if it is not a secure lock keyguard.  Because such
     * a keyguard is not needed for security, it will never re-appear if
     * the user navigates to another window (in contrast to
     * {@link SHOW_WHEN_LOCKED}, which will only temporarily
     * hide both secure and non-secure keyguards but ensure they reappear
     * when the user moves to another UI that doesn't hide them).
     * If the keyguard is currently active and is secure (requires an
     * unlock pattern) than the user will still need to confirm it before
     * seeing this window, unless {@link SHOW_WHEN_LOCKED} has
     * also been set.
     */
    DISMISS_KEYGUARD           = 22,
}

WindowFlags :: bit_set[WindowFlagsBits; u32]

