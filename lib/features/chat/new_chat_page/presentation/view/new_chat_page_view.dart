import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/features/chat/chat_headers/presentation/view/chat_side_bar.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/view/widgets/new_chat_page_body_builder.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/view/widgets/app_bar_builder.dart';

class NewChatPageView extends StatelessWidget {
  const NewChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: ChatPageSideBar(),
      body: SafeArea(
        child: Stack(
          children: [
            reversedBackgroundGradient(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: NewChatPageBodyBuilder(),
            ),
          ],
        ),
      ),
    );
  }
}