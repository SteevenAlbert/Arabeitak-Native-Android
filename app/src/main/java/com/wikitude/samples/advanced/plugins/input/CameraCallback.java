/******************************************************************************
 * File: CameraCallback.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2019-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

package com.wikitude.samples.advanced.plugins.input;

import java.nio.ByteBuffer;

interface CameraCallback {
    void notifyNewCameraFrameYUV420888(ByteBuffer luminanceData, ByteBuffer chromaBlueData, ByteBuffer chromaRedData, int rowStrideLuminance, int pixelStrideChroma, int rowStrideChroma);

    void notifyNewCameraFrameNV21(byte[] data);

    void fieldOfViewChanged(float fov);

    void cameraReleased();
}
