import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/object_detection_body.dart';

class ObjectDetectionPage extends StatelessWidget {
  const ObjectDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          margin: EdgeInsets.only(right: 40),
          alignment: AlignmentDirectional.center,
          child: Text(
            "Detect Monuments",
            style: Theme.of(context).textTheme.titleLarge,
          ),
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
