import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/services/firebase_services.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/utils/snackbar.dart';
import 'package:todo/widgets/reusable/input_action_button.dart';
import 'package:todo/widgets/reusable/textfield.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';

class TaskInputModal extends StatefulWidget {
  const TaskInputModal({super.key});

  @override
  State<TaskInputModal> createState() => _TaskInputModalState();
}

class _TaskInputModalState extends State<TaskInputModal> {
  Priorities _selectedPriority = Priorities.high;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _convertedSelectedTime;
  final formattedDates = DateFormat('dd/MM/yyyy');

  // creating unique ids for each task's
  static const Uuid uuid = Uuid();
  final taskId = uuid.v4();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = context.watch<TodoProvider>();
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
                onPressed: () {},
              ),
              const Spacer(),
              InputActionButton(
                label: "Create",
                bgColor: AppColorsLight.buttonColor,
                fgColor: AppColorsLight.backgroundColor,
                onPressed: () {
                  todoProvider.validateAndCreateTask(
                      context,
                      taskId,
                      _titleController.text.trim(),
                      _descriptionController.text.trim(),
                      _selectedDate,
                      _convertedSelectedTime,
                      _selectedPriority.toString(),
                      false);
                  Navigator.pop(context);
                },
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
    print(pickedTime);
    setState(() {
      _selectedTime = pickedTime;
      _convertedSelectedTime = _converTimeOFDayToDateTime(pickedTime!);
    });
  }

  DateTime _converTimeOFDayToDateTime(TimeOfDay time) {
    return DateTime(time.hour, time.minute);
  }

  // void _validateSubmission() async {
  //   if (_titleController.text.isEmpty ||
  //       _descriptionController.text.isEmpty ||
  //       _selectedDate == null ||
  //       _selectedTime == null) {
  //     showDialog(
  //       context: context,
  //       builder: (dialogBoxContext) {
  //         return AlertDialog(
  //           title: const Text("Invalid Inputs"),
  //           content: _titleController.text.isEmpty
  //               ? const Text("Title is empty, enter a title")
  //               : _descriptionController.text.isEmpty
  //                   ? const Text("Description is Empty")
  //                   : _selectedDate == null
  //                       ? const Text("Date is not selected, select a date")
  //                       : _selectedTime == null
  //                           ? const Text("Time is not selected, select a time")
  //                           : null,
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(dialogBoxContext);
  //               },
  //               child: const Text('Okay'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     return;
  //   }
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   final user = auth.currentUser;
  //   String uid = user!.uid;

  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('user')
  //         .doc(uid)
  //         .collection("task")
  //         .doc(taskId)
  //         .set(Todo(
  //                 taskId,
  //                 _titleController.text.trim(),
  //                 _descriptionController.text.trim(),
  //                 _selectedDate,
  //                 _convertedSelectedTime,
  //                 _selectedPriority.toString(),
  //                 false)
  //             .toMap());
  //   } catch (e) {
  //     showSnackBar(context, e.toString());
  //   }
  //   debugPrint(
  //       "${_selectedDate!.toIso8601String()}, ${_selectedTime.toString()}, ${_selectedPriority.toString()}");
  //   setState(() {
  //     _titleController.text = '';
  //     _descriptionController.text = '';
  //     _selectedDate = null;
  //     _selectedTime = null;
  //   });
  //   Navigator.pop(context);
  // }
}
