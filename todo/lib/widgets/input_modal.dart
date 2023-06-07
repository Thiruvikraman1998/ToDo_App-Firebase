import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/reusable/textfield.dart';

class TaskInputModal extends StatefulWidget {
  const TaskInputModal({super.key});

  @override
  State<TaskInputModal> createState() => _TaskInputModalState();
}

class _TaskInputModalState extends State<TaskInputModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(25),
        vertical: AppLayout.getHeight(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Column(
            children: [
              Text(
                "New Task ToDo",
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w700),
              ),
              Gap(10),
              Divider(),
            ],
          ),
          const Gap(15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Gap(10),
              TextInputfield(),
            ],
          ),
          const Gap(15),
          Row(
            children: [],
          ),
          const Gap(15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title Task",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              Gap(10),
              TextInputfield(),
            ],
          )
        ],
      ),
    );
  }
}
