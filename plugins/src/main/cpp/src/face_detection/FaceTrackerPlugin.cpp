/******************************************************************************
 * File: FaceTrackerPlugin.cpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#include "FaceTrackerPlugin.hpp"

#include "PluginParameterCollection.hpp"

#include "FaceTrackerJavaScriptPluginModule.hpp"
#include "FaceTrackerOpenGLESRenderPluginModule.hpp"


FaceTrackerPlugin::FaceTrackerPlugin()
: wikitude::sdk::ArchitectPlugin("com.wikitude.plugins.face_tracker_demo")
{ /* Intentionally Left Blank */ }

void FaceTrackerPlugin::initialize(const std::string& temporaryDirectory_, wikitude::sdk::PluginParameterCollection& pluginParameterCollection_) {
    setJavaScriptPluginModule(std::make_unique<FaceTrackerJavaScriptPluginModule>(&pluginParameterCollection_.getRuntimeParameters(), _registeredFaceTracker, temporaryDirectory_));
    setOpenGLESRenderingPluginModule(std::make_unique<FaceTrackerOpenGLESRenderPluginModule>(&pluginParameterCollection_.getRuntimeParameters(), &pluginParameterCollection_.getCameraParameters()));
}

void FaceTrackerPlugin::pause() {
    getOpenGLESRenderingPluginModule()->releaseAugmentations();
}

void FaceTrackerPlugin::cameraFrameAvailable(wikitude::sdk::ManagedCameraFrame& managedCameraFrame_) {
    std::vector<wikitude::sdk::Matrix4> augmentationData;
    for ( auto& faceTrackerPair : _registeredFaceTracker ) {
        faceTrackerPair.second->processCameraFrame(managedCameraFrame_, augmentationData);
    }

    getOpenGLESRenderingPluginModule()->setAugmentationData(augmentationData);
}

FaceTrackerJavaScriptPluginModule* FaceTrackerPlugin::getJavaScriptPluginModule() {
    return dynamic_cast<FaceTrackerJavaScriptPluginModule*>(ArchitectPlugin::getJavaScriptPluginModule());
}

FaceTrackerOpenGLESRenderPluginModule* FaceTrackerPlugin::getOpenGLESRenderingPluginModule() {
    return dynamic_cast<FaceTrackerOpenGLESRenderPluginModule*>(ArchitectPlugin::getOpenGLESRenderingPluginModule());
}
