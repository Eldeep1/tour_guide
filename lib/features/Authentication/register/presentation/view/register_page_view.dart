
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/features/Authentication/widgets/back_ground_image.dart';
import 'package:tour_guide/constants.dart';

import 'widgets/register_page_body_builder.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth>largeScreenSize)
        {
          double itemsWidth=constraints.maxWidth/3;
          return Row(
            children: [
              Expanded(child: signUpPageBodyBuilder(context, itemsWidth)),
              Expanded(child: backgroundImage(1))
            ],
          );
        }
        else{
          double itemsWidth=constraints.maxWidth/2;
          return signUpPageBodyBuilder(context, itemsWidth);
        }
      },),


    );
  }
}
