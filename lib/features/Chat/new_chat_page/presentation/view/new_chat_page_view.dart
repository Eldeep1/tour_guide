import 'package:flutter/material.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/widgets/new_chat_page_body_builder.dart';
import 'package:tour_guide/features/Chat/chat_side_bar/presentation/view/chat_side_bar.dart';
import 'package:tour_guide/features/Chat/shared/widgets/app_bar_builder.dart';

class NewChatPageView extends StatelessWidget {
   const NewChatPageView({super.key,required this.header});

  final String header;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarBuilder(context),
      drawer: ChatPageSideBar(),
      body: Padding(
        padding:const EdgeInsets.only(bottom: 30.0, left: 30, right: 30),
        child: newChatPageBodyBuilder(context,header),
      ),
    );
  }
}
