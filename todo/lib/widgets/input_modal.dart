import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/reusable/input_action_button.dart';
import 'package:todo/widgets/reusable/textfield.dart';

import '../models/todo.dart';

class TaskInputModal extends StatefulWidget {
  final void Function(Todo todo) saveTodo;
  const TaskInputModal({super.key, required this.saveTodo});

  @override
  State<TaskInputModal> createState() => _TaskInputModalState();
}

class _TaskInputModalState extends State<TaskInputModal> {
  Priorities _selectedPriority = Priorities.high;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final formattedDates = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

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
                ChoiceChip(
                  //labelPadding: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getHeight(10),
                      horizontal: AppLayout.getWidth(15)),
                  label: const Text(
                    "High",
                    style: TextStyle(fontSize: 20),
                  ),
                  selected: _selectedPriority == Priorities.high,
                  selectedColor: AppColorsLight.buttonColor,
                  onSelected: (selected) {
                    _handleSelectedPriority(Priorities.high);
                  },
                ),
                ChoiceChip(
                  //labelPadding: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getHeight(10),
                      horizontal: AppLayout.getWidth(15)),
                  label: const Text(
                    "Medium",
                    style: TextStyle(fontSize: 20),
                  ),
                  selected: _selectedPriority == Priorities.medium,
                  selectedColor: AppColorsLight.buttonColor,
                  onSelected: (selected) {
                    _handleSelectedPriority(Priorities.medium);
                  },
                ),
                ChoiceChip(
                  //labelPadding: EdgeInsets.all(10),
                  padding: EdgeInsets.symmetric(
                      vertical: AppLayout.getHeight(10),
                      horizontal: AppLayout.getWidth(15)),
                  label: const Text(
                    "Low",
                    style: TextStyle(fontSize: 20),
                  ),
                  selected: _selectedPriority == Priorities.low,
                  selectedColor: AppColorsLight.buttonColor,
                  onSelected: (selected) {
                    _handleSelectedPriority(Priorities.low);
                  },
                ),
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
                test: _validateSubmission,
              ),
            ],
          )
        ],
      ),
    );
  }

  void _handleSelectedPriority(Priorities priorities) {
    setState(() {
      _selectedPriority = priorities;
    });
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

  void _validateSubmission() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null ||
        _selectedTime == null) {
      showDialog(
        context: context,
        builder: (dialogBoxContext) {
          return AlertDialog(
            title: const Text("Invalid Inputs"),
            content: _titleController.text.isEmpty
                ? const Text("Title is empty, enter a title")
                : _descriptionController.text.isEmpty
                    ? const Text("Description is Empty")
                    : _selectedDate == null
                        ? const Text("Date is not selected, select a date")
                        : _selectedTime == null
                            ? const Text("Time is not selected, select a time")
                            : null,
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogBoxContext);
                },
                child: const Text('Okay'),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.saveTodo(
      Todo(_titleController.text, _descriptionController.text, _selectedDate,
          _selectedTime, _selectedPriority.toString(), false),
    );
    setState(() {
      _titleController.text = '';
      _descriptionController.text = '';
      _selectedDate = null;
      _selectedTime = null;
    });
    Navigator.pop(context);
  }
}
