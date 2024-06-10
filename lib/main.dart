import 'package:flutter/material.dart';
import 'package:rive_login_animation/features/features.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rive Login Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: false),
      home: const LoginScreen(),
    );
  }
}
