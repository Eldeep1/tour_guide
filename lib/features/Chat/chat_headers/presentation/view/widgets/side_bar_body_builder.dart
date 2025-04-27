
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/providers/side_bar_provider.dart';

import 'chat_headers_history.dart';
import 'new_chat_button_builder.dart';


class SideBarBodyBuilder extends StatelessWidget {
  const SideBarBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff000412),  Color(0xff070E26),Colors.deepPurple,],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            NewChatButtonBuilder(),
            separator(),

            ChatHeaderHistory(),

          ],
        ),
      ),
    );
  }
}
Widget separator(){
  return Container(
    decoration: BoxDecoration(
        border: Border.all(
            style: BorderStyle.solid,
            width: 2,
            color: mainColor)),
  );
}