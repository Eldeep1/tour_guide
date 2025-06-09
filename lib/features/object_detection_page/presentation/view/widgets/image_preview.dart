import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';
import 'package:ultralytics_yolo/yolo.dart';

class ImagePreview extends ConsumerWidget {
  const ImagePreview({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detectionAsync = ref.watch(detectionProvider);

    return detectionAsync.when(
      data: (state) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // if (state.annotatedImage != null)
          //   Image.memory(state.annotatedImage!, width: double.infinity,fit: BoxFit.fill,)
          if (state.imageBytes != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30)
                ),
                child: Image.memory(
                  // state.imageBytes!,
                  state.imageBytes!,
                ),
              ),
            ),
          const SizedBox(height: 10),
        ],
      ),
      loading: () {
        return CircularProgressIndicator(
          backgroundColor: Colors.red,
        );
      },
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }
}
