import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            return buttonBuilder(context, function: (){
              ref.read(isLoggingOutProvider.notifier).state = true;
              Navigator.of(context, rootNavigator: true).pop();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageView(),));
              ref.read(authServiceProvider.notifier).logOut();
            }, text: "Logout");
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // Distributes elements across available space
          children: [
            SizedBox(width: 4,),
            Text('Dark Mode', style: Theme.of(context).textTheme.bodyMedium),

            Switch( // Move switch to the start
              value: true,
              onChanged: (val) {
                // ref.read(themeProvider.notifier).state = val ? AppTheme.dark : AppTheme.light;
              },
            ),
          ],
        )


        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Text('Theme'),
        //     IconButton(
        //       onPressed: () {
        //         // if (_themeProvider.currentTheme == ThemeEnum.Light) {
        //         //   _themeProvider.changeTheme(ThemeEnum.Dark);
        //         // } else {
        //         //   _themeProvider.changeTheme(ThemeEnum.Light);
        //         // }
        //       },
        //       icon: Icon(
        //           Icons.light_mode,
        //         // _themeProvider.currentTheme == ThemeEnum.Light
        //         //     ? Icons.light_mode
        //         //     : Icons.dark_mode,
        //       ),
        //     ),
        //   ],
        // ),
        // buttonBuilder(context,function: (){}, text: "rate the app"),

      ],
    );
  }
}

Widget buttonBuilder(context,{
  required void Function()? function,
  required String text,
}){
  return  Row(
    children: [
      Expanded(child: TextButton(
        onPressed: function, child: Text(
        text,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      )),
    ],
  );
}
