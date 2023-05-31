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
            const Gap(50),

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
                decoration: InputDecoration(
                    hintText: "Password", border: InputBorder.none),
              ),
            ),
            const Gap(20),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                ),
                const Text(
                  "Remember me",
                  style: TextStyle(fontSize: 15),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
