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
          itemCount: headers.data!.length,
          itemBuilder: (context, index) {
            // Reverse the order of the items without changing the actual list
            final reversedIndex = headers.data!.length - index - 1;

            return TextButton(
              style: ButtonStyle(
                padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 20)),
                fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
              ),
              onPressed: () {
                Scaffold.of(context).closeDrawer();
                ref.read(appBarHeaderProvider.notifier).state = headers.data![reversedIndex].title ?? "AI TOUR GUIDE";
                ref.read(chatIDProvider.notifier).state = headers.data![reversedIndex].id;
                ref.read(chatDataProvider.notifier).fetchOldMessages();
              },
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  "${headers.data![reversedIndex].title}",
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            );
          },
        ),
      );


    }, error: (error, stackTrace) {
      return Expanded( // <-- Important to expand like your data case
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min, // <-- Important! Makes the Column take only the needed space
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                onPressed: () {
                  ref.read(sideBarProvider.notifier).refreshHeaders();
                },
                child: Icon(Icons.refresh, color: Colors.amber, size: 30),
              ),
              SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16), // Optional if you want spacing
                child: Text(
                  error.toString(),
                  textAlign: TextAlign.center, // Optional to center text
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      );
    },
        loading: () {
          return Expanded(
            child: Center(
              child: Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.amber,
                child: const CircularProgressIndicator(),
              ),
            ),
          );
        },

        );
  }
}