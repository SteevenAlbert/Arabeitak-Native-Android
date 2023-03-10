/******************************************************************************
 * File: HandTrackerPlugin.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef HandTrackerPlugin_hpp
#define HandTrackerPlugin_hpp

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "ArchitectPlugin.hpp"
#else
    #import <WikitudeSDK/ArchitectPlugin.hpp>
#endif

#include "HandTracker.hpp"


class HandTrackerJavaScriptPluginModule;
class HandTrackerOpenGLESRenderPluginModule;
class HandTrackerPlugin : public wikitude::sdk::ArchitectPlugin {
public:
    HandTrackerPlugin();

    void initialize(const std::string& /* temporaryDirectory_ */, wikitude::sdk::PluginParameterCollection& pluginParameterCollection_) override;
    void pause() override;

    void cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) override;

    HandTrackerJavaScriptPluginModule* getJavaScriptPluginModule();
    HandTrackerOpenGLESRenderPluginModule* getOpenGLESRenderingPluginModule();

protected:
    std::unordered_map<long, std::unique_ptr<HandTracker>>      _registeredHandTracker;
};

#endif /* HandTrackerPlugin_hpp */
