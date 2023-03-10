/******************************************************************************
 * File: HandTrackerPlugin.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "HandTrackerPlugin.hpp"

#include "PluginParameterCollection.hpp"

#include "HandTrackerJavaScriptPluginModule.hpp"
#include "HandTrackerOpenGLESRenderPluginModule.hpp"


HandTrackerPlugin::HandTrackerPlugin()
: wikitude::sdk::ArchitectPlugin("com.wikitude.plugins.hand_tracker_demo")
{ /* Intentionally Left Blank */ }

void HandTrackerPlugin::initialize(const std::string& temporaryDirectory_, wikitude::sdk::PluginParameterCollection& pluginParameterCollection_) {
    setJavaScriptPluginModule(std::make_unique<HandTrackerJavaScriptPluginModule>(&pluginParameterCollection_.getRuntimeParameters(), _registeredHandTracker, temporaryDirectory_));
    setOpenGLESRenderingPluginModule(std::make_unique<HandTrackerOpenGLESRenderPluginModule>(&pluginParameterCollection_.getRuntimeParameters(), &pluginParameterCollection_.getCameraParameters()));
}

void HandTrackerPlugin::pause() {
    getOpenGLESRenderingPluginModule()->releaseAugmentations();
}

void HandTrackerPlugin::cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) {
    std::vector<wikitude::sdk::Matrix4> augmentationData;
    for ( auto& handTrackerPair : _registeredHandTracker ) {
        handTrackerPair.second->processCameraFrame(managedCameraFrame_, augmentationData);
    }

    getOpenGLESRenderingPluginModule()->setAugmentationData(augmentationData);
}

HandTrackerJavaScriptPluginModule* HandTrackerPlugin::getJavaScriptPluginModule() {
    return dynamic_cast<HandTrackerJavaScriptPluginModule*>(ArchitectPlugin::getJavaScriptPluginModule());
}

HandTrackerOpenGLESRenderPluginModule* HandTrackerPlugin::getOpenGLESRenderingPluginModule() {
    return dynamic_cast<HandTrackerOpenGLESRenderPluginModule*>(ArchitectPlugin::getOpenGLESRenderingPluginModule());
}
