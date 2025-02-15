import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/pages/chat_page/shared/messages.dart';
import 'package:tour_guide/pages/chat_page/view_model/chat_provider.dart';
import 'package:tour_guide/pages/chat_page/view_model/new_messages_provider.dart';

class ChatHistory extends StatelessWidget {
  final int chatID;
  const ChatHistory({super.key,required this.chatID});

  @override
  Widget build(BuildContext context) {
    return   Consumer(builder: (context, ref, child) {
      final messges = ref.watch(chatPageProvider(chatID));

      return messges.when(
        data: (data) => Builder(builder: (context) {
          return Column(
            key: UniqueKey(), // Forces rebuild when new data arrives

            children:List.generate(data.length, (index) {
              if(index==data.length-1) {
                ref.read(newMessagesProvider.notifier).scrollToBottom();
              }

              return Column(
                children: [
                  promptMessageBuilder(data[index].imageLink, data[index].prompt),
                  // promptMessageBuilder(data[index].prompt, context),
                  answerMessageBuilder(message: data[index].answer, ),
                ],
              );}
            ),);

        },
        ),

        error: (err, stack) => Center(child: Text("can't get the messages right no!"),),
        loading: () =>
            SizedBox(
              height: MediaQuery.sizeOf(context).height,
              child: Center(
                  child: Shimmer.fromColors(baseColor: Colors.grey, highlightColor: Colors.amber, child: CircularProgressIndicator())
              ),
            ),
      );
    },);
  }
}
