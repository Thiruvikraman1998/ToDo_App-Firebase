import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

void showOtpDialog(
    {required context,
    required TextEditingController codeController,
    required VoidCallback onPressed}) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Enter otp"),
        content: Column(
          children: [
            Pinput(
              controller: codeController,
              length: 4,
            )
          ],
        ),
        actions: [TextButton(onPressed: onPressed, child: const Text("Done"))],
      );
    },
  );
}
