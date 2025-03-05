import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tour_guide/constants.dart';

import '../../../widgets/back_ground_image.dart';
import 'widgets/login_page_body.dart';


class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(

      body: SafeArea(

        child: LayoutBuilder(builder: (context, constraints) {
          if(constraints.maxWidth>largeScreenSize){
            double itemsWidth=constraints.maxWidth/3;
            return Row(
              children: [
                Expanded(
                  child: pageBodyBuilder(context,itemsWidth),
                ),
                Expanded(child: backgroundImage(1))
              ],
            );
          }
          else{
            double itemsWidth=constraints.maxWidth/2;
            return Stack(
              children: [
                backgroundImage(.5),
                pageBodyBuilder(context,itemsWidth),
              ],
            );
          }
        },),
      ),

    );
  }



}