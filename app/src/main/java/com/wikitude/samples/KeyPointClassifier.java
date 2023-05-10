package com.wikitude.samples;

import android.content.res.AssetManager;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.MappedByteBuffer;
import java.nio.channels.FileChannel;
import java.nio.file.Path;
import java.nio.file.Paths;

import org.tensorflow.lite.Interpreter;
import org.tensorflow.lite.Tensor;

import android.content.Context;
public class KeyPointClassifier {
    private Interpreter interpreter;
    private int inputSize;
    private int outputSize;
    private ByteBuffer inputBuffer;
    private ByteBuffer outputBuffer;

    public KeyPointClassifier( AssetManager assetManager,String modelPath) throws IOException {
        this.interpreter = new Interpreter(loadModelFile(assetManager,modelPath));
        Tensor inputTensor = interpreter.getInputTensor(0);
        Tensor outputTensor = interpreter.getOutputTensor(0);
        this.inputSize = inputTensor.shape()[1];
        this.outputSize = outputTensor.shape()[1];
        this.inputBuffer = ByteBuffer.allocateDirect(inputSize * 4); // 4 bytes per float
        this.inputBuffer.order(ByteOrder.nativeOrder());
        this.outputBuffer = ByteBuffer.allocateDirect(outputSize * 4); // 4 bytes per float
        this.outputBuffer.order(ByteOrder.nativeOrder());
    }

    public int predict(float[] input) {
        inputBuffer.rewind();
        outputBuffer.rewind();
        for (int i = 0; i < inputSize; i++) {
            inputBuffer.putFloat(input[i]);
        }
        interpreter.run(inputBuffer, outputBuffer);
        outputBuffer.rewind();
        int predictedClass = 0;
        float maxProb = outputBuffer.getFloat();
        for (int i = 1; i < outputSize; i++) {
            float prob = outputBuffer.getFloat();
            if (prob > maxProb) {
                predictedClass = i;
                maxProb = prob;
            }
        }
        return predictedClass;
    }

    private ByteBuffer loadModelFile(AssetManager assetManager ,String modelPath) throws IOException {
        InputStream inputStream = assetManager.open(modelPath);
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();

        byte[] buffer = new byte[4096];
        int n;
        while ((n = inputStream.read(buffer)) != -1) {
            outputStream.write(buffer, 0, n);
        }

        byte[] modelData = outputStream.toByteArray();
        ByteBuffer modelBuffer = ByteBuffer.allocateDirect(modelData.length);
        modelBuffer.order(ByteOrder.nativeOrder());
        modelBuffer.put(modelData);

        return modelBuffer;
    }

}
