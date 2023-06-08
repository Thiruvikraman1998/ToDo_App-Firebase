import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

class TextInputfield extends StatefulWidget {
  final int maxlines;
  final double height;
  final String hintText;
  final TextEditingController controller;
  const TextInputfield(
      {super.key,
      required this.maxlines,
      required this.height,
      required this.hintText,
      required this.controller});

  @override
  State<TextInputfield> createState() => _TextInputfieldState();
}

class _TextInputfieldState extends State<TextInputfield> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: AppLayout.getHeight(5), horizontal: AppLayout.getWidth(20)),
      height: AppLayout.getHeight(widget.height),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColorsLight.greyColor),
      child: TextField(
        controller: widget.controller,
        maxLines: widget.maxlines,
        decoration: InputDecoration(
            hintText: widget.hintText, border: InputBorder.none),
      ),
    );
  }
}
