import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:tour_guide/core/utils/services/providers/providers.dart';
import 'package:tour_guide/features/Authentication/login/presentation/view/login_page_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class MenuItems extends StatelessWidget {
  const MenuItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [


        Row(
          children: [
            Expanded(
              child: Consumer(
                builder: (context, ref, child) {
                  return TextButton(
                    onPressed: (){
                      ref.read(isLoggingOutProvider.notifier).state = true;
                      Navigator.of(context, rootNavigator: true).pop();

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPageView(),));
                      ref.read(authServiceProvider.notifier).logOut();
                      // Navigator.of(context, rootNavigator: true).pop();
                      print(ref.read(authServiceProvider));
                    }, child: Text(
                    "Logout",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                  );
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(child: TextButton(
              onPressed: ()async{
               await callPhoneNumber('01027520808',context);

               WidgetsBinding.instance.addPostFrameCallback((_) {
                 Navigator.of(context, rootNavigator: true).pop();
               });
              }, child: Text(
              "Rate The App",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            )),
          ],
        ),

      ],
    );
  }
}

Future<void> callPhoneNumber(String phoneNumber,context) async {
  // Request phone call permission
  var status = await Permission.phone.request();

  if (status.isGranted) {
    final Uri phoneUri = Uri.parse('tel:$phoneNumber');

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        // Handle case where dialer can't be launched
        throw 'Could not launch phone dialer';
      }
    } catch (e) {
      // Show user-friendly error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to make a call: $e')),
      );
    }
  } else {
    // Permission denied
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Phone call permission is required')),
    );
  }
}