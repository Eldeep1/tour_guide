
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view/widgets/chat_headers_history.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view/widgets/new_chat_button_builder.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view_model/side_bar_provider.dart';

class SideBarBodyBuilder extends StatelessWidget {
  const SideBarBodyBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return   Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final sideBarData = ref.watch(sideBarProvider('sidebar'));
        return sideBarData.when(
          data: (data) => dataLoadingSuccess(context, data),
          error: (err, stack) => Center(
            child: Column(
              children: [
                Text('Error Loading Chats'),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.restart_alt_outlined),
                ),
              ],
            ),
          ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}



Widget dataLoadingSuccess(context,data){
  return Column(
    children: [
      newChatButtonBuilder(context),
      separator(),
      chatHeaderHistory(data),
    ],
  );
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