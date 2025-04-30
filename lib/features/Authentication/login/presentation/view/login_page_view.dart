import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'widgets/login_page_body.dart';

class LoginPageView extends ConsumerWidget {
  const LoginPageView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print("we have opened the page");
    return Scaffold(
      body: Stack(
        children: [
          // backgroundImage(.5),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xff000412), Color(0xff070E26), Colors.deepPurple,],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),),
          LoginPageBody(),
        ],
      )
    );
  }
}
