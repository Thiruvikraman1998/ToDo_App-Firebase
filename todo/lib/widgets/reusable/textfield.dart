import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

class TextInputfield extends StatefulWidget {
  final int maxlines;
  const TextInputfield({super.key, required this.maxlines});

  @override
  State<TextInputfield> createState() => _TextInputfieldState();
}

class _TextInputfieldState extends State<TextInputfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(5), horizontal: AppLayout.getWidth(20)),
      height: AppLayout.getHeight(55),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColorsLight.greyColor),
      child: const TextField(
        maxLines: 1,
        decoration: InputDecoration(
            hintText: "Add Task Name..", border: InputBorder.none),
      ),
    );
  }
}
