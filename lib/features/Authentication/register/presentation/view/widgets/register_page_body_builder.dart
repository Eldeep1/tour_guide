
import 'package:flutter/material.dart';
import 'package:tour_guide/core/themes/darkTheme.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:tour_guide/features/Authentication/widgets/form_field_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/main_button_builder.dart';
import 'package:tour_guide/features/Authentication/widgets/text_link_widget.dart';
import 'package:tour_guide/features/Authentication/widgets/txt_header.dart';

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
      mainButtonBuilder("Sign Up",context,(){Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPageView(),));}),

    ],
  ),
);