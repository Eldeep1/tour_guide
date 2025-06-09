import 'dart:async';
import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/object_detection_page/data/model/detection_state.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/image_path_provider.dart';
import 'package:ultralytics_yolo/yolo.dart';

enum DetectionOutput { detected, noDetection, firstTime }

final detectionProvider =
    AsyncNotifierProvider<DetectionNotifier, DetectionState>(() {
  return DetectionNotifier();
});

class DetectionNotifier extends AsyncNotifier<DetectionState> {
  late YOLO _yolo;
  DetectionOutput detectionOutput = DetectionOutput.firstTime;

  @override
  FutureOr<DetectionState> build() async {
    _yolo = YOLO(modelPath: 'yolo', task: YOLOTask.detect);
    try {
      await _yolo.loadModel();
      return DetectionState(isModelLoaded: true);
    } catch (e, st) {
      // If model loading fails, return error state
      throw AsyncError(e, st);
    }
  }

  Future<void> predict() async {
    state = AsyncLoading();
    try {
      final file = ref.read(imagePathProvider);
      if (file == null) return;

      final bytes = await file.readAsBytes();
      final result = await _yolo.predict(bytes);

      final filteredDetections =
          List<Map<String, dynamic>>.from(result['boxes']);

      print(result);
      print("the above is the result for the yolo model..");
      print(filteredDetections);
      final detections = filteredDetections.where((detection) {
        final double? confidence = detection['confidence']?.toDouble();
        //TODO: adding threshold?
        return confidence != null && confidence >= .6;
      }).toList();

      final annotatedImage = result['annotatedImage'] is Uint8List
          ? result['annotatedImage'] as Uint8List
          : null;

      state = AsyncData(state.value!.copyWith(
        imageBytes: bytes,
        annotatedImage: annotatedImage,
        detections: detections,
      ));

      if (detections.isEmpty) {
        detectionOutput = DetectionOutput.noDetection;
      } else {
        detectionOutput = DetectionOutput.detected;
      }
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
      detectionOutput = DetectionOutput.noDetection;
    }
  }
}
