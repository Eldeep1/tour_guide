
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';

import 'chat_headers_history.dart';
import 'new_chat_button_builder.dart';

class SideBarBodyBuilder extends ConsumerWidget {
  const SideBarBodyBuilder({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sideBarData = ref.watch(chatHeadersProvider);
    return Column(
      children: [
        newChatButtonBuilder(context),
        separator(),
        chatHeaderHistory(headers: sideBarData),
      ],
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