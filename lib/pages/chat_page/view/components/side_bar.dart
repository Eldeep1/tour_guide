import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/pages/chat_page/view/chat_page_view.dart';
import 'package:tour_guide/pages/chat_page/view_model/side_bar_provider.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

class ChatPageSideBar extends StatelessWidget {
  const ChatPageSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final sideBarData = ref.watch(sideBarProvider('sidebar'));
            return sideBarData.when(
              data: (data) => Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextButton(
                      style: ButtonStyle(
                        // padding: WidgetStatePropertyAll(EdgeInsetsDirectional.only(start: 20)),
                        fixedSize: WidgetStatePropertyAll(Size.fromHeight(60)),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>ProviderScope(child: ChatPageView(chatID: null)),));
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
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            style: BorderStyle.solid,
                            width: 2,
                            color: mainColor)),
                  ),
                  Expanded(
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
                              print(data[index]["chatID"]);
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
                  ),
                ],
              ),
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
        ),
      ),
    );
  }
}
