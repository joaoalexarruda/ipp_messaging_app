/*
  Este arquivo é responsável por direcionar o usuário para a página incial ou
  para a página de login/cadastro, dependendo se o usuário está logado ou não.
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/services/auth/login_or_register.dart';
import 'package:ipp_messaging_app/pages/home_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is logged in
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return const LoginOrRegister();
        }
      },
    ));
  }
}
