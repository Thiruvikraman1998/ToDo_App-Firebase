import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/screens/auth_screens/login_screen.dart';
import 'package:todo/screens/other_screens/home_screen.dart';

class AuthWraper extends StatelessWidget {
  const AuthWraper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<User?>();
    if (user != null) {
      return const HomeScreen();
    }
    return const LoginScreen();
  }
}
