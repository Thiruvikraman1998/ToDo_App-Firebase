import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final formattedDates = DateFormat('dd/MM/yyyy');

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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Title Task",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const Gap(10),
              TextInputfield(
                maxlines: 1,
                height: 55,
                hintText: "Add Task Name...",
                controller: _titleController,
              ),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Description",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              const Gap(10),
              TextInputfield(
                maxlines: 4,
                hintText: "Add Description",
                height: 120,
                controller: _descriptionController,
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
                  InkWell(
                    onTap: _openDatePicker,
                    child: Container(
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
                            _selectedDate == null
                                ? "dd/mm/yyyy"
                                : formattedDates.format(_selectedDate!),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
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
                  InkWell(
                    onTap: () => _openTimePicker(context),
                    child: Container(
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
                            _selectedTime == null
                                ? "hh:mm"
                                : _selectedTime!.format(context),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[500],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          const Gap(25),
          Row(
            children: [
              InputActionButton(
                label: "Cancel",
                bgColor: AppColorsLight.backgroundColor,
                fgColor: AppColorsLight.buttonColor,
                test: () {},
              ),
              const Spacer(),
              InputActionButton(
                label: "Create",
                bgColor: AppColorsLight.buttonColor,
                fgColor: AppColorsLight.backgroundColor,
                test: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  void _openDatePicker() async {
    final initialDate = DateTime.now();
    final firstDate =
        DateTime(initialDate.year - 1, initialDate.month, initialDate.day);
    final lastDate = DateTime(initialDate.year + 1, initialDate.month, 0);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _openTimePicker(context) async {
    final currentTime = TimeOfDay.now();
    final pickedTime =
        await showTimePicker(context: context, initialTime: currentTime);
    setState(() {
      _selectedTime = pickedTime;
    });
  }
}
