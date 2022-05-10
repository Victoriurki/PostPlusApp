import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:postplus_app/my_login_page/my_login_page.dart';
import 'package:postplus_app/post_my_register/post_my_register.dart';
import 'package:postplus_app/user_model/user_model.dart';
import '../my_widgets/my_elevated_button_widget.dart';
import '../my_widgets/my_textfield_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyRegisterPage extends StatefulWidget {
  const MyRegisterPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyRegisterPage> createState() => _MyRegisterPageState();
}

class _MyRegisterPageState extends State<MyRegisterPage> {
  bool _emailValidator(String email) {
    return EmailValidator.validate(email);
  }

  bool emailError = false;
  bool passError = false;
  bool confirmPasswordError = false;
  bool firstNameError = false;
  bool lastNameError = false;
  String passErrorText = "Senha Incorreta!";
  String emailErrorText = "";
  String confirmPasswordErrorText = "Senhas não conferem!";
  String firstNameErrorText = "Campo obrigatório!";
  String lastNameErrorText = "Campo obrigatório!";
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              MyTextFieldWidget(
                hint: 'Please type your email',
                label: 'Email',
                onChanged: (text) {
                  email = text;
                },
                errorText: emailErrorText,
                showErrorText: emailError,
                obscureText: false,
              ),
              MyTextFieldWidget(
                hint: 'Please type your password',
                label: 'Password',
                obscureText: true,
                onChanged: (text) {
                  password = text;
                },
                errorText: passErrorText,
                showErrorText: passError,
              ),
              MyTextFieldWidget(
                hint: 'Please confirmn your password',
                label: 'Confirm Password',
                obscureText: true,
                onChanged: (text) {
                  confirmPassword = text;
                },
                errorText: confirmPasswordErrorText,
                showErrorText: confirmPasswordError,
              ),
              MyTextFieldWidget(
                hint: 'Please type your first name',
                label: 'First Name',
                obscureText: false,
                onChanged: (text) {
                  firstName = text;
                },
                errorText: firstNameErrorText,
                showErrorText: firstNameError,
              ),
              MyTextFieldWidget(
                hint: 'Please type your last name',
                label: 'Last Name',
                obscureText: false,
                onChanged: (text) {
                  lastName = text;
                },
                errorText: lastNameErrorText,
                showErrorText: lastNameError,
              ),
              MyElevatedButtonWidget(
                title: 'Sing in',
                action: () async {
                  bool isValid = _emailValidator(email);
                  if (email.isEmpty || email == "") {
                    emailError = true;
                    emailErrorText = "Campo obrigatório!";
                    setState(() {});
                  } else if (isValid == false) {
                    emailError = true;
                    emailErrorText = "Digite um email válido!";
                    setState(() {});
                  }
                  if (password.isEmpty || password == "") {
                    passError = true;
                    setState(() {});
                  }
                  if (confirmPassword.isEmpty || confirmPassword == "") {
                    confirmPasswordError = true;
                    setState(() {});
                  }
                  if (firstName.isEmpty || firstName == "") {
                    firstNameError = true;
                    setState(() {});
                  }
                  if (lastName.isEmpty || lastName == "") {
                    lastNameError = true;
                    setState(() {});
                  }
                  if (password == confirmPassword) {
                    if (isValid == true &&
                        emailError == false &&
                        passError == false &&
                        confirmPasswordError == false &&
                        firstNameError == false &&
                        lastNameError == false) {
                      try {
                        postMyRegister(
                          UserModel(
                            firstName: firstName,
                            lastName: lastName,
                            email: email,
                            password: password,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyLoginPage(title: '',),
                          ),
                        );
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          passError = true;
                          passErrorText = "Senha fraca!";
                          setState(() {});
                        } else if (e.code == 'email-already-in-use') {
                          emailError = true;
                          emailErrorText = "Email já está em uso!";
                          setState(() {});
                        }
                      }
                    }
                  } else {
                    confirmPasswordError = true;
                    setState(() {});
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
