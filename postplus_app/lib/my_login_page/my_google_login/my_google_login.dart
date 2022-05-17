import 'package:flutter/material.dart';
import 'package:postplus_app/get_current_user_info/get_current_user_info.dart';
import 'package:postplus_app/my_home_page/my_home_page.dart';
import 'package:postplus_app/my_login_page/my_google_login/my_google_login_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40, right: 40),
      child: InkWell(
        onTap: () async {
          final result = await GoogleSignInController().googleLogin();
          if (result == "") {
            showDialog(
                context: context,
                builder: (context) {
                  return const Dialog(
                    child: Text('Por favor clicar no local indicado'),
                  );
                });
          }
          if (result != "") {
            var resultModel = await getCurrentUserModel(result);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(currentUserModel: resultModel),
              ),
            );
          }
        },
        child: ClipOval(
          child: Container(
              width: 60,
              height: 60,
              color: const Color(0xFF4285F4),
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.google,
                  color: Colors.white,
                  size: 40,
                ),
              )),
        ),
      ),
    );
  }
}
