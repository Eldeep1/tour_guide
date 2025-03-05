import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/shared/widgets/send_message_form_field_builder.dart';

import 'messages_history_builder.dart';

class LoadedChatBodyBuilder extends StatelessWidget {
  final int chatID;
  const LoadedChatBodyBuilder({super.key,required this.chatID});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ProviderScope(child: MessagesHistoryBuilder(chatID: chatID,)),


        // showing sending message form field
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SendMessageFormFieldBuilder(),
          ],
        ),
      ],
    );
  }
}
