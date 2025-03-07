import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view_model/model_provider.dart';

Widget annotatedImageBuilder(context) {

  print("so, the annotation should appear, right?");
  return Consumer(
    builder: (BuildContext context, WidgetRef ref, Widget? child) {
      print(ref.toString());

      final modelNotifier=ref.watch(modelProvider.notifier);
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(modelNotifier.lastDetectedImage!.path),
            fit: BoxFit.cover,
          ),
          ...modelNotifier.displayBoxesAroundRecognizedObjects(MediaQuery.of(context).size),
        ],
      );
    },

  );
}