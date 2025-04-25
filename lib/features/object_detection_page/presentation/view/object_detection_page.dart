import 'package:flutter/material.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/object_detection_body.dart';

class ObjectDetectionPage extends StatelessWidget {
  const ObjectDetectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: ObjectDetectionBody()),
        ],
      ),
    );
  }
}
