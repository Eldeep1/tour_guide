import 'dart:typed_data';
class DetectionState {
  final Uint8List? imageBytes;
  final Uint8List? annotatedImage;
  final List<Map<String, dynamic>> detections;
  final bool isModelLoaded;

  DetectionState({
    this.imageBytes,
    this.annotatedImage,
    this.detections = const [],
    this.isModelLoaded = false,
  });

  DetectionState copyWith({
    Uint8List? imageBytes,
    Uint8List? annotatedImage,
    List<Map<String, dynamic>>? detections,
    bool? isModelLoaded,
  }) {
    return DetectionState(
      imageBytes: imageBytes ?? this.imageBytes,
      annotatedImage: annotatedImage ?? this.annotatedImage,
      detections: detections ?? this.detections,
      isModelLoaded: isModelLoaded ?? this.isModelLoaded,
    );
  }
}
