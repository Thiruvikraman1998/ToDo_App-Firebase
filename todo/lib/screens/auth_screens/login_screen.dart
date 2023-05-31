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
              child: const TextField(
                decoration: InputDecoration(
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
                  borderRadius: BorderRadius.circular(height(25))),
              child: const TextField(
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    border: InputBorder.none,
                    suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    suffixIconColor: Colors.grey),
              ),
            ),
            const Gap(10),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: height(40),
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/google.png'),
                    ),
                  ),
                ),
                Container(
                  height: height(40),
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/facebook.png'),
                    ),
                  ),
                ),
                Container(
                  height: height(40),
                  width: size.width * 0.1,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/images/apple-logo.png'),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
