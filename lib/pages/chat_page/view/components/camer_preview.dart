import 'package:flutter/material.dart';
import 'package:flutter_vision/flutter_vision.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';
import 'package:camera/camera.dart';
import 'dart:io';

late List<CameraDescription> cameras;

class CameraPreviewScreen extends StatefulWidget {
  const CameraPreviewScreen({
    super.key,
  });

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController controller;
  late FlutterVision vision;
  late List<Map<String, dynamic>> yoloResults;
  CameraImage? cameraImage;
  bool isLoaded = false;
  bool isDetecting = false;
  double confidenceThreshold = 0.5;
  XFile? lastDetectedImage;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    cameras = await availableCameras();
    vision = FlutterVision();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller.initialize().then((value) {
      loadYoloModel().then((value) {
        setState(() {
          isLoaded = true;
          isDetecting = false;
          yoloResults = [];
        });
      });
    });
  }

  Future<void> loadYoloModel() async {
    await vision.loadYoloModel(
      labels: 'assets/labels.txt',
      modelPath: 'assets/model/best_float16.tflite',
      modelVersion: "yolov8",
      numThreads: 1,
    );
    setState(() {
      isLoaded = true;
    });
  }

  Future<void> startDetection() async {
    // Clear previous results and captured image
    setState(() {
      yoloResults.clear();
      lastDetectedImage = null;
      isDetecting = true;
    });

    if (controller.value.isStreamingImages) {
      return;
    }

    await controller.startImageStream((image) async {
      if (isDetecting) {
        cameraImage = image;
        yoloOnFrame(image);
      }
    });
  }

  Future<void> yoloOnFrame(CameraImage cameraImage) async {
    final result = await vision.yoloOnFrame(
        bytesList: cameraImage.planes.map((plane) => plane.bytes).toList(),
        imageHeight: cameraImage.height,
        imageWidth: cameraImage.width,
        iouThreshold: 0.4,
        confThreshold: 0.4,
        classThreshold: 0.5);
    if (result.isNotEmpty) {
      setState(() {
        yoloResults = result;
      });
      // Capture the current frame
      final image = await controller.takePicture();
      setState(() {
        lastDetectedImage = image;
      });
      await stopDetection();
    }
  }

  Future<void> stopDetection() async {
    if (controller.value.isStreamingImages) {
      await controller.stopImageStream();
    }
    setState(() {
      isDetecting = false;
    });
  }

  @override
  void dispose() async {
    super.dispose();
    controller.dispose();
    await vision.closeYoloModel();
  }

  List<Widget> displayBoxesAroundRecognizedObjects(Size screen) {
    if (yoloResults.isEmpty) return [];
    double factorX = screen.width / (cameraImage?.height ?? 1);
    double factorY = screen.height / (cameraImage?.width ?? 1);

    return yoloResults.map((result) {
      double objectX = result["box"][0] * factorX;
      double objectY = result["box"][1] * factorY;
      double objectWidth = (result["box"][2] - result["box"][0]) * factorX;
      double objectHeight = (result["box"][3] - result["box"][1]) * factorY;

      return Positioned(
        left: objectX,
        top: objectY,
        width: objectWidth,
        height: objectHeight,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(color: Colors.pink, width: 2.0),
          ),
          child: Text(
            "${result['tag']} ",
            style: TextStyle(
              background: Paint()..color = Colors.green,
              color: Colors.white,
              fontSize: 18.0,
            ),
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(),
      body: isLoaded
          ? Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (lastDetectedImage != null && !isDetecting)
              Image.file(
                File(lastDetectedImage!.path),
                fit: BoxFit.cover,
              )
            else
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller),
              ),
            if (lastDetectedImage != null && !isDetecting)
              ...displayBoxesAroundRecognizedObjects(size),
            Positioned(
              bottom: 130,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 5, color: Colors.white),
                ),
                child: isDetecting
                    ? IconButton(
                  onPressed: () async {
                    await stopDetection();
                  },
                  icon: const Icon(Icons.stop, color: Colors.red),
                  iconSize: 50,
                )
                    : IconButton(
                  onPressed: () async {
                    await startDetection();
                  },
                  icon: const Icon(Icons.play_arrow,
                      color: Colors.white),
                  iconSize: 50,
                ),
              ),
            ),
          ],
        ),
      )
          : Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("loading the model"),
            Padding(padding: EdgeInsets.all(30)),
            CircularProgressIndicator(
              color: Colors.red,
            ),
          ],
        ),
      ),
    );
  }
}