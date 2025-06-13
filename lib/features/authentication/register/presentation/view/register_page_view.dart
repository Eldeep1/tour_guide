
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/dark/dark_theme.dart';
import 'package:tour_guide/features/authentication/widgets/back_ground_image.dart';

import 'widgets/register_page_body_builder.dart';

class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        if(constraints.maxWidth>700)
        {
          return Row(
            children: [
              Expanded(child: SignUpPageBodyBuilder()),
              Expanded(child: backgroundImage(1))
            ],
          );
        }
        else{
          return Stack(

            children: [
              backgroundGradient(),
              Center(child: SignUpPageBodyBuilder()),
            ],
          );
        }
      },),


    );
  }
}
