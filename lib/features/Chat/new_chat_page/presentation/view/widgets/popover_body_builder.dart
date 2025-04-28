import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tour_guide/auth_gate.dart';
import 'package:tour_guide/core/utils/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

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

                      ref.read(authServiceProvider.notifier).logOut();
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AuthGate(),));
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
        ),        Row(
          children: [
            Expanded(child: TextButton(
              onPressed: (){
                callPhoneNumber('01027520808');
                Navigator.of(context, rootNavigator: true).pop();
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

Future<void> callPhoneNumber(String phoneNumber) async {
  final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);

  print(phoneUri.toString());
  if (await canLaunchUrl(phoneUri)) {
    await launchUrl(phoneUri);
  } else {
    throw Exception('Could not launch $phoneUri');
  }
}

