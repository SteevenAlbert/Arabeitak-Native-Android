/******************************************************************************
 * File: FrameInputPluginModule.hpp
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2018-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

#ifndef FrameInputPluginModule_hpp
#define FrameInputPluginModule_hpp

#include <CameraFrameInputPluginModule.hpp>


class FrameInputPluginModule : public wikitude::sdk::CameraFrameInputPluginModule {
public:
    FrameInputPluginModule(bool requestRendering_, std::function<void()> cameraReleaseHandler_);

    void onCameraReleased() override;
    void onCameraReleaseFailed(const wikitude::sdk::Error& error_) override;

    void newCameraFrameAvailable(const wikitude::sdk::CameraFrame& cameraFrame_);
    void cameraReleased();
    void cameraToSurfaceAngleChanged(float angle_);
    void notifyNewCameraFrameYUV_420_888(const std::vector<wikitude::sdk::CameraFramePlane>& planes_);
    void notifyNewCameraFrameNV21(const std::vector<wikitude::sdk::CameraFramePlane>& planes_);

    void fieldOfViewChanged(float fov_);
private:
    wikitude::sdk::ColorCameraFrameMetadata _metadata;
    std::function<void()> _cameraReleaseHandler;
    long _frameId;
};


#endif //FrameInputPluginModule_hpp
