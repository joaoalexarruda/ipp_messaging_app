import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ipp_messaging_app/services/auth/auth_gate.dart';
import 'package:ipp_messaging_app/firebase_options.dart';
import 'package:ipp_messaging_app/themes/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: darkMode,
    );
  }
}
