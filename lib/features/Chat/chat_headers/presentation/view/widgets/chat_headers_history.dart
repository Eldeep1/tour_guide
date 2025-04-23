import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Chat/chat_headers/data/chat_headers_model.dart';
import 'package:tour_guide/features/Chat/loaded_chat_page/presentation/view/loaded_chat_page_view.dart';

Widget chatHeaderHistory({
  required ChatHeaders headers
}){
  return Expanded(
    child: ListView.builder(
      itemBuilder: (context, index) {
        print(headers.data!.length);
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
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ProviderScope(child: ChatPageView(chatID:headers.data![index].id!));
              },));

            },
            child: Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                "${headers.data![index].title}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
        );
      },
      itemCount: headers.data!.length,
    ),
  );
}