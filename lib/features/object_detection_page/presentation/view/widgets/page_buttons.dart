import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/image_picker/image_picker_service.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/image_path_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';


class PageButtons extends ConsumerWidget {
  const PageButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber)
            ),
            onPressed: ()  async {

              ref.read(imagePathProvider.notifier).state=await ImagePickerService.captureImage();
              ref.read(detectionProvider.notifier).predict();

            }, child: Text("Take Picture!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
        SizedBox(width: 12,),
        OutlinedButton(
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.amber)
            ),
            onPressed: ()async{
              ref.read(imagePathProvider.notifier).state=await ImagePickerService.uploadImage();
              ref.read(detectionProvider.notifier).predict();
            }, child: Text("Upload Picture!",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),

      ],
    );
  }


}
