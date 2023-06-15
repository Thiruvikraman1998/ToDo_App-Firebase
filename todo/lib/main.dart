import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/auth_wraper.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/screens/auth_screens/login_screen.dart';
import 'package:todo/screens/auth_screens/sign_up_screen.dart';
import 'package:todo/screens/other_screens/home_screen.dart';
import 'package:todo/services/firebase_services.dart';

import 'screens/other_screens/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // this is for accessing all the properties and methods inside FirebaseServices class
        Provider<FirebaseServices>(
            create: (_) => FirebaseServices(
                FirebaseAuth.instance, FirebaseFirestore.instance)),

        // this is for watching and changing the screens between login and home screen according to the user state changes.
        StreamProvider(
            create: (context) => context.read<FirebaseServices>().authState,
            initialData: null),

        // creating todo provider to update the status
        ChangeNotifierProvider(create: (context) => TodoProvider())
      ],
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        home: const OnBoardingScreen(),
        routes: {
          '/auth': (context) => AuthWraper(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignUp(),
          '/home': (context) => HomeScreen(),
        },
      ),
    );
  }
}
