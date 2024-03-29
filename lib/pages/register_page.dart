import 'package:flutter/material.dart';
import "package:ipp_messaging_app/services/auth/auth_google.dart";
import 'package:ipp_messaging_app/services/auth/auth_service.dart';
import "package:ipp_messaging_app/components/my_button.dart";
import "package:ipp_messaging_app/components/my_textfield.dart";
import "package:ipp_messaging_app/components/square_tile.dart";

class RegisterPage extends StatelessWidget {
  // name, email and password controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  final void Function()? togglePage;

  RegisterPage({super.key, required this.togglePage});

  final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$",
  );

  // register method
  void register(BuildContext context) {
    // register
    final auth = AuthService();

    // if passwords match
    if (_passwordController.text == _confirmPasswordController.text &&
        _emailController.text.isNotEmpty &&
        emailRegExp.hasMatch(_emailController.text) &&
        _passwordController.text.isNotEmpty &&
        _nameController.text.isNotEmpty) {
      try {
        auth.signUpWithEmailPassword(
          _emailController.text,
          _passwordController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            title: Center(
              child: Text(
                e.toString(),
                style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      }
    }

    // passwords do not match
    else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Center(
            child: Text(
              "Passwords do not match or fields are empty.",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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

                // some welcome text
                Text(
                  "Sign up now! Your IPP friends are waiting.",
                  style: TextStyle(
                    fontSize: 14,
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

                // email field
                MyTextField(
                  hintText: 'Name',
                  controller: _nameController,
                ),

                const SizedBox(
                  height: 10,
                ),

                // email field
                MyTextField(
                  hintText: 'Email',
                  controller: _emailController,
                ),

                const SizedBox(
                  height: 10,
                ),

                // password field
                MyTextField(
                  hintText: 'Password',
                  controller: _passwordController,
                ),

                const SizedBox(
                  height: 10,
                ),

                // confirm password field
                MyTextField(
                  hintText: 'Confirm password',
                  controller: _confirmPasswordController,
                ),

                const SizedBox(
                  height: 10,
                ),

                // login button
                MyButton(
                  text: 'Register',
                  onTap: () => register(context),
                ),

                const SizedBox(
                  height: 15,
                ),

                // Or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.5),
                        ),
                      ),
                      Text('  or continue with  ',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withOpacity(0.5),
                          )),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // google button

                SizedBox(
                  child: SquareTile(
                    onTap: () => AuthGoogle().signInWithGoogle(),
                    imagePath: 'assets/images/google_logo.png',
                  ),
                ),

                const SizedBox(
                  height: 15,
                ),

                // register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withOpacity(0.5),
                      ),
                    ),
                    GestureDetector(
                      onTap: togglePage,
                      child: Text(
                        "Login now!",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
