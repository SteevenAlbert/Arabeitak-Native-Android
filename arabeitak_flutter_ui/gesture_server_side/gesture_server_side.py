#!/usr/bin/env python
# -*- coding: utf-8 -*-
import csv
import copy
import time
import argparse
import itertools
from collections import Counter
from collections import deque
import math
import cv2 as cv
import numpy as np
import mediapipe as mp

from utils import CvFpsCalc
from model import KeyPointClassifier
from model import PointHistoryClassifier


from utils import CvFpsCalc
from model import KeyPointClassifier
from model import PointHistoryClassifier


def get_args():
    parser = argparse.ArgumentParser()

    # parser.add_argument("--device", type=int, default=0)
    # parser.add_argument("--width", help='cap width', type=int, default=960)
    # parser.add_argument("--height", help='cap height', type=int, default=540)

    parser.add_argument('--use_static_image_mode', action='store_true')
    parser.add_argument("--min_detection_confidence",
                        help='min_detection_confidence',
                        type=float,
                        default=0.7)
    parser.add_argument("--min_tracking_confidence",
                        help='min_tracking_confidence',
                        type=int,
                        default=0.5)

    args = parser.parse_args()

    return args


def main(image_data):
    # Argument parsing #################################################################
    # args = get_args()

    # use_static_image_mode = args.use_static_image_mode
    # min_detection_confidence = args.min_detection_confidence
    # min_tracking_confidence = args.min_tracking_confidence

    # Model load #############################################################
    mp_hands = mp.solutions.hands
    hands = mp_hands.Hands(
        static_image_mode=True,
        max_num_hands=2,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.5,
    )

    keypoint_classifier = KeyPointClassifier()

    # Read labels ###########################################################
    with open('model/keypoint_classifier/keypoint_classifier_label.csv',
              encoding='utf-8-sig') as f:
        keypoint_classifier_labels = csv.reader(f)
        keypoint_classifier_labels = [
            row[0] for row in keypoint_classifier_labels
        ]

    # Coordinate history #################################################################
    history_length = 16
    point_history = deque(maxlen=history_length)

    # Finger gesture history ################################################
    finger_gesture_history = deque(maxlen=history_length)

    # image = cv.imread("hand.png")
    nparr = np.frombuffer(image_data, np.uint8)
    image = cv.imdecode(nparr, cv.IMREAD_COLOR)
    # image = cv2.imdecode()
    debug_image = copy.deepcopy(image)

    # Detection implementation #############################################################
    image = cv.cvtColor(image, cv.COLOR_BGR2RGB)

    image.flags.writeable = False
    results = hands.process(image)
    image.flags.writeable = True

    #  ####################################################################
    if results.multi_hand_landmarks is not None:
        for hand_landmarks, handedness in zip(results.multi_hand_landmarks,
                                              results.multi_handedness):
            # Bounding box calculation
            brect = calc_bounding_rect(debug_image, hand_landmarks)
            # Landmark calculation
            landmark_list = calc_landmark_list(debug_image, hand_landmarks)

            # Conversion to relative coordinates / normalized coordinates
            pre_processed_landmark_list = pre_process_landmark(
                landmark_list)

            #  Hand sign classification
            hand_sign_id = keypoint_classifier(pre_processed_landmark_list)
            return hand_sign_id
    else:
        point_history.append([0, 0])


oldx = None
oldz = None
oldy = None
finall = None


def rotation_direction(new_image, old_image):
    finall = ""
    mp_hands = mp.solutions.hands
    hands = mp_hands.Hands(
        static_image_mode=True,
        max_num_hands=2,
        min_detection_confidence=0.7,
        min_tracking_confidence=0.5,
    )

    keypoint_classifier = KeyPointClassifier()

    # Read labels ###########################################################
    with open('model/keypoint_classifier/keypoint_classifier_label.csv',
              encoding='utf-8-sig') as f:
        keypoint_classifier_labels = csv.reader(f)
        keypoint_classifier_labels = [
            row[0] for row in keypoint_classifier_labels
        ]

    # Coordinate history #################################################################
    history_length = 16
    point_history = deque(maxlen=history_length)

    # Finger gesture history ################################################
    finger_gesture_history = deque(maxlen=history_length)

    nparr1 = np.frombuffer(new_image, np.uint8)
    image1 = cv.imdecode(nparr1, cv.IMREAD_COLOR)
    nparr2 = np.frombuffer(old_image, np.uint8)
    image2 = cv.imdecode(nparr2, cv.IMREAD_COLOR)
    # image = cv2.imdecode()
    debug_image1 = copy.deepcopy(image1)
    debug_image2 = copy.deepcopy(image2)

    # Detection implementation #############################################################
    image1 = cv.cvtColor(image1, cv.COLOR_BGR2RGB)
    image2 = cv.cvtColor(image2, cv.COLOR_BGR2RGB)

    image1.flags.writeable = False
    results1 = hands.process(image1)
    image1.flags.writeable = True
    image2.flags.writeable = False
    results2 = hands.process(image2)
    image2.flags.writeable = True
    #  ####################################################################
    if results1.multi_hand_landmarks is not None and results2.multi_hand_landmarks is not None:
        for hand_landmarks1, handedness1, hand_landmarks2, handedness2 in zip(results1.multi_hand_landmarks,
                                                                              results1.multi_handedness, results2.multi_hand_landmarks,
                                                                              results2.multi_handedness):
            # Bounding box calculation
            brect1 = calc_bounding_rect(debug_image1, hand_landmarks1)
            # Landmark calculation
            landmark_list1 = calc_landmark_list(debug_image1, hand_landmarks1)
            brect2 = calc_bounding_rect(debug_image2, hand_landmarks2)
            # Landmark calculation
            landmark_list2 = calc_landmark_list(debug_image2, hand_landmarks2)

            # Conversion to relative coordinates / normalized coordinates
            pre_processed_landmark_list1 = pre_process_landmark(
                landmark_list1)
            pre_processed_landmark_list2 = pre_process_landmark(
                landmark_list2)
            hand_sign_id1 = keypoint_classifier(pre_processed_landmark_list1)
            hand_sign_id2 = keypoint_classifier(pre_processed_landmark_list2)
            if hand_sign_id1 == 1 and hand_sign_id2 == 1:
                newx = hand_landmarks1.landmark[0].x
                # newz = hand_landmarks.landmark[0].z
                newy = hand_landmarks1.landmark[0].y
                oldx = hand_landmarks2.landmark[0].x
                oldy = hand_landmarks2.landmark[0].y
                a = np.array([oldx, oldy])
                b = np.array([newx, newy])
                c = np.cross(a, b)
                if c > 0:
                    finall = "Anticlockwise"
                else:
                    finall = "Clockwise"
                # print(crossprod)
                time.sleep(0.06)
                # if newz < oldz:
                #     print("anti")
                # elif oldz < newz:
                #     print("clockwise")

            #  Hand sign classification

            return finall
    else:
        point_history.append([0, 0])


def calc_bounding_rect(image, landmarks):
    image_width, image_height = image.shape[1], image.shape[0]

    landmark_array = np.empty((0, 2), int)

    for _, landmark in enumerate(landmarks.landmark):
        landmark_x = min(int(landmark.x * image_width), image_width - 1)
        landmark_y = min(int(landmark.y * image_height), image_height - 1)

        landmark_point = [np.array((landmark_x, landmark_y))]

        landmark_array = np.append(landmark_array, landmark_point, axis=0)

    x, y, w, h = cv.boundingRect(landmark_array)

    return [x, y, x + w, y + h]


def calc_landmark_list(image, landmarks):
    image_width, image_height = image.shape[1], image.shape[0]

    landmark_point = []

    # Keypoint
    for _, landmark in enumerate(landmarks.landmark):
        landmark_x = min(int(landmark.x * image_width), image_width - 1)
        landmark_y = min(int(landmark.y * image_height), image_height - 1)
        # landmark_z = landmark.z

        landmark_point.append([landmark_x, landmark_y])

    return landmark_point


def pre_process_landmark(landmark_list):
    temp_landmark_list = copy.deepcopy(landmark_list)

    # Convert to relative coordinates
    base_x, base_y = 0, 0
    for index, landmark_point in enumerate(temp_landmark_list):
        if index == 0:
            base_x, base_y = landmark_point[0], landmark_point[1]

        temp_landmark_list[index][0] = temp_landmark_list[index][0] - base_x
        temp_landmark_list[index][1] = temp_landmark_list[index][1] - base_y

    # Convert to a one-dimensional list
    temp_landmark_list = list(
        itertools.chain.from_iterable(temp_landmark_list))

    # Normalization
    max_value = max(list(map(abs, temp_landmark_list)))

    def normalize_(n):
        return n / max_value

    temp_landmark_list = list(map(normalize_, temp_landmark_list))

    return temp_landmark_list


def pre_process_point_history(image, point_history):
    image_width, image_height = image.shape[1], image.shape[0]

    temp_point_history = copy.deepcopy(point_history)

    # Convert to relative coordinates
    base_x, base_y = 0, 0
    for index, point in enumerate(temp_point_history):
        if index == 0:
            base_x, base_y = point[0], point[1]

        temp_point_history[index][0] = (temp_point_history[index][0] -
                                        base_x) / image_width
        temp_point_history[index][1] = (temp_point_history[index][1] -
                                        base_y) / image_height

    # Convert to a one-dimensional list
    temp_point_history = list(
        itertools.chain.from_iterable(temp_point_history))

    return temp_point_history


if __name__ == '__main__':
    main()
