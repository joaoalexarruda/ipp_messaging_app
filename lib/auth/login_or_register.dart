import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/pages/login_page.dart';
import 'package:ipp_messaging_app/pages/register_page.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  // Initially show login page
  bool showLoginPage = true;

  // Toggle between login and register pages
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        togglePage: togglePage,
      );
    } else {
      return RegisterPage(
        togglePage: togglePage,
      );
    }
  }
}
