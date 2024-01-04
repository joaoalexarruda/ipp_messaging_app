import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary.withOpacity(0.1),
        title: Text(
          'IPP Messaging App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).colorScheme.inversePrimary.withOpacity(0.5),
          ),
        ),
        centerTitle: true,
      ),
      drawer: const MyDrawer(),
    );
  }
}
