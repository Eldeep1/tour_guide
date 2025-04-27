import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:popover/popover.dart';
import 'package:tour_guide/constants.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/view/widgets/popover_body_builder.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerText = ref.watch(appBarHeaderProvider);

    print("hello from the appbar$headerText");
    return AppBar(
      backgroundColor: appBarColor,
      leading: Builder(builder: (context) {
        return IconButton(
          tooltip: "Show Side Bar",
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu,color: Colors.white,),
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
        Builder(
          builder: (buttonContext) => IconButton(
            tooltip: "user things",
            onPressed: () {
              showPopover(
                context: buttonContext,
                bodyBuilder: (context) => MenuItems(),
                direction: PopoverDirection.top,
                width: 100,
                height: 50,
                backgroundColor:Color(0xff1e2f73),
              );
            },
            icon: const Icon(Icons.person_outline_outlined),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
