/******************************************************************************
 * File: jniHelper.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2011-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "jniHelper.h"

JavaVM* JavaVMResource::JAVA_VM;

JavaVMResource::JavaVMResource()
		: env(nullptr)
		, isAttached(false)
{
	jint status = JAVA_VM->GetEnv((void **) &env, JNI_VERSION_1_6);
	if (status != JNI_OK) {
		status = JAVA_VM->AttachCurrentThread(&env, nullptr);
		if (status != JNI_OK) {
			// failed to attach current thread!
			env = nullptr;
			return;
		}
		isAttached = true;
	}
	env->PushLocalFrame(12);
}

JavaVMResource::~JavaVMResource() {
	if (env) {
		env->PopLocalFrame(0);
	}
	if (isAttached) {
		JAVA_VM->DetachCurrentThread();
	}
}

JavaStringResource::JavaStringResource(JNIEnv* env, const jstring string) : str(""), env(env), javaString(string), javaStrPtr(NULL) {
	if (!this->javaString || env->GetStringLength(string) == 0)
	{
		// leave empty string
		return;
	}

	this->javaStrPtr = env->GetStringUTFChars(this->javaString, NULL);
	if (this->javaStrPtr == NULL) {
		/* OutOfMemoryError already thrown */
		return;
	}
	this->str.append(javaStrPtr);
}

JavaStringResource::~JavaStringResource() {
	if (this->javaStrPtr) {
		env->ReleaseStringUTFChars(this->javaString, this->javaStrPtr);
	}
}
