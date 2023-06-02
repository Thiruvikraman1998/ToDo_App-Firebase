import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  double height(double pixels) {
    double height = AppLayout.getHeight(pixels);
    return height;
  }

  double width(double pixels) {
    double width = AppLayout.getWidth(pixels);
    return width;
  }

  final TapGestureRecognizer _signUpRecognizer = TapGestureRecognizer();
  final TextEditingController _emailOrPhoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isPasswordVisible = false;
  bool isCheckBoxChecked = false;

  List socialIconsUrl = ['google.png', 'facebook.png', 'apple-logo.png'];

  @override
  void initState() {
    _signUpRecognizer.onTap = () {
      Navigator.pushNamed(context, '/signup');
      print("Sign Up clicked");
    };
    super.initState();
  }

  @override
  void dispose() {
    _emailOrPhoneController.dispose();
    _passwordController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
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
                  "Welcome Back",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Gap(10),
                Text(
                  "We are excited to have you back, can't wait to see what you've been upto since last logged in.",
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
                controller: _emailOrPhoneController,
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
            const Gap(10),
            Row(
              children: [
                Checkbox(
                  value: isCheckBoxChecked,
                  onChanged: (value) {
                    setState(() {
                      isCheckBoxChecked = value!;
                    });
                  },
                ),
                const Text(
                  "Remember me",
                  style: TextStyle(fontSize: 15),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text("Forgot password?"),
                )
              ],
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
                onPressed: () {},
                child: const Text(
                  "Login",
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
                text: 'Not a user Yet? ',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 17),
                children: [
                  TextSpan(
                      text: 'Sign up',
                      style: TextStyle(color: Colors.blue[900]),
                      recognizer: _signUpRecognizer)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
