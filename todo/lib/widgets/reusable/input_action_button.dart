import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

class InputActionButton extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color fgColor;
  final VoidCallback onPressed;
  const InputActionButton(
      {super.key,
      required this.label,
      required this.bgColor,
      required this.fgColor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final time;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: fgColor,
        backgroundColor: bgColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: AppColorsLight.buttonColor, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: Size(
          MediaQuery.of(context).size.width * 0.42,
          AppLayout.getHeight(55),
        ),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
