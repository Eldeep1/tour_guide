import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/themes/dark_theme.dart';
import 'widgets/login_page_body.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          // backgroundImage(.5),
          backgroundGradient(),
          LoginPageBody(),
        ],
      )
    );
  }
}
