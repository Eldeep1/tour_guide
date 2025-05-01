import 'package:flutter/material.dart';
import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/object_detection_body.dart';

class ObjectDetectionPage extends StatelessWidget {
  const ObjectDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back icon color to white
        ),
      ),
      body: Stack(
        children: [
          backgroundGradient(),
          ObjectDetectionBody(),
        ],
      ),
    );
  }
}
