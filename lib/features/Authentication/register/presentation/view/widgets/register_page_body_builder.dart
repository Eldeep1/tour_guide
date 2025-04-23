
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Authentication/register/data/models/register_request.dart';
import 'package:tour_guide/features/Authentication/register/presentation/providers/register_form_provider.dart';
import 'package:tour_guide/features/Authentication/register/presentation/providers/register_page_provider.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/text_link_widget.dart';
import 'package:tour_guide/features/Authentication/widgets/txt_header.dart';

class SignUpPageBodyBuilder extends ConsumerWidget {
  final double itemsWidth;
  const SignUpPageBodyBuilder({super.key,required this.itemsWidth});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController=ref.read(registerFormProvider.notifier).nameController;
    final emailController=ref.read(registerFormProvider.notifier).emailController;
    final passwordController=ref.read(registerFormProvider.notifier).passwordController;
    return Padding(
      padding: const EdgeInsets.all(screenPadding),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            txtHeader(context,"Sign up","Create a new account"),


            formFieldBuilder(label: "Name",width: itemsWidth,textEditingController: nameController),
            formFieldBuilder(label: "Email",width: itemsWidth,textEditingController: emailController),
            // formFieldBuilder(label: "Phone",width: itemsWidth),
            formFieldBuilder(label: "password",width: itemsWidth,textEditingController:passwordController),

            Row(
              children: [
                Checkbox(value:true , onChanged: (value){}),
                textLinkWidget("I agree the ", "Terms and Conditions", (){}, context),
              ],
            ),
            // there's a technical dept here as the button code is written two times and the loading, error is the same as the one on the login form
            ref.watch(registerPageProvider).when(
                data: (data) {
                  if(data.data!=null){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageView(),));
                  }
                return  mainButtonBuilder("Sign Up",
                    context,
                        (){
                      final name = nameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      ref.read(registerPageProvider.notifier).register(registerRequest: RegisterRequest(name, email, password));
                    }
                );
                },
                error: (error, stackTrace) {
                  return  Column(
                    children: [
                      mainButtonBuilder("Sign Up",
                          context,
                              (){
                            final name = nameController.text;
                            final email = emailController.text;
                            final password = passwordController.text;
                            ref.read(registerPageProvider.notifier).register(registerRequest: RegisterRequest(name, email, password));
                          }
                      ),
                      const SizedBox(height: 8),
                      Text(error.toString(), style: const TextStyle(color: Colors.red)),
                    ],
                  );
                },
                loading: () => Shimmer.fromColors(
                  baseColor: Colors.grey,
                  highlightColor: Colors.amber,
                  child: const CircularProgressIndicator(),
                ),
            ),

          ],
        ),
      ),
    );
  }

}
