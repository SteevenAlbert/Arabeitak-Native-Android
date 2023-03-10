/******************************************************************************
 * File: SimpleInputPlugin.h
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef SimpleInputPlugin_h
#define SimpleInputPlugin_h

#include <jni.h>

#include <Plugin.hpp>


class SimpleInputPlugin : public wikitude::sdk::Plugin {
public:
    SimpleInputPlugin();

    virtual ~SimpleInputPlugin();

    // from Plugin
    void initialize(const std::string& temporaryDirectory_, wikitude::sdk::PluginParameterCollection& pluginParameterCollection_) override;
    void pause() override;
    void resume(unsigned int pausedTime_) override;
    void destroy() override;
    void update(const wikitude::sdk::RecognizedTargetsBucket& recognizedTargetsBucket_) override;
    void cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) override;

    void initializeJni(JNIEnv* env_);
protected:
    void callInitializedJNIMethod(jmethodID methodId_);

public:
    static SimpleInputPlugin* instance;

private:
    jmethodID _sdkCameraReleasedMethodId;
    jmethodID _pluginPausedMethodId;
    jmethodID _pluginResumedMethodId;
    jmethodID _pluginDestroyedMethodId;
};

#endif /* SimpleInputPlugin_h */
