/******************************************************************************
 * File: ArchitectViewExtension.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

package com.wikitude.samples.advanced;

import com.wikitude.architect.ArchitectView;

import android.app.Activity;

public abstract class ArchitectViewExtension {

    protected final Activity activity;
    protected final ArchitectView architectView;

    public ArchitectViewExtension(Activity activity, ArchitectView architectView) {
        this.activity = activity;
        this.architectView = architectView;
    }

    public void onCreate(){}

    public void onPostCreate(){}

    public void onResume(){}

    public void onPause(){}

    public void onDestroy(){}
}
