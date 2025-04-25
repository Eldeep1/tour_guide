import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';
import 'package:tour_guide/features/Chat/new_chat_page/presentation/providers/page_variables_provider.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final headerText = ref.watch(appBarHeaderProvider);

    print("hello from the appbar$headerText");
    return AppBar(
      leading: Builder(builder: (context) {
        return IconButton(
          tooltip: "Show Side Bar",
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Align(
            alignment: AlignmentDirectional.center,
            child: Icon(Icons.menu),
          ),
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
        IconButton(
          tooltip: "Start Detection",
          onPressed: () {
            // Your logic here
          },
          icon: const Icon(Icons.camera_alt_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

//
// class AppBarBuilder extends ConsumerWidget{
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // TODO: implement build
//     throw UnimplementedError();
//   }
//
// }
// PreferredSizeWidget appBarBuilder (context){
//   return AppBar(
//     leading: Builder(builder: (context) {
//       return IconButton(
//         tooltip: "show Side bar",
//         onPressed: () {
//           Scaffold.of(context).openDrawer();
//         },
//         icon: Align(
//           alignment: AlignmentDirectional.center,
//           child: SvgPicture.asset(
//             colorFilter: ColorFilter.mode(widgetsInMainColor, BlendMode.srcIn),
//             Assets.sideBarIcon,
//             alignment: AlignmentDirectional.center,
//           ),
//         ),
//       );
//     }),
//     actions: [
//       IconButton(
//         tooltip: "Start Detection",
//         onPressed: () async {
//
//           // Navigator.push(context, MaterialPageRoute(builder: (context) => ObjectDetectionPage(),));
//         },
//         icon: Icon(
//           Icons.camera_alt_outlined,
//         ),
//       ),
//     ],
//     title: Align(
//       alignment: AlignmentDirectional.center,
//       child: Consumer(
//         builder: (BuildContext context, WidgetRef ref, Widget? child) {
//           print(ref.read(appBarHeaderProvider));
//           return Text(
//             ref.watch(appBarHeaderProvider),
//             style: Theme.of(context).textTheme.titleLarge,
//           );
//         },
//
//       ),
//     ),
//   );
// }