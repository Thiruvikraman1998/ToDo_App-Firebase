import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/services/firebase_services.dart';

import '../../utils/app_layout.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  double height(double pixels) {
    double height = AppLayout.getHeight(pixels);
    return height;
  }

  double width(double pixels) {
    double width = AppLayout.getWidth(pixels);
    return width;
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TapGestureRecognizer _loginRecognizer = TapGestureRecognizer();

  bool isPasswordVisible = false;

  List socialIconsUrl = ['google.png', 'facebook.png', 'apple-logo.png'];

  @override
  void initState() {
    _loginRecognizer.onTap = () {
      Navigator.pushNamed(context, '/login');
      print("Login tapped");
    };
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  void signUpUser() async {
    await FirebaseServices(FirebaseAuth.instance, FirebaseFirestore.instance)
        .signUpWithEmail(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            phoneNumber: _phoneNumberController.text.trim(),
            context: context);
  }

  @override
  Widget build(BuildContext context) {
    final size = AppLayout.getsize(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.only(
            top: height(80),
            bottom: height(30),
            right: width(20),
            left: width(20)),
        child: Column(
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Create Account",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Text(
                  "Sign up and start exploring all that our app has to offer. We are excited to have you!",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
            const Gap(40),

            //Email / ph no
            Container(
              padding: EdgeInsets.only(left: width(20)),
              height: height(50),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(height(25))),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    hintText: "Email or Phone Number",
                    border: InputBorder.none),
              ),
            ),
            const Gap(20),

            // password
            Container(
              padding: EdgeInsets.only(left: width(20)),
              height: height(50),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(
                  height(25),
                ),
              ),
              child: TextField(
                controller: _passwordController,
                obscureText: isPasswordVisible ? false : true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isPasswordVisible = !isPasswordVisible;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye_outlined),
                    ),
                    suffixIconColor: Colors.grey),
              ),
            ),
            const Gap(20),

            // Phone number
            Container(
              padding: EdgeInsets.only(left: width(20)),
              height: height(50),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(height(25))),
              child: TextField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                    hintText: "Phone Number", border: InputBorder.none),
              ),
            ),
            const Gap(40),

            // Login button
            SizedBox(
              height: height(55),
              width: width(250),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                onPressed: signUpUser,
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const Gap(60),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey[400], thickness: 2),
                ),
                const Gap(5),
                const Text("Or Sign in with"),
                const Gap(5),
                Expanded(
                  child: Divider(color: Colors.grey[400], thickness: 2),
                ),
              ],
            ),
            const Gap(50),

            // Social media login's
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (var url in socialIconsUrl)
                  GestureDetector(
                    onTap: () {
                      print('$url is tapped');
                    },
                    child: Container(
                      height: height(44),
                      width: size.width * 0.1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/$url'),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const Gap(90),

            // Already a user...?
            RichText(
              text: TextSpan(
                text: 'Already a user? click to ',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
                children: [
                  TextSpan(
                      text: 'Log in',
                      style: TextStyle(color: Colors.blue[900]),
                      recognizer: _loginRecognizer)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
