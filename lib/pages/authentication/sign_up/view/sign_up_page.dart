import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/pages/authentication/login_page/view/login_page_view.dart';
import 'package:tour_guide/services/components/constants/constants.dart';
import 'package:tour_guide/services/components/themes/light_theme.dart';

import '../../shared/components/shared_Auth_UI.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

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
  Widget signUpPageBodyBuilder(context, itemsWidth)=>Padding(
    padding: const EdgeInsets.all(screenPadding),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        txtHeader(context,"Sign up","Create a new account"),


        formFieldBuilder("Name",width: itemsWidth),
        formFieldBuilder("Email",width: itemsWidth),
        formFieldBuilder("Phone",width: itemsWidth),
        formFieldBuilder("password",width: itemsWidth),

        Row(
          children: [
            Checkbox(value:true , onChanged: (value){}),
            textLinkWidget("I agree the ", "Terms and Conditions", (){}, context),
          ],
        ),
        signButtonBuilder("Sign Up",context,(){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageView(),));}),

      ],
    ),
  );
}
