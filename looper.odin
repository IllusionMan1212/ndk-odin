//+build android
package android

import "core:c"

foreign import android "system:android"

/**
 * ALooper
 *
 * A looper is the state tracking an event loop for a thread.
 * Loopers do not define event structures or other such things; rather
 * they are a lower-level facility to attach one or more discrete objects
 * listening for an event.  An "event" here is simply data available on
 * a file descriptor: each attached object has an associated file descriptor,
 * and waiting for "events" means (internally) polling on all of these file
 * descriptors until one or more of them have data available.
 *
 * A thread can have only one ALooper associated with it.
 */
ALooper :: struct{}

foreign android {
	/**
	 * Like ALooper_pollOnce(), but performs all pending callbacks until all
	 * data has been consumed or a file descriptor is available with no callback.
	 * This function will never return ALOOPER_POLL_CALLBACK.
	 */
	ALooper_pollAll :: proc(timeoutMillis: c.int, outFd: ^c.int, outEvents: ^c.int, outData: ^rawptr) -> c.int ---
}
