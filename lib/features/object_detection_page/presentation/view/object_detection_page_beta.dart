// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:tour_guide/features/object_detection_page/presentation/view/widgets/object_detection_body_builder.dart';
// import '../view_model/model_provider.dart';
//
// class ObjectDetectionPage extends ConsumerWidget {
//   const ObjectDetectionPage({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final modelState = ref.watch(modelProvider);
//     final modelNotifier = ref.read(modelProvider.notifier);
//
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(onPressed: (){
//             ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
//               if(value!=null) {
//                 modelNotifier.detectFromGallery(value);
//               }
//             },);
//           }, icon: Icon(Icons.drive_folder_upload_outlined),),
//         ],
//       ),
//       body: Consumer(
//           builder:(context, ref, child) {
//             return modelState.when(
//                 data: (data) {
//                   return ObjectDetectionBodyBuilder();
//                 },
//               error: (error, stackTrace) {
//                 return errorLoadingTheModel(error,ref);
//               },
//                 loading:() => loadingTheModelBuilder(), );
//           },
//       ),
//     );
//   }
// }
//
// Widget errorLoadingTheModel(error,ref){
//   return Center(
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Failed to load model"),
//         Text(error.toString()), // Show more details
//         ElevatedButton(
//           onPressed: () => ref.invalidate(modelProvider),
//           child: Text("Retry"),
//         )
//       ],
//     ),
//   );
// }
//
// Widget loadingTheModelBuilder(){
//   return Center(
//     child: Column(
//       mainAxisSize: MainAxisSize.max,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("loading the model"),
//         Padding(padding: EdgeInsets.all(30)),
//         CircularProgressIndicator(
//           color: Colors.red,
//         ),
//       ],
//     ),
//   );
// }
