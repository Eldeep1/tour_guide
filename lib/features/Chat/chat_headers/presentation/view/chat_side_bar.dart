import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view/widgets/side_bar_body_builder.dart';

class ChatPageSideBar extends StatelessWidget {
  const ChatPageSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: SideBarBodyBuilder()
      ),
    );
  }
}
