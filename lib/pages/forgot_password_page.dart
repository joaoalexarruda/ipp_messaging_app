// Página de recuperação de senha

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/components/my_button.dart';
import 'package:ipp_messaging_app/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      showErrorMessage('Password reset link sent to your email');
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  // Function created to show error messages
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Center(
            child: Text(
              message,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1),
        ),
        toolbarHeight: 50,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 25,
                ),

                // IPP Logo and messaging icon
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage("assets/images/ipp_logo.png"),
                      height: 50,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Icon(
                      Icons.message,
                      size: 50,
                      color: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(1),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                Text(
                  'Enter your email address to reset your password',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(0.5),
                  ),
                ),

                const SizedBox(
                  height: 25,
                ),

                // Email textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                ),

                const SizedBox(
                  height: 10,
                ),

                // Reset button
                MyButton(
                  text: 'Send Reset Link',
                  onTap: resetPassword,
                ),

                const SizedBox(
                  height: 25,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
