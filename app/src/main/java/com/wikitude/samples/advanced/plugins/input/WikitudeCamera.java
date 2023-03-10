/******************************************************************************
 * File: WikitudeCamera.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

package com.wikitude.samples.advanced.plugins.input;

import android.graphics.ImageFormat;
import android.graphics.SurfaceTexture;
import android.util.Log;

import java.io.IOException;

@SuppressWarnings("deprecation")
public class WikitudeCamera implements com.wikitude.samples.advanced.plugins.input.Camera, android.hardware.Camera.ErrorCallback {

    private static final String TAG = "WikitudeCamera";

    private final CameraCallback callback;
    private int frameWidth;
    private int frameHeight;
    private android.hardware.Camera camera;
    private android.hardware.Camera.Parameters cameraParameters;
    private Object texture;

    public WikitudeCamera(CameraCallback callback, int frameWidth, int frameHeight) {
        this.callback = callback;
        this.frameWidth = frameWidth;
        this.frameHeight = frameHeight;
    }

    @Override
    public void start() {
        try {
            camera = android.hardware.Camera.open(getCamera());
            camera.setErrorCallback(this);
            camera.setPreviewCallback(new android.hardware.Camera.PreviewCallback() {
                @Override
                public void onPreviewFrame(final byte[] data, final android.hardware.Camera camera) {
                    callback.notifyNewCameraFrameNV21(data);
                }
            });
            Log.d(TAG, "start: CAMERA1 STARTED!!");
            cameraParameters = camera.getParameters();
            cameraParameters.setPreviewFormat(ImageFormat.NV21);
            android.hardware.Camera.Size cameraSize = getCameraSize(frameWidth, frameHeight);
            cameraParameters.setPreviewSize(cameraSize.width, cameraSize.height);
            final double fieldOfView = cameraParameters.getHorizontalViewAngle();
            callback.fieldOfViewChanged((float) fieldOfView);
            camera.setParameters(cameraParameters);
            texture = new SurfaceTexture(0);
            camera.setPreviewTexture((SurfaceTexture) texture);
            camera.startPreview();
        } catch (IOException ex) {
            ex.printStackTrace();
        } catch (RuntimeException ex) {
            Log.e(TAG, "Camera not found: " + ex);
        }
    }

    @Override
    public void stop() {
        try {
            if (camera != null) {
                camera.setPreviewCallback(null);
                camera.stopPreview();
                camera.release();
                camera = null;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        callback.cameraReleased();
    }

    @Override
    public void onError(int error, android.hardware.Camera camera) {
        if (this.camera != null) {
            this.camera.release();
            this.camera = null;
        }
    }

    private android.hardware.Camera.Size getCameraSize(int desiredWidth, int desiredHeight) {
        for (android.hardware.Camera.Size size : cameraParameters.getSupportedPreviewSizes()) {
            if (size.width==desiredWidth && size.height==desiredHeight) {
                return size;
            }
        }
        return cameraParameters.getSupportedPreviewSizes().get(0);
    }

    private int getCamera() {
        try {
            int numberOfCameras = android.hardware.Camera.getNumberOfCameras();
            final android.hardware.Camera.CameraInfo cameraInfo = new android.hardware.Camera.CameraInfo();

            for (int cameraId = 0; cameraId < numberOfCameras; cameraId++) {
                android.hardware.Camera.getCameraInfo(cameraId, cameraInfo);

                if (cameraInfo.facing == android.hardware.Camera.CameraInfo.CAMERA_FACING_BACK) {
                    return cameraId;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    @Override
    public int getCameraOrientation() {
        android.hardware.Camera.CameraInfo cameraInfo = new android.hardware.Camera.CameraInfo();

        int cameraId = getCamera();

        if (cameraId != -1) {
            android.hardware.Camera.getCameraInfo(cameraId, cameraInfo);
            return cameraInfo.orientation;
        } else {
            throw new RuntimeException("The getCamera function failed to return a valid camera ID. The image sensor rotation could therefore not be evaluated.");
        }
    }
}
