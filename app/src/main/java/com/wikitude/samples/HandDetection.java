package com.wikitude.samples;

import android.content.Context;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.util.Log;
import com.google.mediapipe.framework.image.BitmapImageBuilder;
import com.google.mediapipe.tasks.components.containers.Landmark;
import com.google.mediapipe.tasks.core.BaseOptions;
import com.google.mediapipe.tasks.vision.core.RunningMode;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarkerResult;
import com.google.mediapipe.framework.image.MPImage;
import com.google.mediapipe.tasks.vision.handlandmarker.HandLandmarker.HandLandmarkerOptions;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class HandDetection{
    private static final String TAG = "MainActivity";
    private static final float DEFAULT_HAND_DETECTION_CONFIDENCE = 0.5f;
    private final float minHandDetectionConfidence = DEFAULT_HAND_DETECTION_CONFIDENCE;

    private static final float DEFAULT_HAND_TRACKING_CONFIDENCE = 0.7f;
    private final float minHandTrackingConfidence = DEFAULT_HAND_TRACKING_CONFIDENCE;

    private static final float DEFAULT_HAND_PRESENCE_CONFIDENCE = 0.5f;
    private final float minHandPresenceConfidence = DEFAULT_HAND_PRESENCE_CONFIDENCE;

    private static final int DEFAULT_MAX_NUM_HANDS = 1;
    private final int maxNumHands = DEFAULT_MAX_NUM_HANDS;

    private MPImage mpImage;
    private final String MP_HAND_LANDMARKER_TASK = "hand_landmarker.task";
    private BaseOptions.Builder baseOptionsBuilder;
    private BaseOptions baseOptions;
    private HandLandmarkerOptions.Builder optionsBuilder;
    private HandLandmarkerOptions options;
    private HandLandmarker handLandmarker;
    private HandLandmarkerResult result;
    private List<List<Landmark>> landmarksList;
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
        landmarksList=result.landmarks();

        List<Float> landmarksfloatList = new ArrayList<>();
        for (List<Landmark> sublist : landmarksList) {
            for (Landmark landmark : sublist) {
                landmarksfloatList.add(landmark.x());
                landmarksfloatList.add(landmark.y());
            }
        }

        float[] floatArray = new float[landmarksfloatList.size()];
        for (int i = 0; i < landmarksfloatList.size(); i++) {
            floatArray[i] = landmarksfloatList.get(i);
        }
        if(floatArray.length>0){
            try {
                KeyPointClassifier model = new KeyPointClassifier(assetManager, "keypoint_classifier.tflite");
                Log.v(TAG,"Gesture Classification: "+model.predict(floatArray));
            } catch(IOException e) {
                e.printStackTrace();
            }

        }
        return floatArray;


    }

}
