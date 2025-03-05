import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/features/Chat/loaded_chat_page/presentation/view_model/chat_messages_history_provider.dart';
import 'package:tour_guide/features/Chat/shared/providers/new_messages_provider.dart';
import 'package:tour_guide/features/Chat/shared/widgets/messages.dart';

class MessagesHistoryBuilder extends StatelessWidget {
  final int chatID;
  const MessagesHistoryBuilder({super.key, required this.chatID});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          // ref.read(sideBarProvider('sidebar')); // Fetch data first
          final messageProvider = ref.read(newMessagesProvider.notifier); // Read for calling methods
          final newMessages = ref.watch(newMessagesProvider);
          return SingleChildScrollView(
            controller: messageProvider.pageScrollController,
            child: Column(
              children: [
                //loading the messages of the chat
                pastMessagesBuilder(),
                ...newMessages,
              ],
            ),
          );
        },
      ),
    );
  }

  Widget pastMessagesBuilder(){
    return Consumer(
    builder: (context, ref, child) {
      final loadedMessages = ref.watch(chatMessagesHistory(chatID));
      return loadedMessages.when(
        data: (data) => Builder(
          builder: (context) {
            return Column(
              key: UniqueKey(), // Forces rebuild when new data arrives

              children: List.generate(data.length, (index) {
                if (index == data.length - 1) {
                  ref.read(newMessagesProvider.notifier)
                      .scrollToBottom();
                }

                return Column(
                  children: [
                    promptMessageBuilder(data[index].prompt),
                    answerMessageBuilder(message: data[index].answer,),
                  ],
                );
              }),
            );
          },
        ),
        error: (err, stack) => Center(
          child: Text("can't get the messages right no!"),
        ),
        loading: () => SizedBox(
          height: MediaQuery.sizeOf(context).height,
          child: Center(
              child: Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.amber,
                  child: CircularProgressIndicator())),
        ),
      );
    },
    );
  }
}
