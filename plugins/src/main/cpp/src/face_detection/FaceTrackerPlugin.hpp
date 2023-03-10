/******************************************************************************
 * File: FaceTrackerPlugin.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef FaceTrackerPlugin_hpp
#define FaceTrackerPlugin_hpp

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "ArchitectPlugin.hpp"
#else
    #import <WikitudeSDK/ArchitectPlugin.hpp>
#endif

#include "FaceTracker.hpp"


class FaceTrackerJavaScriptPluginModule;
class FaceTrackerOpenGLESRenderPluginModule;
class FaceTrackerPlugin : public wikitude::sdk::ArchitectPlugin {
public:
    FaceTrackerPlugin();

    void initialize(const std::string& /* temporaryDirectory_ */, wikitude::sdk::PluginParameterCollection& pluginParameterCollection_) override;
    void pause() override;

    void cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) override;

    FaceTrackerJavaScriptPluginModule* getJavaScriptPluginModule();
    FaceTrackerOpenGLESRenderPluginModule* getOpenGLESRenderingPluginModule();

protected:
    std::unordered_map<long, std::unique_ptr<FaceTracker>>      _registeredFaceTracker;
};

#endif /* FaceTrackerPlugin_hpp */
