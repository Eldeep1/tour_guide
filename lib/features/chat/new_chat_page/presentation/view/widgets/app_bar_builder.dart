import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:popover/popover.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'package:tour_guide/core/themes/light_theme.dart';
import 'package:tour_guide/core/themes/theme_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/chat/new_chat_page/presentation/view/widgets/popover_body_builder.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerText = ref.watch(appBarHeaderProvider);
    final theme = ref.watch(themeProvider.notifier).themeData;
    bool isDark=theme==darkTheme;
    return AppBar(
      iconTheme: Theme.of(context).iconTheme,
      leading: Builder(builder: (context) {
        return IconButton(
          tooltip: "Show Side Bar",
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu),
        );
      }),
      title: Align(
        alignment: AlignmentDirectional.center,
        child: Text(
          headerText,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      actions: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {

            return  Builder(
              builder: (buttonContext) {
                return IconButton(
                  tooltip: "user things",
                  onPressed: () {
                    showPopover(
                      context: buttonContext,
                      bodyBuilder: (context) => MenuItems(),
                      direction: PopoverDirection.top,
                      width: 142,
                      // height: 150,
                      height: 100,
                      backgroundColor:isDark?buttonColorDark:buttonColorLight,
                    );
                  },
                  icon: const Icon(Icons.person_outline_outlined),
                );
              },
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
