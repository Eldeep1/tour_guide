// import 'dart:async';
// import 'dart:typed_data';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_vision/flutter_vision.dart';
//
// final modelProvider = AutoDisposeAsyncNotifierProvider<ModelNotifier, void>(() => ModelNotifier());
//
// class ModelNotifier extends AutoDisposeAsyncNotifier{
//   late CameraController controller;
//   late List<CameraDescription> cameras;
//   late FlutterVision vision;
//   late List<Map<String, dynamic>> yoloResults;
//   CameraImage? cameraImage;
//   bool isLoaded = false;
//   bool isDetecting = false;
//   double confidenceThreshold = 0.5;
//   XFile? lastDetectedImage;
//
//   String kingName="firstTime";
// bool firstTime=true;
//   @override
//   FutureOr build() async{
//     await init();
//
//
//     ref.onDispose(()async {
//       controller.dispose();
//       vision.closeYoloModel();
//       await stopDetection();
//
//       print("we disposed the model");
//     },);
//   }
//
//   init() async {
//     cameras = await availableCameras();
//     vision = FlutterVision();
//     controller = CameraController(
//         cameras[0],
//         ResolutionPreset.max,
//         enableAudio: false,
//     );
//
//     await controller.initialize();
//     await loadYoloModel();
//
//     isLoaded = true;
//     isDetecting = false;
//     yoloResults = [];
//   }
//
//   Future<void> loadYoloModel() async {
//     await vision.loadYoloModel(
//       labels: 'assets/labels.txt',
//       modelPath: 'assets/model/best_float16.tflite',
//       modelVersion: "yolov8",
//       numThreads: 1,
//     );
//
//       isLoaded = true;
//   }
//
//   Future<void> detectFromGallery(XFile image) async {
//     kingName="";
//     yoloResults.clear();
//     state = AsyncValue.data(null);
//
//     Uint8List imageBytes = await image.readAsBytes();
//     final decodedImage = await decodeImageFromList(imageBytes);
//     int imageWidth = decodedImage.width;
//     int imageHeight = decodedImage.height;
//     final result = await vision.yoloOnImage(bytesList: imageBytes, imageHeight: imageHeight, imageWidth: imageWidth,
//       iouThreshold: 0.4,
//       confThreshold: 0.4,
//       classThreshold: 0.5,);
//     state = AsyncValue.data(true);
//
//     if (result.isNotEmpty) {
//       kingName="";
//       state = AsyncValue.data(null); // Trigger a state update
//
//       yoloResults = result;
//
//       lastDetectedImage = XFile(image.path);
//
//
//       await stopDetection();
//     }
//     lastDetectedImage = XFile(image.path);
//     state = AsyncValue.data(null); // Trigger a state update
// print("helpp");
//     print(yoloResults);
//     print(lastDetectedImage);
//     print(isDetecting);
//   }
//
//   Future<void> startDetection() async {
//     // Clear previous results and captured image
//     kingName="";
//
//       yoloResults.clear();
//       lastDetectedImage = null;
//       isDetecting = true;
//       state = AsyncValue.data(null); // Trigger a state update
//
//
//     if (controller.value.isStreamingImages) {
//       return;
//     }
//
//     await controller.startImageStream((image) async {
//       if (isDetecting) {
//         cameraImage = image;
//         yoloOnFrame(image);
//       }
//     });
//   }
//
//
//   Future<void> yoloOnFrame(CameraImage cameraImage) async {
//     final result = await vision.yoloOnFrame(
//         bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
//         imageHeight: cameraImage.height,
//         imageWidth: cameraImage.width,
//         iouThreshold: 0.4,
//         confThreshold: 0.4,
//         classThreshold: 0.5);
//     if (result.isNotEmpty) {
//       kingName="";
//       print(result);
//       print("aaaaaaaaaaaaaaaaaaaaaahhhhhhhhhhhhhhhhhh");
//       state = AsyncValue.data(null); // Trigger a state update
//
//         yoloResults = result;
//
//       // Capture the current frame
//       final image = await controller.takePicture();
//
//         lastDetectedImage = image;
//
//       await stopDetection();
//     }
//   }
//   Future<void> stopDetection() async {
//     // kingName="";
//     if (controller.value.isStreamingImages) {
//       await controller.stopImageStream();
//     }
//       isDetecting = false;
//     state = AsyncValue.data(null); // Trigger a state update
//     state = AsyncValue.data(true);
//
//     for(int i =0;i<yoloResults.length;i++){
//
//       if(i!=0){
//         kingName+=" and ";
//       }
//       kingName+=yoloResults[i]["tag"];
//     }
//   }
//   List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
//     if (yoloResults.isEmpty) return [];
//
//     print("the results will appear here");
//     // Get actual camera preview size
//     Size previewSize = Size(controller.value.previewSize!.height,
//         controller.value.previewSize!.width);
//
//     // Scale factors based on actual preview size, not screen size
//     double scaleX = screen.width / previewSize.width;
//     double scaleY = screen.height / previewSize.height;
//
//     return yoloResults.map((result) {
//       double objectX = result["box"][0] * scaleX;
//       double objectY = result["box"][1] * scaleY;
//       double objectWidth = (result["box"][2] - result["box"][0]) * scaleX;
//       double objectHeight = (result["box"][3] - result["box"][1]) * scaleY;
//
//       return Positioned(
//         left: objectX,
//         top: objectY,
//         width: objectWidth,
//         height: objectHeight,
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: Colors.pink, width: 2),
//           ),
//           child: Text(
//             "${result['tag']}",
//             style: TextStyle(
//               background: Paint()..color = Colors.green,
//               color: Colors.white,
//               fontSize: 18,
//             ),
//           ),
//         ),
//       );
//     }).toList();
//   }
//
//
// }