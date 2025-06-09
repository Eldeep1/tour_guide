import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
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
                children: List.generate(state.detections.length, (index) {
                  final item = state.detections[index];
                  final label = Platform.isAndroid ? item["class"] : item["cls"];

                  double width =  MediaQuery.of(context).size.width * 0.4;
                  if(index==state.detections.length-1 && index%2 ==0 ){
                    print("we are here?");
                    width=width*2;
                  }
                  return SizedBox(
                    width: width, // 2 per row
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {
                        ref.read(foundMonument.notifier).state=label;
                        // String prompt = "Can you tell me more about ${item["cls"]}";
                        // ref.read(chatDataProvider.notifier).sendMessage(prompt: prompt);
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
          
          
              //   shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //   return OutlinedButton(
              //     style: ButtonStyle(
              //       backgroundColor: WidgetStatePropertyAll(Colors.amber),
              //     ),
              //     onPressed: () {
              //       String prompt =
              //           "Can you tell me more about ${state.detections.map((d) => d['cls'].toString()).join(', ')}";
              //       ref.read(chatDataProvider.notifier).sendMessage(prompt: prompt);
              //       Navigator.pop(context);
              //     },
              //     child: Text(
              //       Platform.isAndroid?
              //         "Chat About ${state.detections[0]["class"]}":
              //       "Chat About ${state.detections[0]["cls"]}",
              //
              //       // "Chat About ${state.detections.[map((d) => d['cls'].toString()).join(', ')]}",
              //       style: TextStyle(
              //           fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
              //     ),
              //   );
              //   },
              // itemCount: 4,
              // ),
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
