import 'package:flutter/material.dart';
import 'package:todo/screens/auth_screens/login_screen.dart';

import 'screens/other_screens/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      routes: {
        '/': (context) => OnBoardingScreen(),
        '/login': (context) => LoginScreen()
      },
    );
  }
}
