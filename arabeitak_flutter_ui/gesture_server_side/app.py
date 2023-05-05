from flask import Flask, request, Response
from app2 import main, rotation_direction
import io
from PIL import Image
import cv2
import numpy as np
import base64

app = Flask(__name__)


@app.route('/process_image', methods=['POST'])
def process_images():
    answer = "None"
    # Get the image files from the request
    image_file1 = request.files['oldImage']
    image_file2 = request.files['newImage']
    image_data1 = image_file1.read()
    image_data2 = image_file2.read()
    # Pass the image data to the main function to get the result
    result = main(image_data2)
    if result == 1:
        if rotation_direction(image_data2, image_data1) == "Anticlockwise":
            answer = "Clockwise "
        elif rotation_direction(image_data2, image_data1) == "Clockwise":
            answer = "Anticlockwise "

        # answer="clockwise"
        # answer="Anti-clockwise"
        answer += "opening cap"
    else:
        answer = "Stop"

    # Return the result as a string
    return answer


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
