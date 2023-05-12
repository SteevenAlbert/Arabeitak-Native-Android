/******************************************************************************
 * File: MainActivity.java
 * Copyright (c) 2021 Qualcomm Technologies, Inc. and/or its subsidiaries. All rights reserved.
 *  2016-2021 Wikitude GmbH.
 * 
 * Confidential and Proprietary - Qualcomm Technologies, Inc.
 *
 ******************************************************************************/

package com.wikitude.samples;

import static android.content.ContentValues.TAG;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;

import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

import androidx.annotation.NonNull;
import androidx.appcompat.app.AppCompatActivity;

/**
 * The MainActivity is used to display the list of samples and handles the runtime
 * permissions for the sample activities.
 */
public class MainActivity extends AppCompatActivity  {
    private Button button1;
    private Button button2;
    private Button button3;
    private static final String CHANNEL = "flutter.native/helper";
    public FlutterEngine flutterEngine;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.home);
        button1 = findViewById(R.id.button1);
        button2 = findViewById(R.id.button2);
        button3 = findViewById(R.id.button3);
        flutterEngine = new FlutterEngine(this);
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartExecutor.DartEntrypoint.createDefault()

        );

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            Log.d(TAG, "configureFlutterEngine: I'm HERE!!!");
                            if (call.method.equals("navigateToPage")) {
                                String pageName = call.argument("pageName");
                                // Navigate to page in your app
                                navigateToPage(pageName);
                                result.success(null);
                            } else {
                                Log.d(TAG, "configureFlutterEngine() returned: " + "WHOPS!!!!");
                                result.notImplemented();
                            }
                        }
                );
        button1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(MainActivity.this, ARWikitudeActivity.class);
                startActivity(intent);
            }
        });
        // button2.setOnClickListener(new View.OnClickListener() {
        //     @Override
        //     public void onClick(View v) {
        //         Intent intent = new Intent(MainActivity.this, HandDetectionActivity.class);
        //         startActivity(intent);
        //     }
        // });
        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put("my_engine_id", flutterEngine);

        startActivity(
                FlutterActivity
                        .withCachedEngine("my_engine_id")
                        .build(MainActivity.this)
        );
    }
    private void navigateToPage(String pageName) {
        if(pageName.equals("/ar/coolant")){
            Log.d(TAG, "navigateToPage: " + pageName);
            Intent intent = new Intent(MainActivity.this, ARWikitudeActivity.class);
            intent.putExtra("procedure", "add_coolant");
            startActivity(intent);
        }else if(pageName.equals("/ar/change_tyre")){
            Log.d(TAG, "navigateToPage: " + pageName);
            Intent intent = new Intent(MainActivity.this, ARWikitudeActivity.class);
            intent.putExtra("procedure", "change_tyres");
            startActivity(intent);
        }else{
            Log.d(TAG, "Route not found! route: " + pageName);
        }


    }
}
