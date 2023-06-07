import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/reusable/textfield.dart';

class TaskInputModal extends StatefulWidget {
  const TaskInputModal({super.key});

  @override
  State<TaskInputModal> createState() => _TaskInputModalState();
}

class _TaskInputModalState extends State<TaskInputModal> {
  final List priorities = ["High", "Medium", "Low"];
  int _choideIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
              TextInputfield(maxlines: 1),
            ],
          ),
          const Gap(15),
          const Text(
            "Priority",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
          Container(
            height: AppLayout.getHeight(90),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ...priorities.map(
                  (priority) {
                    int index = priorities.indexOf(priority);
                    return ChoiceChip(
                      //labelPadding: EdgeInsets.all(10),
                      padding: EdgeInsets.symmetric(
                          vertical: AppLayout.getHeight(10),
                          horizontal: AppLayout.getWidth(15)),
                      label: Text(
                        priority,
                        style: TextStyle(fontSize: 20),
                      ),
                      selected: _choideIndex == index,
                      selectedColor: AppColorsLight.buttonColor,
                      onSelected: (selected) {
                        setState(() {
                          _choideIndex = selected ? index : 0;
                        });
                      },
                    );
                  },
                )
              ],
            ),
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
              TextInputfield(maxlines: 4),
            ],
          )
        ],
      ),
    );
  }
}
