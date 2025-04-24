//
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/annotated_image.dart';
// import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/detection_buttons_raw.dart';
// import 'package:tour_guide/features/object_detection_page/presentation/view_model/model_provider.dart';
//
// import 'adaptive_camera_preview.dart';
//
// class ObjectDetectionBodyBuilder extends ConsumerWidget {
//   const ObjectDetectionBodyBuilder({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final modelNotifier = ref.watch(modelProvider.notifier);
//     print(ref.toString());
//
//     return Stack(
//       fit: StackFit.expand,
//       children: [
//         if (modelNotifier.lastDetectedImage != null &&
//             !modelNotifier.isDetecting)
//           annotatedImageBuilder(context)
//         else
//           if(modelNotifier.lastDetectedImage==null&&!modelNotifier.firstTime&&modelNotifier.isDetecting)
//           AdaptiveCameraPreview(controller: modelNotifier.controller,
//               cameras: modelNotifier.cameras),
//         detectionButtonsRawBuilder(modelNotifier, context),
//
//       ],
//     );
//   }
// }
