import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/reusable/input_action_button.dart';
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
      height: MediaQuery.of(context).size.height * 0.80,
      margin: EdgeInsets.symmetric(
        horizontal: AppLayout.getWidth(25),
        vertical: AppLayout.getHeight(5),
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
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Gap(10),
              TextInputfield(
                  maxlines: 1, height: 55, hintText: "Add Task Name..."),
            ],
          ),
          const Gap(15),
          const Text(
            "Priority",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: AppLayout.getHeight(80),
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
                        style: const TextStyle(fontSize: 20),
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
          const Gap(5),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Description",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              Gap(10),
              TextInputfield(
                maxlines: 4,
                hintText: "Add Description",
                height: 120,
              ),
            ],
          ),
          const Gap(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Date",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const Gap(10),
                  Container(
                    height: AppLayout.getHeight(55),
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColorsLight.greyColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.calendar_month_outlined),
                        const Gap(10),
                        Text(
                          "dd/mm/yyyy",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Time",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  const Gap(10),
                  Container(
                    height: AppLayout.getHeight(55),
                    width: MediaQuery.of(context).size.width * 0.42,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColorsLight.greyColor),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.access_time_outlined),
                        const Gap(10),
                        Text(
                          "hh:mm",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
          const Gap(25),
          const Row(
            children: [
              InputActionButton(
                  label: "Cancel",
                  bgColor: AppColorsLight.backgroundColor,
                  fgColor: AppColorsLight.buttonColor),
              Spacer(),
              InputActionButton(
                label: "Create",
                bgColor: AppColorsLight.buttonColor,
                fgColor: AppColorsLight.backgroundColor,
              ),
            ],
          )
        ],
      ),
    );
  }
}
