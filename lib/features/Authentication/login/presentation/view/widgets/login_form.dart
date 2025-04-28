import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/features/Authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/Authentication/login/presentation/providers/login_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';

/// Use ConsumerStatefulWidget & ConsumerState
class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Track password visibility
  bool _passwordVisible = false;

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUnfocus,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              formFieldBuilder(
                textEditingController: _emailController,
                label: 'Email',
                prefixIcon: Icons.email_outlined,
                keyBoardType: TextInputType.emailAddress,
                validator: validateEmail,
                focusNode: _emailFocusNode,
              ),
              formFieldBuilder(
                textEditingController: _passwordController,
                label: "Password",
                obscureText: !_passwordVisible,
                suffixIconClick: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                suffixIcon: Icons.remove_red_eye_outlined,
                validator: validatePassword,
                focusNode: _passwordFocusNode,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        // Move the button builder here directly
        loginProvider.when(
          data: (_) => mainButtonBuilder(
            "Sign in",
            context,
                () {
                  if(_formKey.currentState!.validate()){
                    loginProviderData.login(
                      loginRequest: LoginRequest(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  }
            },
          ),
          loading: () => Center(
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.amber,
              child: const CircularProgressIndicator(),
            ),
          ),
          error: (error, _) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              mainButtonBuilder(
                "Sign in",
                context,
                    () {
                  if(_formKey.currentState!.validate()){
                    loginProviderData.login(
                      loginRequest: LoginRequest(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  }

                },
              ),
              const SizedBox(height: 8),
              Text(error.toString(), style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
    );
  }
}
Widget loginButton(TextEditingController emailController, TextEditingController passwordController) {

  return Consumer(builder: (context, ref, child) {
    final loginProvider = ref.watch(loginPageProvider);
    final loginProviderData = ref.read(loginPageProvider.notifier);
    return loginProvider.when(
      data: (_) => mainButtonBuilder(
        "Sign in",
        context,
            () {
              print(emailController.text);
              print(passwordController.text);
              print("alooooooo");
          loginProviderData.login(
            loginRequest: LoginRequest(
              emailController.text,
              passwordController.text,
            ),
          );
        },
      ),
      loading: () => Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.amber,
        child: const CircularProgressIndicator(),
      ),
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          mainButtonBuilder("Sign in", context, () {
            print(emailController.text);
            print(passwordController.text);
            print("alooooooo");
            loginProviderData.login(
              loginRequest: LoginRequest(
                emailController.text,
                passwordController.text,
              ),
            );
          }),
          const SizedBox(height: 8),
          Text(error.toString(), style: const TextStyle(color: Colors.red)),
        ],
      ),
    );
  },);

}



// Validation function for email
String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email is required';
  }
  final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zAORB0-9.-]+\.[a-zA-Z]{2,}$');
  if (!emailRegex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

// Validation function for password
String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 6) {
    return 'Password must be at least 6 characters';
  }
  return null;
}
