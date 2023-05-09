// import 'dart:async';
// import 'dart:io';

// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:http/http.dart' as http;

// // A screen that allows users to take a picture using a given camera.
// class TakePictureScreen extends StatefulWidget {
//   const TakePictureScreen({
//     super.key,
//     required this.camera,
//   });

//   final CameraDescription camera;

//   @override
//   TakePictureScreenState createState() => TakePictureScreenState();
// }

// class TakePictureScreenState extends State<TakePictureScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late Timer _timer;
//   String _responseString = '';

//   @override
//   void initState() {
//     super.initState();
//     // To display the current output from the Camera,
//     // create a CameraController.
//     _controller = CameraController(
//       // Get a specific camera from the list of available cameras.
//       widget.camera,
//       // Define the resolution to use.
//       ResolutionPreset.high,
//     );

//     // Next, initialize the controller. This returns a Future.
//     _initializeControllerFuture = _controller.initialize();
//     startTimer(_controller);
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   ScaffoldMessenger.of(context).showSnackBar(
//     //     SnackBar(
//     //       backgroundColor: Colors.grey[300],
//     //       shape: RoundedRectangleBorder(
//     //         borderRadius: BorderRadius.circular(10),
//     //       ),
//     //       content: Row(
//     //         children: const [
//     //           Icon(Icons.warning, color: Colors.orange),
//     //           SizedBox(width: 10),
//     //           Expanded(
//     //             child: Text(
//     //               'Hand gesture enabled. Adjust the camera directly above your hand to monitor your hand gesture.',
//     //               style: TextStyle(color: Colors.black),
//     //             ),
//     //           ),
//     //         ],
//     //       ),
//     //       duration: const Duration(days: 365),
//     //     ),
//     //   );
//     // });
//   }

//   @override
//   void dispose() {
//     // Dispose of the controller when the widget is disposed.
//     _timer.cancel();
//     _controller.dispose();
//     super.dispose();
//   }

//   Future<File?> takePicture(CameraController controller) async {
//     try {
//       List<String> photos = await getPhotos();
//       final imagePath = '${DateTime.now().toIso8601String()}.jpg';
//       final image = await controller.takePicture();
//       final directory = await getExternalStorageDirectory();
//       final imagePath2 = '${directory!.path}/$imagePath';
//       final bytes = await image.readAsBytes();
//       final savedImage = await File(imagePath2).writeAsBytes(bytes.toList());
//       if (photos.isNotEmpty) {
//         await sendImage(File(photos[0]), File(imagePath2));
//       }

//       return savedImage;
//     } catch (e) {
//       print('Error taking picture: $e');
//       return null;
//     }
//   }

//   void startTimer(CameraController controller) {
//     const fiveSeconds = Duration(seconds: 1);
//     _timer = Timer.periodic(
//       fiveSeconds,
//       (Timer timer) => takePicture(controller),
//     );
//   }

//   Future<List<String>> getPhotos() async {
//     Directory dir = Directory(
//         '/storage/emulated/0/Android/data/com.example.flutter_application_1/files/');
//     List<String> photos = [];
//     List<FileSystemEntity> files = await dir.list().toList();
//     for (FileSystemEntity file in files) {
//       if (file is File &&
//           (file.path.endsWith('.jpg') ||
//               file.path.endsWith('.jpeg') ||
//               file.path.endsWith('.png'))) {
//         photos.add(file.path);
//       }
//     }
//     photos.sort((a, b) => b.compareTo(a));
//     return photos;
//   }

//   Future<void> sendImage(File oldImageFile, File newImageFile) async {
//     final url = 'http://172.20.10.4:8080/process_image';
//     var request = http.MultipartRequest('POST', Uri.parse(url));
//     request.files
//         .add(await http.MultipartFile.fromPath('oldImage', oldImageFile.path));
//     request.files
//         .add(await http.MultipartFile.fromPath('newImage', newImageFile.path));
//     var response = await request.send();
//     if (response.statusCode == 200) {
//       String responseString = await response.stream.bytesToString();
//       setState(() {
//         if (responseString == "Anticlockwise opening cap") {
//           _responseString = "Continue rotating the cap anticlockwise";
//         } else if (responseString == "Clockwise opening cap") {
//           _responseString = "Please rotate the cap in the opposite direction";
//         } else if (responseString == "Stop") {
//           _responseString = "Next instruction";
//         }
//       });
//       print('Image successfully sent to the server: $responseString');
//     } else {
//       print('Error sending image to the server.');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // You must wait until the controller is initialized before displaying the
//       // camera preview. Use a FutureBuilder to display a loading spinner until the
//       // controller has finished initializing.
//       body: Column(children: [
//         FutureBuilder<void>(
//           future: _initializeControllerFuture,
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.done) {
//               // If the Future is complete, display the preview.
//               return Expanded(child: CameraPreview(_controller));
//             } else {
//               // Otherwise, display a loading indicator.
//               return const Center(child: CircularProgressIndicator());
//             }
//           },
//         ),
//         Text(
//           _responseString,
//           style: TextStyle(fontSize: 18.0),
//         ),
//       ]),
//     );
//   }
// }
