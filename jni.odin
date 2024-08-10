//+build android
package android

import "core:c"

JNI_VERSION_1_1 :: 0x00010001
JNI_VERSION_1_2 :: 0x00010002
JNI_VERSION_1_4 :: 0x00010004
JNI_VERSION_1_6 :: 0x00010006

JNI_OK         :: (0)         /* no error */
JNI_ERR        :: (-1)        /* generic error */
JNI_EDETACHED  :: (-2)        /* thread detached from the VM */
JNI_EVERSION   :: (-3)        /* JNI version error */
JNI_ENOMEM     :: (-4)        /* Out of memory */
JNI_EEXIST     :: (-5)        /* VM already created */
JNI_EINVAL     :: (-6)        /* Invalid argument */

JNI_COMMIT     :: 1           /* copy content, do not free buffer */
JNI_ABORT      :: 2           /* free buffer w/o copying back */


/* Primitive types that match up with Java equivalents. */
jboolean :: c.uint8_t  /* unsigned 8 bits */
jbyte    :: c.int8_t   /* signed 8 bits */
jchar    :: c.uint16_t /* unsigned 16 bits */
jshort   :: c.int16_t  /* signed 16 bits */
jint     :: c.int32_t  /* signed 32 bits */
jlong    :: c.int64_t  /* signed 64 bits */
jfloat   :: c.float    /* 32-bit IEEE 754 */
jdouble  :: c.double   /* 64-bit IEEE 754 */

/* "cardinal indices and sizes" */
jsize :: jint

/*
 * Reference types, in C.
 */
jobject       :: distinct rawptr
jclass        :: distinct jobject
jstring       :: distinct jobject
jarray        :: distinct jobject
jobjectArray  :: distinct jarray
jbooleanArray :: distinct jarray
jbyteArray    :: distinct jarray
jcharArray    :: distinct jarray
jshortArray   :: distinct jarray
jintArray     :: distinct jarray
jlongArray    :: distinct jarray
jfloatArray   :: distinct jarray
jdoubleArray  :: distinct jarray
jthrowable    :: distinct jobject
jweak         :: distinct jobject

// Opaque
jfieldID :: rawptr
jmethodID :: rawptr

jvalue :: struct #raw_union {
	z: jboolean,
    b: jbyte,
    c: jchar,
    s: jshort,
    i: jint,
    j: jlong,
    f: jfloat,
    d: jdouble,
    l: jobject,
}

jobjectRefType :: enum c.int {
    JNIInvalidRefType = 0,
    JNILocalRefType = 1,
    JNIGlobalRefType = 2,
    JNIWeakGlobalRefType = 3
}

JNINativeMethod :: struct {
	name: cstring,
    signature: cstring,
    fnPtr: rawptr,
}

JavaVM :: ^JNIInvokeInterface
JNIEnv :: ^JNINativeInterface

// NOTE: JNINativeInterface and JNIInvokeInterface don't use the aliased pointer types because of they're considered
// not defined when used inside the structs so we just refer to the struct itself and add an extra pointer hat ^

/*
 * Table of interface function pointers.
 */
JNINativeInterface :: struct {
    reserved0: rawptr,
    reserved1: rawptr,
    reserved2: rawptr,
    reserved3: rawptr,

    GetVersion: #type proc "c" (jni: ^^JNINativeInterface) -> jint,

    DefineClass: #type proc "c" (jni: ^^JNINativeInterface, name: cstring, loader: jobject, #by_ptr buf: jbyte, bufLen: jsize) -> jclass,
    FindClass: #type proc "c" (jni: ^^JNINativeInterface, name: cstring) -> jclass,

    FromReflectedMethod: #type proc "c" (jni: ^^JNINativeInterface, method: jobject) -> jmethodID,
    FromReflectedField: #type proc "c" (jni: ^^JNINativeInterface, field: jobject) -> jfieldID,
    /* spec doesn't show jboolean parameter */
    ToReflectedMethod: #type proc "c" (jni: ^^JNINativeInterface, cls: jclass, methodID: jmethodID, isStatic: jboolean) -> jobject,

    GetSuperclass: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass) -> jclass,
    IsAssignableFrom: #type proc "c" (jni: ^^JNINativeInterface, clazz1: jclass, clazz2: jclass) -> jboolean,

    /* spec doesn't show jboolean parameter */
    ToReflectedField: #type proc "c" (jni: ^^JNINativeInterface, cls: jclass, fieldID: jfieldID, isStatic: jboolean) -> jobject,

    Throw: #type proc "c" (jni: ^^JNINativeInterface, obj: jthrowable) -> jint,
    ThrowNew: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, message: cstring) -> jint,
    ExceptionOccurred: #type proc "c" (jni: ^^JNINativeInterface),
    ExceptionDescribe: #type proc "c" (jni: ^^JNINativeInterface),
    ExceptionClear: #type proc "c" (jni: ^^JNINativeInterface),
    FatalError: #type proc "c" (jni: ^^JNINativeInterface, msg: cstring),

    PushLocalFrame: #type proc "c" (jni: ^^JNINativeInterface, capacity: jint) -> jint,
    PopLocalFrame: #type proc "c" (jni: ^^JNINativeInterface, result: jobject) -> jobject,

    NewGlobalRef: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jobject,
    DeleteGlobalRef: #type proc "c" (jni: ^^JNINativeInterface, globalRef: jobject),
    DeleteLocalRef: #type proc "c" (jni: ^^JNINativeInterface, localRef: jobject),
    IsSameObject: #type proc "c" (jni: ^^JNINativeInterface, ref1: jobject, ref2: jobject) -> jboolean,

    NewLocalRef: #type proc "c" (jni: ^^JNINativeInterface, ref: jobject) -> jobject,
    EnsureLocalCapacity: #type proc "c" (jni: ^^JNINativeInterface, capacity: jint) -> jint,

    AllocObject: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass) -> jobject,
    NewObject: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jobject,
    NewObjectV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jobject,
    NewObjectA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jobject,

    GetObjectClass: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jclass,
    IsInstanceOf: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass) -> jboolean,
    GetMethodID: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, name: cstring, sig: cstring) -> jmethodID,

	// TODO: should va_list args be pointers?
    CallObjectMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jobject,
    CallObjectMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jobject,
    CallObjectMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jobject,
    CallBooleanMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jboolean,
    CallBooleanMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jboolean,
    CallBooleanMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jboolean,
    CallByteMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jbyte,
    CallByteMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jbyte,
    CallByteMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jbyte,
    CallCharMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jchar,
    CallCharMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jchar,
    CallCharMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jchar,
    CallShortMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jshort,
    CallShortMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jshort,
    CallShortMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jshort,
    CallIntMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jint,
    CallIntMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jint,
    CallIntMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jint,
    CallLongMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jlong,
    CallLongMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jlong,
    CallLongMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jlong,
    CallFloatMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jfloat,
    CallFloatMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jfloat,
    CallFloatMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jfloat,
    CallDoubleMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any) -> jdouble,
    CallDoubleMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list) -> jdouble,
    CallDoubleMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue) -> jdouble,
    CallVoidMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #c_vararg args: ..any),
    CallVoidMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, args: ^c.va_list),
    CallVoidMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, methodID: jmethodID, #by_ptr args: jvalue),

    CallNonvirtualObjectMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jobject,
    CallNonvirtualObjectMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jobject,
    CallNonvirtualObjectMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jobject,
    CallNonvirtualBooleanMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jboolean,
    CallNonvirtualBooleanMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jboolean,
    CallNonvirtualBooleanMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jboolean,
    CallNonvirtualByteMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jbyte,
    CallNonvirtualByteMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jbyte,
    CallNonvirtualByteMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jbyte,
    CallNonvirtualCharMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jchar,
    CallNonvirtualCharMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jchar,
    CallNonvirtualCharMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jchar,
    CallNonvirtualShortMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jshort,
    CallNonvirtualShortMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jshort,
    CallNonvirtualShortMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jshort,
    CallNonvirtualIntMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jint,
    CallNonvirtualIntMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jint,
    CallNonvirtualIntMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jint,
    CallNonvirtualLongMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jlong,
    CallNonvirtualLongMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jlong,
    CallNonvirtualLongMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jlong,
    CallNonvirtualFloatMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jfloat,
    CallNonvirtualFloatMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jfloat,
    CallNonvirtualFloatMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jfloat,
    CallNonvirtualDoubleMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jdouble,
    CallNonvirtualDoubleMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jdouble,
    CallNonvirtualDoubleMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jdouble,
    CallNonvirtualVoidMethod: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any),
    CallNonvirtualVoidMethodV: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, args: ^c.va_list),
    CallNonvirtualVoidMethodA: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue),

    GetFieldID: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, name: cstring, sig: cstring) -> jfieldID,

    GetObjectField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jobject,
    GetBooleanField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jboolean,
    GetByteField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jbyte,
    GetCharField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jchar,
    GetShortField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jshort,
    GetIntField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jint,
    GetLongField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jlong,
    GetFloatField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jfloat,
    GetDoubleField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID) -> jdouble,

    SetObjectField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jobject),
    SetBooleanField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jboolean),
    SetByteField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jbyte),
    SetCharField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jchar),
    SetShortField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jshort),
    SetIntField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jint),
    SetLongField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jlong),
    SetFloatField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jfloat),
    SetDoubleField: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject, fieldID: jfieldID, value: jdouble),

    GetStaticMethodID: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, name: cstring, sig: cstring) -> jmethodID,

    CallStaticObjectMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jobject,
    CallStaticObjectMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jobject,
    CallStaticObjectMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jobject,
    CallStaticBooleanMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jboolean,
    CallStaticBooleanMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jboolean,
    CallStaticBooleanMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jboolean,
    CallStaticByteMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jbyte,
    CallStaticByteMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jbyte,
    CallStaticByteMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jbyte,
    CallStaticCharMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jchar,
    CallStaticCharMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jchar,
    CallStaticCharMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jchar,
    CallStaticShortMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jshort,
    CallStaticShortMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jshort,
    CallStaticShortMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jshort,
    CallStaticIntMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jint,
    CallStaticIntMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jint,
    CallStaticIntMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jint,
    CallStaticLongMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jlong,
    CallStaticLongMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jlong,
    CallStaticLongMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jlong,
    CallStaticFloatMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jfloat,
    CallStaticFloatMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jfloat,
    CallStaticFloatMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jfloat,
    CallStaticDoubleMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any) -> jdouble,
    CallStaticDoubleMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list) -> jdouble,
    CallStaticDoubleMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue) -> jdouble,
    CallStaticVoidMethod: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #c_vararg args: ..any),
    CallStaticVoidMethodV: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, args: ^c.va_list),
    CallStaticVoidMethodA: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methodID: jmethodID, #by_ptr args: jvalue),

    GetStaticFieldID: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, name: cstring, sig: cstring) -> jfieldID,

    GetStaticObjectField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jobject,
    GetStaticBooleanField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jboolean,
    GetStaticByteField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jbyte,
    GetStaticCharField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jchar,
    GetStaticShortField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jshort,
    GetStaticIntField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jint,
    GetStaticLongField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jlong,
    GetStaticFloatField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jfloat,
    GetStaticDoubleField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID) -> jdouble,

    SetStaticObjectField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jobject),
    SetStaticBooleanField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jboolean),
    SetStaticByteField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jbyte),
    SetStaticCharField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jchar),
    SetStaticShortField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jshort),
    SetStaticIntField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jint),
    SetStaticLongField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jlong),
    SetStaticFloatField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jfloat),
    SetStaticDoubleField: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, fieldID: jfieldID, value: jdouble),

    NewString: #type proc "c" (jni: ^^JNINativeInterface, unicodeChars: [^]jchar, len: jsize) -> jstring,
    GetStringLength: #type proc "c" (jni: ^^JNINativeInterface, str: jstring) -> jsize,
	GetStringChars: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, isCopy: ^jboolean) -> [^]jchar,
    ReleaseStringChars: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, chars: [^]jchar),
    NewStringUTF: #type proc "c" (jni: ^^JNINativeInterface, bytes: [^]c.char) -> jstring,
    GetStringUTFLength: #type proc "c" (jni: ^^JNINativeInterface, str: jstring) -> jsize,
    /* JNI spec says this returns const jbyte*, but that's inconsistent */
    GetStringUTFChars: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, isCopy: ^jboolean) -> cstring,
    ReleaseStringUTFChars: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, utf: cstring),
    GetArrayLength: #type proc "c" (jni: ^^JNINativeInterface, array: jarray) -> jsize,
    NewObjectArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize, elementClass: jclass, initialElement: jobject) -> jobjectArray,
    GetObjectArrayElement: #type proc "c" (jni: ^^JNINativeInterface, array: jobjectArray, index: jsize) -> jobject,
    SetObjectArrayElement: #type proc "c" (jni: ^^JNINativeInterface, array: jobjectArray, index: jsize, value: jobject),

    NewBooleanArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jbooleanArray,
    NewByteArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jbyteArray,
    NewCharArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jcharArray,
    NewShortArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jshortArray,
    NewIntArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jintArray,
    NewLongArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jlongArray,
    NewFloatArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jfloatArray,
    NewDoubleArray: #type proc "c" (jni: ^^JNINativeInterface, length: jsize) -> jdoubleArray,

    GetBooleanArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jbooleanArray, isCopy: ^jboolean) -> [^]jboolean,
    GetByteArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jbyteArray, isCopy: ^jboolean) -> [^]jbyte,
    GetCharArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jcharArray, isCopy: ^jboolean) -> [^]jchar,
    GetShortArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jshortArray, isCopy: ^jboolean) -> [^]jshort,
    GetIntArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jintArray, isCopy: ^jboolean) -> [^]jint,
    GetLongArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jlongArray, isCopy: ^jboolean) -> [^]jlong,
    GetFloatArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jfloatArray, isCopy: ^jboolean) -> [^]jfloat,
    GetDoubleArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jdoubleArray, isCopy: ^jboolean) -> [^]jdouble,

    ReleaseBooleanArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jbooleanArray, elems: [^]jboolean, mode: jint),
    ReleaseByteArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jbyteArray, elems: [^]jbyte, mode: jint),
    ReleaseCharArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jcharArray, elems: [^]jchar, mode: jint),
    ReleaseShortArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jshortArray, elems: [^]jshort, mode: jint),
    ReleaseIntArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jintArray, elems: [^]jint, mode: jint),
    ReleaseLongArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jlongArray, elems: [^]jlong, mode: jint),
    ReleaseFloatArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jfloatArray, elems: [^]jfloat, mode: jint),
    ReleaseDoubleArrayElements: #type proc "c" (jni: ^^JNINativeInterface, array: jdoubleArray, elems: [^]jdouble, mode: jint),

    GetBooleanArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jbooleanArray, start: jsize, len: jsize, buf: [^]jboolean),
    GetByteArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jbyteArray, start: jsize, len: jsize, buf: [^]jbyte),
    GetCharArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jcharArray, start: jsize, len: jsize, buf: [^]jchar),
    GetShortArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jshortArray, start: jsize, len: jsize, buf: [^]jshort),
    GetIntArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jintArray, start: jsize, len: jsize, buf: [^]jint),
    GetLongArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jlongArray, start: jsize, len: jsize, buf: [^]jlong),
    GetFloatArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jfloatArray, start: jsize, len: jsize, buf: [^]jfloat),
    GetDoubleArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jdoubleArray, start: jsize, len: jsize, buf: [^]jdouble),

    /* spec shows these without const, some jni.h do, some don't */
    SetBooleanArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jbooleanArray, start: jsize, len: jsize, buf: [^]jboolean),
    SetByteArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jbyteArray, start: jsize, len: jsize, buf: [^]jbyte),
    SetCharArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jcharArray, start: jsize, len: jsize, buf: [^]jchar),
    SetShortArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jshortArray, start: jsize, len: jsize, buf: [^]jshort),
    SetIntArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jintArray, start: jsize, len: jsize, buf: [^]jint),
    SetLongArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jlongArray, start: jsize, len: jsize, buf: [^]jlong),
    SetFloatArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jfloatArray, start: jsize, len: jsize, buf: [^]jfloat),
    SetDoubleArrayRegion: #type proc "c" (jni: ^^JNINativeInterface, array: jdoubleArray, start: jsize, len: jsize, buf: [^]jdouble),

    RegisterNatives: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass, methods: [^]JNINativeMethod, nMethods: jint) -> jint,
    UnregisterNatives: #type proc "c" (jni: ^^JNINativeInterface, clazz: jclass) -> jint,
    MonitorEnter: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jint,
    MonitorExit: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jint,
    GetJavaVM: #type proc "c" (jni: ^^JNINativeInterface, vm: ^^^JNIInvokeInterface) -> jint,

    GetStringRegion: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, start: jsize, len: jsize, buf: [^]jchar),
    GetStringUTFRegion: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, start: jsize, len: jsize, buf: [^]c.char),

    GetPrimitiveArrayCritical: #type proc "c" (jni: ^^JNINativeInterface, array: jarray, isCopy: ^jboolean) -> rawptr,
    ReleasePrimitiveArrayCritical: #type proc "c" (jni: ^^JNINativeInterface, array: jarray, carray: rawptr, mode: jint),

    GetStringCritical: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, isCopy: ^jboolean) -> [^]jchar,
    ReleaseStringCritical: #type proc "c" (jni: ^^JNINativeInterface, str: jstring, carray: [^]jchar),

    NewWeakGlobalRef: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jweak,
    DeleteWeakGlobalRef: #type proc "c" (jni: ^^JNINativeInterface, obj: jweak),

    ExceptionCheck: #type proc "c" (jni: ^^JNINativeInterface),

    NewDirectByteBuffer: #type proc "c" (jni: ^^JNINativeInterface, address: rawptr, capacity: jlong) -> jobject,
    GetDirectBufferAddress: #type proc "c" (jni: ^^JNINativeInterface, buf: jobject) -> rawptr,
    GetDirectBufferCapacity: #type proc "c" (jni: ^^JNINativeInterface, buf: jobject) -> jlong,

    /* added in JNI 1.6 */
    GetObjectRefType: #type proc "c" (jni: ^^JNINativeInterface, obj: jobject) -> jobjectRefType,
}


/*
 * JNI invocation interface.
 */
JNIInvokeInterface :: struct {
	reserved0: rawptr,
    reserved1: rawptr,
    reserved2: rawptr,

	// NOTE: same here with JNIEnv. The two occurances of ^^^JNINativeInterface are originally ^^JNIEnv but
	// that seems to trigger some sort of race bug in the compiler where it thinks ^^JNIEnv is an invalid type
	// and throws a 'Invalid type usage "^^JNIEnv"'
    DestroyJavaVM: #type proc "c" (vm: ^^JNIInvokeInterface) -> jint,
    AttachCurrentThread: #type proc "c" (vm: ^^JNIInvokeInterface, p_env: ^^^JNINativeInterface, thr_args: rawptr) -> jint,
    DetachCurrentThread: #type proc "c" (vm: ^^JNIInvokeInterface) -> jint,
    GetEnv: #type proc "c" (vm: ^^JNIInvokeInterface, env: ^rawptr, version: jint) -> jint,
    AttachCurrentThreadAsDaemon: #type proc "c" (vm: ^^JNIInvokeInterface, p_env: ^^^JNINativeInterface, thr_args: ^rawptr) -> jint,
}
