import "package:flutter/material.dart";
import "package:ipp_messaging_app/services/auth/auth_google.dart";
import 'package:ipp_messaging_app/services/auth/auth_service.dart';
import "package:ipp_messaging_app/components/my_button.dart";
import "package:ipp_messaging_app/components/my_textfield.dart";
import "package:ipp_messaging_app/components/square_tile.dart";
import "package:ipp_messaging_app/pages/forgot_password_page.dart";

class LoginPage extends StatelessWidget {
  // email and password controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // tap handler
  final void Function()? togglePage;

  LoginPage({super.key, required this.togglePage});

  // loggin method
  void login(BuildContext context) async {
    // auth service
    final authService = AuthService();

    // try to login
    try {
      await authService.signInWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          title: Text(
            e.toString(),
            style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold),
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
                    Icon(Icons.message,
                        size: 50,
                        color: Theme.of(context)
                            .colorScheme
                            .inversePrimary
                            .withOpacity(1)),
                  ],
                ),

                const SizedBox(
                  height: 25,
                ),

                // some welcome text
                Text(
                  "A place to chat with your IPP friends",
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

                // Forgot password?
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ForgotPasswordPage();
                              },
                            ),
                          );
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                // login button
                MyButton(
                  text: 'Login',
                  onTap: () => login(context),
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
                      "Don't have an account? ",
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
                        "Register now!",
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
