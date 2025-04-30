import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/register/presentation/view/register_page_view.dart';
import 'package:tour_guide/features/Authentication/widgets/text_link_widget.dart';
import 'package:tour_guide/features/Authentication/widgets/txt_header.dart';
import 'login_form.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txtHeader(context, "Sign in", "Log in to your account"),
              const SizedBox(height: 12),
              LoginForm(),
              textLinkWidget(
                "New Tourist?",
                " Create New Account",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                context,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

