import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';
import 'package:tour_guide/features/Chat/shared/widgets/messages.dart';
import 'package:tour_guide/features/Chat/shared/widgets/send_message_form_field_builder.dart';

class NewChatPageBodyBuilder extends ConsumerWidget {
  const NewChatPageBodyBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatList = ref.watch(chatDataProvider);

    return Column(
      children: [
        Expanded(
          child: chatList.when(
            data: (messages) {
              if (messages.isEmpty) {
                return const Center(child: Text("Start a new chat..."));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];

                  if (message.response == null) {
                    return promptMessageBuilder(message.prompt!,isLoading: true);
                    // Loading bubble
                  }

                  if (message.response!.startsWith("Error:")) {
                    return Column(
                      children: [
                        promptMessageBuilder(message.prompt ?? ""),
                        errorMessageBuilder(message.response!),
                      ],
                    );
                  }

                  // Normal message
                  return Column(
                    children: [
                      promptMessageBuilder(message.prompt ?? ""),
                      answerMessageBuilder(message: message.response ?? ""),
                    ],
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => SingleChildScrollView(child: Center(child: Text("Error: $error"))),
          ),
        ),
         SendMessageFormFieldBuilder(),
      ],
    );
  }
}