import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';

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
             SizedBox(
                 width: MediaQuery.of(context).size.width/2,
                 height: MediaQuery.of(context).size.height/2,
                 child: Image.memory(state.imageBytes!,width: double.infinity,fit: BoxFit.fill,)),
          const SizedBox(height: 10),

        ],
      ),
      loading: () {
        return CircularProgressIndicator(backgroundColor: Colors.red,);

      },
      error: (e, st) => Text('Error: $e'),
    );
  }
}
