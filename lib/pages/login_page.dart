import "package:flutter/material.dart";
import "package:ipp_messaging_app/auth/auth_service.dart";
import "package:ipp_messaging_app/components/my_button.dart";
import "package:ipp_messaging_app/components/my_textfield.dart";

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
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
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
                    size: 50, color: Theme.of(context).colorScheme.primary),
              ],
            ),

            const SizedBox(
              height: 5,
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

            const SizedBox(
              height: 10,
            ),

            // login button
            MyButton(
              text: 'Login',
              onTap: () => login(context),
            ),

            const SizedBox(
              height: 10,
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
    );
  }
}
