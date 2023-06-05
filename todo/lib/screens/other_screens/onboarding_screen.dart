import 'package:flutter/material.dart';
import 'package:todo/auth_wraper.dart';
import 'package:todo/utils/app_layout.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: AppLayout.getHeight(180)),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "Manage all you TODO's",
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: AppLayout.getHeight(50)),
        child: FloatingActionButton.extended(
          extendedPadding:
              EdgeInsets.symmetric(horizontal: AppLayout.getWidth(120)),
          onPressed: () {
            Navigator.popAndPushNamed(context, '/auth');
          },
          label: const Text(
            "Get Started",
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
