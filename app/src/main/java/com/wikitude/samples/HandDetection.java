package com.wikitude.samples;

import android.Manifest;
import android.content.Context;
import android.content.pm.ApplicationInfo;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.SurfaceTexture;
import android.util.Log;
import android.view.SurfaceView;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.Matrix;
import android.media.MediaMetadataRetriever;
import android.net.Uri;
import android.os.SystemClock;
import android.util.Log;
import androidx.annotation.VisibleForTesting;
import androidx.camera.core.ImageProxy;
import com.google.mediapipe.framework.image.BitmapImageBuilder;

import com.google.mediapipe.tasks.components.containers.Landmark;
import com.google.mediapipe.tasks.core.BaseOptions;
import com.google.mediapipe.tasks.core.Delegate;
import com.google.mediapipe.tasks.vision.core.RunningMode;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarkerResult;
import com.google.mediapipe.framework.image.MPImage;

import com.google.mediapipe.formats.proto.LandmarkProto;
import com.wikitude.samples.KeyPointClassifier;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker.HandLandmarkerOptions;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class HandDetection{
//    static {
//        // Load all native libraries needed by the app.
//        System.loadLibrary("mediapipe_jni");
//        //System.loadLibrary("opencv_java3");
//    }
    private static final String TAG = "MainActivity";
    private static final float DEFAULT_HAND_DETECTION_CONFIDENCE = 0.5f;
    private float minHandDetectionConfidence = DEFAULT_HAND_DETECTION_CONFIDENCE;

    private static final float DEFAULT_HAND_TRACKING_CONFIDENCE = 0.7f;
    private float minHandTrackingConfidence = DEFAULT_HAND_TRACKING_CONFIDENCE;

    private static final float DEFAULT_HAND_PRESENCE_CONFIDENCE = 0.5f;
    private float minHandPresenceConfidence = DEFAULT_HAND_PRESENCE_CONFIDENCE;

    private static final int DEFAULT_MAX_NUM_HANDS = 1;
    private int maxNumHands = DEFAULT_MAX_NUM_HANDS;

    private MPImage mpImage;
    private  String MP_HAND_LANDMARKER_TASK = "hand_landmarker.task";
    private BaseOptions.Builder baseOptionsBuilder;
    private BaseOptions baseOptions;
    private HandLandmarkerOptions.Builder optionsBuilder;
    private HandLandmarkerOptions options;
    private HandLandmarker handLandmarker;
    private HandLandmarkerResult result;
    private List<List<Landmark>> results;
    public float[] processBitmap(Context context, Bitmap bitmap, AssetManager assetManager) {
        Bitmap newBitmap = bitmap.copy(Bitmap.Config.ARGB_8888, true);
        bitmap.recycle();
        bitmap = newBitmap;
        baseOptionsBuilder = BaseOptions.builder().setModelAssetPath(MP_HAND_LANDMARKER_TASK);
        baseOptions = baseOptionsBuilder.build();

        optionsBuilder =
                HandLandmarker.HandLandmarkerOptions.builder()
                        .setBaseOptions(baseOptions)
                        .setMinHandDetectionConfidence(minHandDetectionConfidence)
                        .setMinTrackingConfidence(minHandTrackingConfidence)
                        .setMinHandPresenceConfidence(minHandPresenceConfidence)
                        .setNumHands(maxNumHands)
                        .setRunningMode(RunningMode.IMAGE);

        options = optionsBuilder.build();

        handLandmarker =
                HandLandmarker.createFromOptions(context, options);

        mpImage = new BitmapImageBuilder(bitmap).build();
        result = handLandmarker.detect(mpImage);
        results=result.landmarks();


        List<Float> floatList = new ArrayList<>();

        for (List<Landmark> sublist : results) {
            for (Landmark landmark : sublist) {
                floatList.add(landmark.x());
                floatList.add(landmark.y());
            }
        }

        float[] floatArray = new float[floatList.size()];
        for (int i = 0; i < floatList.size(); i++) {
            floatArray[i] = floatList.get(i);
        }
if(floatArray.length>0){
    try {
            KeyPointClassifier model = new KeyPointClassifier(assetManager, "keypoint_classifier.tflite");
            Log.v(TAG,"answer "+model.predict(floatArray));
        }catch(IOException e) {
            e.printStackTrace();
        }

}
        return floatArray;



    }
    public void processRotation(float[] input1,float[] input2){
//        if (hand_sign_id1 == 1 && hand_sign_id2 == 1) {
        float oldx=input1[0];
        float oldy=input1[1];
        float newx=input2[0];
        float newy=input2[1];
            float[] a = { oldx, oldy };
            float[] b = { newx, newy };
            float c = a[0] * b[1] - a[1] * b[0];
            String finall;
            if (c > 0) {
                finall = "Anticlockwise";
            } else {
                finall = "Clockwise";
            }
//        }

    }

}
