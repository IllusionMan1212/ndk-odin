package android

/**
 * Set to 1 if this is an NDK, unset otherwise. See
 * https://android.googlesource.com/platform/bionic/+/master/docs/defines.md.
 */
__ANDROID_NDK__ :: 1

/**
 * Major version of this NDK.
 *
 * For example: 16 for r16.
 */
__NDK_MAJOR__ :: 26

/**
 * Minor version of this NDK.
 *
 * For example: 0 for r16 and 1 for r16b.
 */
__NDK_MINOR__ :: 1

/**
 * Set to 0 if this is a release build, or 1 for beta 1,
 * 2 for beta 2, and so on.
 */
__NDK_BETA__ :: 0

/**
 * Build number for this NDK.
 *
 * For a local development build of the NDK, this is -1.
 */
__NDK_BUILD__ :: 10909125

/**
 * Set to 1 if this is a canary build, 0 if not.
 */
__NDK_CANARY__ :: 0

