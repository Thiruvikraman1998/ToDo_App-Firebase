import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final currentTime = DateTime.now();
final formattedTime = DateFormat('HH:mm').format(currentTime);

final formattedDate = DateFormat.yMd();

enum Priorities { high, medium, low }

class Todo {
  String? id;
  String? title;
  String? description;
  DateTime? date;
  DateTime? time;
  String? priority;
  bool? isCompleted;

  Todo(this.title, this.description, this.date, this.time, this.priority,
      this.isCompleted);

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;
    map['date'] = date;
    map['time'] = time;
    if (priority == Priorities.high.toString()) {
      map['priority'] = 1;
    } else if (priority == Priorities.medium.toString()) {
      map['priority'] = 2;
    } else {
      map['priority'] = 3;
    }
    map['isCompleted'] = isCompleted;
    return map;
  }

  Todo.fromMap(Map<String, dynamic> map, String id) {
    id = id;
    title = map['title'];
    description = map['description'];
    date = (map['date'] as Timestamp).toDate();
    time = (map['time'] as Timestamp).toDate();
    int priorityValue = map['priority'];
    if (priorityValue == 1) {
      priority = Priorities.high.toString();
    } else if (priorityValue == 2) {
      priority = Priorities.medium.toString();
    } else {
      priority = Priorities.low.toString();
    }
    isCompleted = map['isCompleted'];
  }
}
