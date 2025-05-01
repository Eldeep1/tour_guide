import 'package:flutter/material.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/view/widgets/side_bar_body_builder.dart';

class ChatPageSideBar extends StatelessWidget {
  const ChatPageSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SideBarBodyBuilder(),
    );
  }
}
