
import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/dark/dark_theme.dart';
import 'chat_headers_history.dart';
import 'new_chat_button_builder.dart';


class SideBarBodyBuilder extends StatelessWidget {
  const SideBarBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return backgroundGradient(
      radius: 0,
      childWidget: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(height: 10,),
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
            color: mainColorDark)),
  );
}