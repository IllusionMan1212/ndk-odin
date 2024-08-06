package android

// Apparently the app still needs to have a manifest, it also MUST use the nativeactivity activity.
// Apparently the native code MUST be built as a shared library and then loaded by the JNI(?)
// Good ref: https://github.com/xlab/android-go/blob/master/examples/build-android.sh
// Even better ref: https://github.com/mmozeiko/android-native-example
// Hmm, what if the Odin compiler itself has support for an Android target, it would build the shared lib, link everything,
// package the app as an apk too. The minSdk level can be set using Odin's comptime defines, if any necessary define is missing
// the compiler refuses to build, or maybe the compiler just silently reads the build.gradle file and search for the minSdk define??
// that would require that Odin Android apps MUST have the android file structure with some required files.
// Or maybe the Odin compiler will generate those files ??? so many possiblities and options.
// 
// The above is a problem for later, let's just get a basic Odin Android app building and hopefully running.

// TODO: We need some sort of way to guard against calling __INTRODUCED_IN(30) procs in older
// Android versions, preferably a way to have the compiler complain.
// Maybe some sort of #config that the user has to define and maybe we can @disabled these procs
// if the version isn't compatible.
// @disabled doesn't work on procs with a return value, a simple when ANDROID_API >= 30 {} works but it's still
// easily bypassable.
