import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/object_detection_page/presentation/providers/model_provider.dart';

class ChatButton extends ConsumerWidget {
  const ChatButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(detectionProvider).value;
    final detectionState = ref.watch(detectionProvider.notifier);

    print("here comes the error");
    print(detectionState.detectionOutput.index);
    if(detectionState.detectionOutput.index==0){
      return OutlinedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.amber),
        ),
        onPressed: () {showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min, // 👈 VERY IMPORTANT
              children: const [
                Text("الحقنا بال endpoint يا لطفي",textDirection: TextDirection.rtl,),
              ],
            ),
          ),
        );

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
        style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),
      );
    }
    else{
      return SizedBox();
    }
    // TODO: implement build

  }

}
