import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/new_chat_page_view.dart';

Widget newChatButtonBuilder(context){
  return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        style: ButtonStyle(
          // padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 20)),
          fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>ProviderScope(child: NewChatPageView(header: newChatMessage,)),));
        },
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            "New Chat",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: freeTextColor),
          ),
        ),
      ),
    );
}