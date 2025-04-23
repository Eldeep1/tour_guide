
import 'package:flutter/material.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/view/chat_side_bar.dart';
import 'package:tour_guide/features/Chat/loaded_chat_page/presentation/view/widgets/loaded_chat_body_builder.dart';

import 'package:tour_guide/features/Chat/shared/widgets/app_bar_builder.dart';

class ChatPageView extends StatelessWidget {
  final int chatID;

  const ChatPageView({super.key,required this.chatID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(context),
      drawer:ChatPageSideBar(),

      body: Padding(
        padding: const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
        child: LoadedChatBodyBuilder(chatID: chatID),
      ),
    );
  }


}