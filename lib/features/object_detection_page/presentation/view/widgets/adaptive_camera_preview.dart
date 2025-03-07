import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AdaptiveCameraPreview extends StatelessWidget {
  final CameraController controller;
  final List<CameraDescription> cameras;

  const AdaptiveCameraPreview({
    super.key,
    required this.controller,
    required this.cameras,
  });

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    // Get screen size
    final size = MediaQuery.of(context).size;

    // Calculate scale to fill screen width
    final scale = size.aspectRatio * controller.value.aspectRatio;

    // Get current camera
    final camera = cameras.firstWhere(
          (c) => c.lensDirection == controller.description.lensDirection,
      orElse: () => cameras[0],
    );


    final bool isTablet = size.shortestSide > 600;

    return Center(
      child: !isTablet
          ? Transform.rotate(
        angle: pi / 2, // Rotate only if needed
        child: CameraPreview(controller),
      )
          : CameraPreview(controller),
    );

  }
}