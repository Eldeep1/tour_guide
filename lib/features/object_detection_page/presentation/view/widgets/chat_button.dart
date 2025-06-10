import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/data/model/chat_image.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/image_path_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';

class ChatButton extends ConsumerWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detectionProvider).value;
    final detectionState = ref.watch(detectionProvider.notifier);

    if (detectionState.detectionOutput.index == 0) {
      print(detectionState.detectionOutput);
      print("hmmmm");
      print(state!.detections[0]['cls']);
      return SizedBox(
        height: 140,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(state!.detections.length, (index) {
                  final item = state.detections[index];
                  final label = Platform.isAndroid ? item["class"] : item["cls"];

                  double width =  MediaQuery.of(context).size.width * 0.4;

                  if(index==state.detections.length-1 && index%2 ==0 ){
                    width=width*2;
                  }
                  return SizedBox(
                    width: width, // 2 per row
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () async {
                        final imagePath = ref.read(imagePathProvider);
                        final chatImage = await ChatImage.fromFile(imagePath!);

                        final current = ref.read(messageRequestProvider);
                        ref.read(messageRequestProvider.notifier).state = current.copyWith(
                          label: label,
                          image: chatImage,
                        );

                        Navigator.pop(context);
                      },
                      child: Text(
                        "Chat About $label",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              )
            ],
          ),
        ),
      );

    }
    if (detectionState.detectionOutput.index == 1) {
      return Text(
        "No Detections!",
        style: Theme.of(context).textTheme.bodyMedium,
      );
    } else {
      return SizedBox();
    }
    // TODO: implement build
  }
}
