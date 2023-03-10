/******************************************************************************
 * File: FaceTrackerOpenGLESRenderPluginModule.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef FaceTrackerOpenGLESRenderPluginModule_hpp
#define FaceTrackerOpenGLESRenderPluginModule_hpp

#include <mutex>
#include <vector>

#ifdef INCLUDE_WIKITUDE_AS_USER_HEADER
    #include "Matrix4.hpp"
    #include "RuntimeParameters.hpp"
    #include "CameraParameters.hpp"
    #include "OpenGLESRenderingPluginModule.hpp"
#else
    #import <WikitudeSDK/Matrix4.hpp>
    #import <WikitudeSDK/RuntimeParameters.hpp>
    #import <WikitudeSDK/CameraParameters.hpp>
    #import <WikitudeSDK/OpenGLESRenderingPluginModule.hpp>
#endif

#include "StrokedRectangle.hpp"


class FaceTrackerOpenGLESRenderPluginModule : public wikitude::sdk::OpenGLESRenderingPluginModule {
public:
    FaceTrackerOpenGLESRenderPluginModule(wikitude::sdk::RuntimeParameters* runtimeParameters_, wikitude::sdk::CameraParameters* cameraParameters_);
    virtual ~FaceTrackerOpenGLESRenderPluginModule() = default;

    void startRender(wikitude::sdk::RenderableCameraFrameBucket& /* frameBucket_ */) override;
    void endRender(wikitude::sdk::RenderableCameraFrameBucket& /* frameBucket_ */) override;

    void setAugmentationData(std::vector<wikitude::sdk::Matrix4>& augmentationsData_);

    void releaseAugmentations();

protected:
    void updateRenderableAugmentations();
    void calculateProjection(float cameraToSurfaceAngle_, float cameraFrameAspectRatio_, float left, float right, float bottom, float top, float near, float far);

protected:
    std::mutex                      _updateMutex;
    wikitude::sdk::Matrix4          _projectionMatrix;
    std::vector<wikitude::sdk::Matrix4> _augmentationsData;
    std::vector<wikitude::sdk::opengl::StrokedRectangle>    _augmentations;

    wikitude::sdk::RuntimeParameters*       _runtimeParameters;
    wikitude::sdk::CameraParameters*        _cameraParameters;
};

#endif /* FaceTrackerOpenGLESRenderPluginModule_hpp */
