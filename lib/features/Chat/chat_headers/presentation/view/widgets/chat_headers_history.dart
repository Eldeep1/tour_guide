import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/features/Chat/chat_headers/presentation/providers/side_bar_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/chat_messages_provider.dart';

class ChatHeaderHistory extends ConsumerWidget {
  const ChatHeaderHistory({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    final chatHeaders = ref.watch(sideBarProvider);

    return chatHeaders.when(data: (headers) {
      return Expanded(
        child: ListView.builder(
          itemBuilder: (context, index) {
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
                  Scaffold.of(context).closeDrawer();
                  ref.read(appBarHeaderProvider.notifier).state=headers.data![index].title??"AI TOUR GUIDE";
                  ref.read(chatIDProvider.notifier).state=headers.data![index].id;
                  ref.read(chatDataProvider.notifier).fetchOldMessages();
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

    }, error: (error, stackTrace) {
      return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OutlinedButton(onPressed: (){
              ref.read(sideBarProvider.notifier).refreshHeaders();
            }, child: Icon(Icons.refresh,color: Colors.redAccent,size: 30,),),

            SizedBox(height: 8,),

            Text(error.toString(),style: TextStyle(color: Colors.red),)
          ],
        ),
      );
    }, loading: () {

      return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.amber,
        child: const CircularProgressIndicator(),
      );
    },);
  }
}