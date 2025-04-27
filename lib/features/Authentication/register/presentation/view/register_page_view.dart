
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/widgets/back_ground_image.dart';
import 'package:tour_guide/constants.dart';

import 'widgets/register_page_body_builder.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        iconTheme: IconThemeData(
          color: Colors.white, // Set the back icon color to white
        ),
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth>largeScreenSize)
        {
          double itemsWidth=constraints.maxWidth/3;
          return Row(
            children: [
              Expanded(child: SignUpPageBodyBuilder(itemsWidth: itemsWidth)),
              Expanded(child: backgroundImage(1))
            ],
          );
        }
        else{
          double itemsWidth=constraints.maxWidth/2;
          return Stack(

            children: [
              backgroundGradient,
              Center(child: SignUpPageBodyBuilder(itemsWidth: itemsWidth)),
            ],
          );
        }
      },),


    );
  }
}
