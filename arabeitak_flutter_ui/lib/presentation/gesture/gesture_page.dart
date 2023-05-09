// import 'dart:async';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'instruction_list.dart';
// import 'camera.dart';

// class GesturePage extends StatefulWidget {
//   const GesturePage({Key? key}) : super(key: key);

//   @override
//   _GesturePageState createState() => _GesturePageState();
// }

// class _GesturePageState extends State<GesturePage> {
//   late CameraDescription? firstCamera;
//   bool isCameraInitialized = false;
//   @override
//   void initState() {
//     super.initState();
//     initializeCamera();
//   }

//   Future<void> initializeCamera() async {
//     // Ensure that plugin services are initialized so that `availableCameras()`
//     // can be called before `runApp()`
//     WidgetsFlutterBinding.ensureInitialized();

//     // Obtain a list of the available cameras on the device.
//     final cameras = await availableCameras();

//     // Get a specific camera from the list of available cameras.
//     firstCamera = cameras.first;

//     // Call setState to rebuild the widget tree with the initialized value
//     setState(() {
//       isCameraInitialized = true;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Check if the firstCamera field is null and show a loading indicator
//     if (isCameraInitialized == false) {
//       return const Center(child: CircularProgressIndicator());
//     } else {
//       return Scaffold(
//         // appBar: PreferredSize(
//         //   preferredSize: const Size.fromHeight(50.0),
//         //   child: AppBar(
//         //     backgroundColor: Colors.transparent,
//         //     shadowColor: Colors.transparent,
//         //     leading: const BackButton(
//         //       color: Colors.black,
//         //     ),
//         //   ),
//         // ),
//         body: Container(
//           child: Stack(
//             alignment: FractionalOffset.center,
//             children: <Widget>[
//               TakePictureScreen(
//                 // Pass the appropriate camera to the TakePictureScreen widget.
//                 camera: firstCamera!,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 50.0, top: 200),
//                 child: Column(children: const [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text("Steps Preview",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20)),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: InstructionList(),
//                   )
//                 ]),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }
// }
