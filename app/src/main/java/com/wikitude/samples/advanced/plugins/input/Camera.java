/******************************************************************************
 * File: Camera.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2019-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

package com.wikitude.samples.advanced.plugins.input;

public interface Camera {

    void start();
    void stop();

    int getCameraOrientation();
}
