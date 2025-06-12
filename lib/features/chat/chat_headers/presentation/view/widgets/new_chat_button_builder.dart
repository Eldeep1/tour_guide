import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/chat_messages_provider.dart';

class NewChatButtonBuilder extends ConsumerWidget {
  const NewChatButtonBuilder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatData = ref.read(chatDataProvider.notifier);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        style: ButtonStyle(
          // padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 20)),
          fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
        ),
        onPressed: () {
          chatData.newChat();
          Scaffold.of(context).closeDrawer();
        },
        child: Align(
          alignment: AlignmentDirectional.center,
          child: Text(
            "New Chat",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
