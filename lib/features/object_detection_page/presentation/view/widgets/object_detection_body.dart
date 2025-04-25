import 'package:flutter/material.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/chat_button.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/image_preview.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/page_buttons.dart';

class ObjectDetectionBody extends StatelessWidget {
  const ObjectDetectionBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        PageButtons(),
        Flexible(fit: FlexFit.loose,child: ImagePreview()),
        ChatButton(),

      ],
    );
  }
}
