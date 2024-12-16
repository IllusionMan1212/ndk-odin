package android

import "core:c"

/**
 * Rectangular window area.
 *
 * This is the NDK equivalent of the android.graphics.Rect class in Java. It is
 * used with {@link ANativeActivityCallbacks::onContentRectChanged} event
 * callback and the ANativeWindow_lock() function.
 *
 * In a valid ARect, left <= right and top <= bottom. ARect with left=0, top=10,
 * right=1, bottom=11 contains only one pixel at x=0, y=10.
 */
ARect :: struct {
    /// Minimum X coordinate of the rectangle.
	left: c.int32_t,
    /// Minimum Y coordinate of the rectangle.
    top: c.int32_t,
    /// Maximum X coordinate of the rectangle.
    right: c.int32_t,
    /// Maximum Y coordinate of the rectangle.
    bottom: c.int32_t,
}

