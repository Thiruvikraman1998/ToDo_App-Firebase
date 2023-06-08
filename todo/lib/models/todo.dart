import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currentTime = DateTime.now();
final formattedTime = DateFormat('HH:mm').format(currentTime);

final formattedDate = DateFormat.yMd();

enum Priorities { high, medium, low }

class Todo {
  String? title;
  String? description;
  DateTime? date;
  TimeOfDay? time;
  int? priority;
  bool? isCompleted;

  Todo(this.title, this.description, this.date, this.time, this.priority,
      this.isCompleted);
}
