import 'package:flutter/material.dart';
import 'package:tour_guide/features/chat/chat_headers/presentation/view/widgets/side_bar_body_builder.dart';

class ChatPageSideBar extends StatelessWidget {
  const ChatPageSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SideBarBodyBuilder(),
      ),
    );
  }
}
