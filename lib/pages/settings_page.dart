import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Theme.of(context).colorScheme.secondary.withOpacity(1),
        ),
        backgroundColor:
            Theme.of(context).colorScheme.tertiary.withOpacity(0.5),
        title: Text(
          'Settings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.secondary.withOpacity(1),
          ),
        ),
        centerTitle: true,
      ),
    );
  }
}
