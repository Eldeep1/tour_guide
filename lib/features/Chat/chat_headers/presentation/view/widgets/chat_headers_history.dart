import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/loaded_chat_page/presentation/view/loaded_chat_page_view.dart';

Widget chatHeaderHistory(data){
  return Expanded(
    child: ListView.builder(
      itemBuilder: (context, index) {
        print(data.length);
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextButton(
            style: ButtonStyle(
              padding: WidgetStatePropertyAll(
                  EdgeInsetsDirectional.only(start: 20)),
              fixedSize:
              WidgetStatePropertyAll(Size.fromHeight(60)),
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>ProviderScope(child: ChatPageView(chatID:data[index]["chatID"])),));

            },
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${data[index]["chatHeader"]}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
      itemCount: data.length,
    ),
  );
}