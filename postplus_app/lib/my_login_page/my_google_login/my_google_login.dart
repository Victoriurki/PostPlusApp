import 'package:flutter/material.dart';
import 'package:postplus_app/my_home_page/my_home_page.dart';
import 'package:postplus_app/my_login_page/my_google_login/my_google_login_controller.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
            primary: Colors.white,
            onPrimary: Colors.black,
            minimumSize: const Size(double.infinity, 50),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
        icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
        label: const Text(
          'Sign Up with Google',
        ),
        onPressed: () async {
          final result = await GoogleSignInController().googleLogin();

          if (result == false) {
            showDialog(
                context: context,
                builder: (context) {
                  return const Dialog(
                    child: Text('Por favor clicar no local indicado'),
                  );
                });
          }
          if (result == true) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MyHomePage(),
              ),
            );
          }
        },
      ),
    );
  }
}
