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
 import android.graphics.PorterDuff;
 import android.graphics.drawable.Drawable;
 import android.graphics.drawable.GradientDrawable;
 import android.os.Bundle;
 
 import androidx.annotation.Nullable;
 import androidx.appcompat.app.AppCompatActivity;
 import android.util.Log;
 import android.view.View;
 import android.view.WindowManager;
 import android.webkit.WebView;
 import android.widget.ImageView;
 import android.widget.LinearLayout;
 import android.widget.Toast;
 import android.view.View;

 import java.io.IOException;
 import java.util.Timer;
 import java.util.TimerTask;
 import android.graphics.Color;
 import android.util.TypedValue;
 import android.view.Gravity;
 import android.widget.FrameLayout;
 import android.widget.TextView;
 import android.os.Handler;

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
     Float oldX= null;
     Float oldY= null;
     Float newX= null;
     Float newY= null;
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
     private TextView directionTextView;
     private Handler handler;
     /** The path to the AR-Experience. This is usually the path to its index.html. */
     private String arExperience;
     private Timer timer;
     @Override
     protected void onCreate(Bundle savedInstanceState) {
         super.onCreate(savedInstanceState);
         // Used to enabled remote debugging of the ArExperience with google chrome https://developers.google.com/web/tools/chrome-devtools/remote-debugging
         WebView.setWebContentsDebuggingEnabled(true);
         final ArchitectStartupConfiguration config = new ArchitectStartupConfiguration(); // Creates a config with its default values.
         config.setLicenseKey(getString(R.string.wikitude_license_key)); // Has to be set, to get a trial license key visit http://www.wikitude.com/developer/licenses.
         config.setCameraPosition(CameraSettings.CameraPosition.BACK);       // The default camera is the first camera available for the system.
         config.setCameraResolution(CameraSettings.CameraResolution.FULL_HD_1920x1080);   // The default resolution is 640x480.
         config.setCameraFocusMode(CameraSettings.CameraFocusMode.CONTINUOUS);     // The default focus mode is continuous focusing.
         config.setCamera2Enabled(true);  // The camera2 api is disabled by default (old camera api is used).
 
         architectView = new ArchitectView(this);
         architectView.onCreate(config); // create ArchitectView with configuration
         handler = new Handler();
         setContentView(architectView);
         getWindow().addFlags(WindowManager.LayoutParams.FLAG_KEEP_SCREEN_ON);
         timer = new Timer();
//         timer.scheduleAtFixedRate(new TimerTask() {
//             @Override
//             public void run() {
//                 architectView.captureScreen(ArchitectView.CaptureScreenCallback.CAPTURE_MODE_CAM, ARWikitudeActivity.this);
//             }
//         }, 0, 2000);
     }
 
     @Override
     protected void onPostCreate(@Nullable Bundle savedInstanceState) {
         super.onPostCreate(savedInstanceState);
         architectView.onPostCreate();
         Intent intent = getIntent();
         String procedure = intent.getStringExtra("procedure");

         try {
             switch (procedure) {
                 case "change_tyres":
                     architectView.load("scenarios/change_tyres/index.html");
                     break;
                 case "add_coolant":
                     architectView.load("scenarios/add_coolant/index.html");
                     break;
                 case "jumpstart_battery":
                     architectView.load("scenarios/jumpstart_battery/index.html");
                     break;
                 case "ar_demo":
                     architectView.load("scenarios/ar_demo/index.html");
                     break;
                 default:
                     architectView.load("scenarios/null/index.html");
                     break;
             }
         } catch (IOException e) {
             Toast.makeText(this, getString(R.string.error_loading_ar_experience), Toast.LENGTH_SHORT).show();
             Log.e(TAG, "Exception while loading arExperience " + arExperience + ".", e);
         }

         runOnUiThread(new Runnable() {
             @Override
             public void run() {
                 removeDirectionText();
                 TextView textView = new TextView(ARWikitudeActivity.this);
                 textView.setText(" Adjust the camera directly above your hand to monitor your hand gesture. ");
                 textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 20);
                 textView.setTextColor(Color.BLACK);
                 textView.setTag("instruction_text");

                 Drawable icon = getResources().getDrawable(R.drawable.hand_front_right);
                 icon.setBounds(0, 0, icon.getIntrinsicWidth(), icon.getIntrinsicHeight());
                 icon.setColorFilter(Color.GREEN, PorterDuff.Mode.SRC_IN);
                 textView.setCompoundDrawablesWithIntrinsicBounds(icon, null, null, null);

                 FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                         FrameLayout.LayoutParams.WRAP_CONTENT,
                         FrameLayout.LayoutParams.WRAP_CONTENT);
                 layoutParams.gravity = Gravity.TOP | Gravity.CENTER_HORIZONTAL;
                 layoutParams.topMargin = (int) getResources().getDimension(R.dimen.top_margin);
                 textView.setLayoutParams(layoutParams);

                 GradientDrawable drawable = new GradientDrawable();
                 drawable.setShape(GradientDrawable.RECTANGLE);
                 drawable.setColor(Color.parseColor("#BBBBBB"));
                 drawable.setCornerRadius(20);
                 textView.setBackgroundDrawable(drawable);


                 int padding = (int) getResources().getDimension(R.dimen.padding);
                 textView.setPadding(padding, padding, padding, padding);


                 FrameLayout rootView = findViewById(android.R.id.content);
                 rootView.addView(textView);
             }
         });
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
         //TODO: Needs Multithreading to avoid lagging
         String direction;
         AssetManager assetManager = getAssets();
         HandDetection detect = new HandDetection();
         float[] landmarksList=detect.processBitmap(this, bitmap);
         int classification=detect.classifyGesture(landmarksList,assetManager);

         //Opening cap rotation processing
         if(classification==5 ){
             if (landmarksList.length>0) {
                 if (oldX != null && oldY != null) {
                     newX = landmarksList[0];
                     newY = landmarksList[1];
                     Float[] a = {oldX, oldY};
                     Float[] b = {newX, newY};
                     Float c = a[0] * b[1] - a[1] * b[0];

                     if (c > 0) {
                         direction = "Clockwise";
                         runOnUiThread(new Runnable() {
                             @Override
                             public void run() {

                                 removeDirectionText();


                                 TextView textView = new TextView(ARWikitudeActivity.this);
                                 textView.setText(" Rotate the cap in the other direction");
                                 textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 17);
                                 textView.setTextColor(Color.BLACK);
                                 textView.setTag("direction_text");

                                 Drawable icon = getResources().getDrawable(R.drawable.alert);
                                 icon.setBounds(0, 0, icon.getIntrinsicWidth(), icon.getIntrinsicHeight());
                                 icon.setColorFilter(Color.YELLOW, PorterDuff.Mode.SRC_IN);
                                 textView.setCompoundDrawablesWithIntrinsicBounds(icon, null, null, null);

                                 FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                                         FrameLayout.LayoutParams.WRAP_CONTENT,
                                         FrameLayout.LayoutParams.WRAP_CONTENT);
                                 layoutParams.gravity = Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
                                 layoutParams.bottomMargin = (int) getResources().getDimension(R.dimen.margin_bottom);

                                 textView.setLayoutParams(layoutParams);


                                 GradientDrawable drawable = new GradientDrawable();
                                 drawable.setShape(GradientDrawable.RECTANGLE);
                                 drawable.setColor(Color.parseColor("#99BBBBBB")); // grey with alpha
                                 drawable.setCornerRadius(20);
                                 textView.setBackgroundDrawable(drawable);


                                 int padding = (int) getResources().getDimension(R.dimen.padding);
                                 textView.setPadding(padding, padding, padding, padding);


                                 FrameLayout rootView = findViewById(android.R.id.content);
                                 rootView.addView(textView);
                             }
                         });
                     } else {
                         direction = "Anticlockwise";
                         runOnUiThread(new Runnable() {
                             @Override
                             public void run() {

                                 removeDirectionText();


                                 TextView textView = new TextView(ARWikitudeActivity.this);
                                 textView.setText("Continue rotating the cap");
                                 textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 17);
                                 textView.setTextColor(Color.BLACK);
                                 textView.setTag("direction_text"); // Add a tag to identify the TextView


                                 FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                                         FrameLayout.LayoutParams.WRAP_CONTENT,
                                         FrameLayout.LayoutParams.WRAP_CONTENT);
                                 layoutParams.gravity = Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
                                 layoutParams.bottomMargin = (int) getResources().getDimension(R.dimen.margin_bottom);

                                 textView.setLayoutParams(layoutParams);


                                 GradientDrawable drawable = new GradientDrawable();
                                 drawable.setShape(GradientDrawable.RECTANGLE);
                                 drawable.setColor(Color.parseColor("#99BBBBBB"));
                                 drawable.setCornerRadius(20);
                                 textView.setBackgroundDrawable(drawable);


                                 int padding = (int) getResources().getDimension(R.dimen.padding);
                                 textView.setPadding(padding, padding, padding, padding);


                                 FrameLayout rootView = findViewById(android.R.id.content);
                                 rootView.addView(textView);
                             }
                         });


                     }
                     oldX = landmarksList[0];
                     oldY = landmarksList[1];
                     Log.v(TAG, "Direction: " + direction);
                 } else {
                     oldX = landmarksList[0];
                     oldY = landmarksList[1];
                 }
             }
         }//Next Instruction
         else if (classification==0){
             runOnUiThread(new Runnable() {
                 @Override
                 public void run() {

                     removeDirectionText();
                     removeInstructionText();

                     TextView textView = new TextView(ARWikitudeActivity.this);
                     textView.setText(" Next Instruction");
                     textView.setTextSize(TypedValue.COMPLEX_UNIT_SP, 17);
                     textView.setTextColor(Color.BLACK);
                     textView.setTag("direction_text");

                     Drawable icon = getResources().getDrawable(R.drawable.check_all);
                     icon.setBounds(0, 0, icon.getIntrinsicWidth(), icon.getIntrinsicHeight());
                     icon.setColorFilter(Color.GREEN, PorterDuff.Mode.SRC_IN);
                     textView.setCompoundDrawablesWithIntrinsicBounds(icon, null, null, null);

                     FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(
                             FrameLayout.LayoutParams.WRAP_CONTENT,
                             FrameLayout.LayoutParams.WRAP_CONTENT);
                     layoutParams.gravity = Gravity.BOTTOM | Gravity.CENTER_HORIZONTAL;
                     layoutParams.bottomMargin = (int) getResources().getDimension(R.dimen.margin_bottom);

                     textView.setLayoutParams(layoutParams);


                     GradientDrawable drawable = new GradientDrawable();
                     drawable.setShape(GradientDrawable.RECTANGLE);
                     drawable.setColor(Color.parseColor("#99BBBBBB"));
                     drawable.setCornerRadius(20);
                     textView.setBackgroundDrawable(drawable);


                     int padding = (int) getResources().getDimension(R.dimen.padding);
                     textView.setPadding(padding, padding, padding, padding);


                     FrameLayout rootView = findViewById(android.R.id.content);
                     rootView.addView(textView);
                 }
             });
             timer.cancel();
             Log.v(TAG,"Proceed with the next instruction");
         }
     }

     private void removeDirectionText() {
         FrameLayout rootView = findViewById(android.R.id.content);
         TextView directionTextView = rootView.findViewWithTag("direction_text");
         if (directionTextView != null) {
             rootView.removeView(directionTextView);
         }
     }
     private void removeInstructionText() {
         FrameLayout rootView = findViewById(android.R.id.content);
         TextView directionTextView = rootView.findViewWithTag("instruction_text");
         if (directionTextView != null) {
             rootView.removeView(directionTextView);
         }
     }

 }
 
 