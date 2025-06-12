import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/validators/validators.dart';
import 'package:tour_guide/features/authentication/login/data/models/login_request.dart';
import 'package:tour_guide/features/authentication/login/presentation/providers/login_page_provider.dart';
import 'package:tour_guide/features/authentication/login/presentation/view/widgets/login_button_builder.dart';
import 'package:tour_guide/features/authentication/widgets/form_field_builder.dart';

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
                validator: Validators.validateEmail,
                focusNode: _emailFocusNode,
                onFieldSubmitted: (p0) => _passwordFocusNode.requestFocus(),
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
                validator: Validators.validatePassword,
                focusNode: _passwordFocusNode,
                onFieldSubmitted: (p0) {
                  _passwordFocusNode.unfocus();
                  if(_formKey.currentState!.validate()){
                    ref.read(loginPageProvider.notifier).login(
                      loginRequest: LoginRequest(
                        _emailController.text,
                        _passwordController.text,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        LoginButtonBuilder(formKey: _formKey, emailController: _emailController, passwordController: _passwordController,emailFocusNode: _emailFocusNode,passwordFocusNode: _passwordFocusNode,),
      ],
    );
  }
}