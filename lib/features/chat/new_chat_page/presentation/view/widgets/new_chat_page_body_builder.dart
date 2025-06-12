import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';


import 'messages.dart';
import 'send_message_form_field_builder.dart';

class NewChatPageBodyBuilder extends ConsumerWidget {
   NewChatPageBodyBuilder({super.key});
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatList = ref.watch(chatDataProvider);
    ref.listen(chatDataProvider, (previous, next) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.hasClients) {
          controller.jumpTo(controller.position.maxScrollExtent);
        }
      });
    });

    return Column(
      children: [
        Expanded(
          child: chatList.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(child: Text("Start a new chat..."));
              }

              return ListView.builder(
                controller: controller,
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  if (message.response == null) {
                    return Column(
                      children: [
                        promptMessageBuilder(message.prompt!,byteImage: message.byteImage,linkImage: message.linkImage),
                        answerMessageBuilder(message:"Loading Response",isLoading: true),
                      ],
                    );
                    // Loading bubble
                  }

                  if (message.response!.startsWith("Error:")) {
                    return Column(
                      children: [
                        promptMessageBuilder(message.prompt ?? "",byteImage: message.byteImage,linkImage: message.linkImage),
                        errorMessageBuilder(message.response!),
                      ],
                    );
                  }

                  // Normal message
                  return Column(
                    children: [
                      promptMessageBuilder(message.prompt ?? "",byteImage: message.byteImage,linkImage: message.linkImage),
                      answerMessageBuilder(message: message.response ?? ""),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) {

              return SingleChildScrollView(child: Center(child: Text("Error: $error")));
            },
          ),
        ),
         SendMessageFormFieldBuilder(),
      ],
    );
  }
}