import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/core/utils/Assets/assets.dart';
import 'package:tour_guide/features/object_detection_page/presentation/view/object_detection_page_beta.dart';

PreferredSizeWidget appBarBuilder (context){
  return AppBar(
    leading: Builder(builder: (context) {
      return IconButton(
        tooltip: "show Side bar",
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
        icon: Align(
          alignment: AlignmentDirectional.center,
          child: SvgPicture.asset(
            colorFilter: ColorFilter.mode(widgetsInMainColor, BlendMode.srcIn),
            Assets.sideBarIcon,
            alignment: AlignmentDirectional.center,
          ),
        ),
      );
    }),
    actions: [
      IconButton(
        tooltip: "Start Detection",
        onPressed: () async {

          Navigator.push(context, MaterialPageRoute(builder: (context) => ProviderScope(child: ObjectDetectionPage()),));
        },
        icon: Icon(
          Icons.camera_alt_outlined,
        ),
      ),
    ],
    title: Align(
      alignment: AlignmentDirectional.center,
      child: Text(
        "AI TOUR GUIDE",
        style: Theme.of(context).textTheme.titleLarge,
      ),
    ),
  );
}