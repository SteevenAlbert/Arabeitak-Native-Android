/******************************************************************************
 * File: SimpleArActivity.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2017-2021 Wikitude GmbH.
 *
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

 package com.wikitude.samples;

 import com.wikitude.architect.ArchitectStartupConfiguration;
 import com.wikitude.architect.ArchitectView;
 import com.wikitude.common.camera.CameraSettings;
 import java.lang.Float;
 import android.content.Intent;
 import android.content.res.AssetManager;
 import android.graphics.Bitmap;
 import android.os.Bundle;
 
 import androidx.annotation.Nullable;
 import androidx.appcompat.app.AppCompatActivity;
 import android.util.Log;
 import android.view.WindowManager;
 import android.webkit.WebView;
 import android.widget.Toast;
 
 import java.io.IOException;
 import java.util.Timer;
 import java.util.TimerTask;
 import java.util.logging.Handler;
 import com.wikitude.samples.advanced.plugins.FaceDetectionPluginExtension;
 import com.wikitude.samples.advanced.plugins.QrPluginExtension;
 /**
  * This Activity is (almost) the least amount of code required to use the
  * basic functionality for Image-/Instant- and Object Tracking.
  *
  * This Activity needs Manifest.permission.CAMERA permissions because the
  * ArchitectView will try to start the camera.
  */
 public class ARWikitudeActivity extends AppCompatActivity implements ArchitectView.CaptureScreenCallback{
 
     public static final String INTENT_EXTRAS_KEY_SAMPLE = "sampleData";
 
     private static final String TAG = ARWikitudeActivity.class.getSimpleName();
     Float oldx= null;
     Float oldy= null;
     Float newx= null;
     Float newy= null;
     /** Root directory of the sample AR-Experiences in the assets dir. */
     private static final String SAMPLES_ROOT = "samples/";
     /**
      * The ArchitectView is the core of the AR functionality, it is the main
      * interface to the Wikitude SDK.
      * The ArchitectView has its own lifecycle which is very similar to the
      * Activity lifecycle.
      * To ensure that the ArchitectView is functioning properly the following
      * methods have to be called:
      *      - onCreate(ArchitectStartupConfiguration)
      *      - onPostCreate()
      *      - onResume()
      *      - onPause()
      *      - onDestroy()
      * Those methods are preferably called in the corresponding Activity lifecycle callbacks.
      */
     protected ArchitectView architectView;
 
     /** The path to the AR-Experience. This is usually the path to its index.html. */
     private String arExperience;
     private Timer timer;
     @Override
     protected void onCreate(Bundle savedInstanceState) {
         super.onCreate(savedInstanceState);
         // Used to enabled remote debugging of the ArExperience with google chrome https://developers.google.com/web/tools/chrome-devtools/remote-debugging
         WebView.setWebContentsDebuggingEnabled(true);
 
         /*
          * The ArchitectStartupConfiguration is required to call architectView.onCreate.
          * It controls the startup of the ArchitectView which includes camera settings,
          * the required device features to run the ArchitectView and the LicenseKey which
          * has to be set to enable an AR-Experience.
          */
 
         final ArchitectStartupConfiguration config = new ArchitectStartupConfiguration(); // Creates a config with its default values.
         config.setLicenseKey(getString(R.string.wikitude_license_key)); // Has to be set, to get a trial license key visit http://www.wikitude.com/developer/licenses.
         config.setCameraPosition(CameraSettings.CameraPosition.BACK);       // The default camera is the first camera available for the system.
         config.setCameraResolution(CameraSettings.CameraResolution.FULL_HD_1920x1080);   // The default resolution is 640x480.
         config.setCameraFocusMode(CameraSettings.CameraFocusMode.CONTINUOUS);     // The default focus mode is continuous focusing.
         config.setCamera2Enabled(true);  // The camera2 api is disabled by default (old camera api is used).
 
         architectView = new ArchitectView(this);
         architectView.onCreate(config); // create ArchitectView with configuration
 
         setContentView(architectView);
         getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
         timer = new Timer();
         timer.scheduleAtFixedRate(new TimerTask() {
             @Override
             public void run() {
                 // Capture the screen
                 architectView.captureScreen(ArchitectView.CaptureScreenCallback.CAPTURE_MODE_CAM, ARWikitudeActivity.this);
             }
         }, 0, 2000);
     }
 
     @Override
     protected void onPostCreate(@Nullable Bundle savedInstanceState) {
         super.onPostCreate(savedInstanceState);
         architectView.onPostCreate();
         Intent intent = getIntent();
         String procedure = intent.getStringExtra("procedure");
         //Register Native Plugins Here
 //        FaceDetectionPluginExtension plugin2 = new FaceDetectionPluginExtension(this, architectView);
 //        plugin2.onPostCreate();
 //
 //        QrPluginExtension plugin3 = new QrPluginExtension(this, architectView);
 //        plugin3.onPostCreate();
 //        SimpleInputPluginExtension plugin3 = new SimpleInputPluginExtension(this, architectView);
 //        plugin3.onPostCreate();
 //        CustomCameraExtension plugin = new CustomCameraExtension(this, architectView);
 //        plugin.onPostCreate();
 
 
         try {
             if(procedure.equals("change_tyres")){
                 architectView.load("samples/change_tyres/index.html");
             }else if(procedure.equals("add_coolant")){
                 architectView.load("samples/add_coolant/index.html");
             }else{
                 architectView.load("samples/null/index.html");
             }
         } catch (IOException e) {
             Toast.makeText(this, getString(R.string.error_loading_ar_experience), Toast.LENGTH_SHORT).show();
             Log.e(TAG, "Exception while loading arExperience " + arExperience + ".", e);
         }
     }
 
     @Override
     protected void onResume() {
         super.onResume();
         architectView.onResume(); // Mandatory ArchitectView lifecycle call
         architectView.captureScreen(ArchitectView.CaptureScreenCallback.CAPTURE_MODE_CAM, this);
     }
 
     @Override
     protected void onPause() {
         super.onPause();
         architectView.onPause(); // Mandatory ArchitectView lifecycle call
     }
 
     @Override
     protected void onDestroy() {
         super.onDestroy();
         /*
          * Deletes all cached files of this instance of the ArchitectView.
          * This guarantees that internal storage for this instance of the ArchitectView
          * is cleaned and app-memory does not grow each session.
          *
          * This should be called before architectView.onDestroy
          */
         architectView.clearCache();
         architectView.onDestroy(); // Mandatory ArchitectView lifecycle call
         timer.cancel();
     }
 
     @Override
     public void onScreenCaptured(Bitmap bitmap) {
         String finall;
 
         AssetManager assetManager = getAssets();
         HandDetection detect = new HandDetection();
         float[] landmarksList=detect.processBitmap(this, bitmap,assetManager);
         if (landmarksList.length>0) {
             if (oldx != null && oldy != null) {
                 newx = landmarksList[0];
                 newy = landmarksList[1];
                 Float[] a = {oldx, oldy};
                 Float[] b = {newx, newy};
                 Float c = a[0] * b[1] - a[1] * b[0];
 
                 if (c > 0) {
                     finall = "Clockwise";
                 } else {
                     finall = "Anticlockwise";
                 }
                 oldx = landmarksList[0];
                 oldy = landmarksList[1];
                 Log.v(TAG, "Finally? " + finall);
             } else {
                 oldx = landmarksList[0];
                 oldy = landmarksList[1];
             }
         }
 
 
         architectView.captureScreen(ArchitectView.CaptureScreenCallback.CAPTURE_MODE_CAM, this);
     }
 }
 
 