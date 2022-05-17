import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/services.dart';
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
  bool usernameError = false;
  String passErrorText = "Senha Incorreta!";
  String emailErrorText = "";
  String confirmPasswordErrorText = "Senhas não conferem!";
  String firstNameErrorText = "Campo obrigatório!";
  String lastNameErrorText = "Campo obrigatório!";
  String usernameErrorText = "Campo obrigatório!";
  String email = '';
  String password = '';
  String confirmPassword = '';
  String firstName = '';
  String lastName = '';
  String username = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 48,
                ),
                Text(
                  "Register",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  "to sign up, please inform an email and a password",
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 24,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" ")),
                  ],
                  hint: 'Please type your email',
                  label: 'Email',
                  onChanged: (text) {
                    email = text;
                    emailError = false;
                  },
                  errorText: emailErrorText,
                  showErrorText: emailError,
                  obscureText: false,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" ")),
                  ],
                  maxLength: 20,
                  hint: 'Please type your password',
                  label: 'Password',
                  obscureText: true,
                  onChanged: (text) {
                    password = text;
                    passError = false;
                  },
                  errorText: passErrorText,
                  showErrorText: passError,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(" ")),
                  ],
                  maxLength: 20,
                  hint: 'Please confirmn your password',
                  label: 'Confirm Password',
                  obscureText: true,
                  onChanged: (text) {
                    confirmPassword = text;
                    confirmPasswordError = false;
                  },
                  errorText: confirmPasswordErrorText,
                  showErrorText: confirmPasswordError,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  maxLength: 15,
                  hint: 'Please type your first name',
                  label: 'First Name',
                  obscureText: false,
                  onChanged: (text) {
                    firstName = text;
                    firstNameError = false;
                  },
                  errorText: firstNameErrorText,
                  showErrorText: firstNameError,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  ],
                  maxLength: 15,
                  hint: 'Please type your last name',
                  label: 'Last Name',
                  obscureText: false,
                  onChanged: (text) {
                    lastName = text;
                    lastNameError = false;
                  },
                  errorText: lastNameErrorText,
                  showErrorText: lastNameError,
                ),
                MyTextFieldWidget(
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp("[a-z0-9]")),
                  ],
                  maxLength: 20,
                  hint: 'Please type your @username',
                  label: '@username',
                  obscureText: false,
                  onChanged: (text) {
                    username = text;
                    usernameError = false;
                  },
                  errorText: usernameErrorText,
                  showErrorText: usernameError,
                ),
                const SizedBox(
                  height: 24,
                ),
                MyElevatedButtonWidget(
                  title: 'Sign in',
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
                    if (username.isEmpty || username == "") {
                      usernameError = true;
                      setState(() {});
                    }
                    if (password == confirmPassword) {
                      if (isValid == true &&
                          emailError == false &&
                          passError == false &&
                          confirmPasswordError == false &&
                          firstNameError == false &&
                          lastNameError == false &&
                          usernameError == false) {
                        try {
                          final currentUser = await postMyRegister(
                            UserModel(
                              firstName: firstName,
                              lastName: lastName,
                              email: email,
                              password: password,
                              username: username,
                            ),
                          );
                          if (currentUser.hasError) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Email has already been used"),
                              ),
                            );
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MyLoginPage(),
                              ),
                            );
                          }
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
      ),
    );
  }
}
