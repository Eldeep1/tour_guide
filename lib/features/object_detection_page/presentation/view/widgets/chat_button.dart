import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';

class ChatButton extends ConsumerWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detectionProvider).value;
    final detectionState = ref.watch(detectionProvider.notifier);

    if(detectionState.detectionOutput.index==0){
      return OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.amber),
        ),
        onPressed: () {
          String prompt="Can you tell me more about ${state.detections.map((d) => d['class'].toString()).join(', ')}";
          ref.read(chatDataProvider.notifier).sendMessage(prompt: prompt);
          Navigator.pop(context);
        },
        child: Text(
          "Chat About ${state!.detections.map((d) => d['class'].toString()).join(', ')}",
          style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold),
        ),
      );
    }
    if(detectionState.detectionOutput.index==1){
      return Text(
        "No Detections!",
        style: Theme.of(context).textTheme.bodyMedium,
      );
    }
    else{
      return SizedBox();
    }
    // TODO: implement build

  }

}
