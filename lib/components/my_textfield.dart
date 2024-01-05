import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const MyTextField(
      {super.key, required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: TextField(
        obscureText: hintText == 'Password' || hintText == 'Confirm password'
            ? true
            : false,
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color:
                  Theme.of(context).colorScheme.inversePrimary.withOpacity(1),
            ),
          ),
          fillColor: Theme.of(context).colorScheme.secondary.withOpacity(0.3),
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(
            color:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.2),
          ),
        ),
      ),
    );
  }
}
