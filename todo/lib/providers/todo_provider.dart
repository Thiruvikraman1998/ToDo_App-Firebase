import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';

String getUid() {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser!;
  String userId = user.uid;
  return userId;
}

// creating unique ids for each task's
const Uuid uuid = Uuid();
final taskId = uuid.v4();

class TodoProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference todoCollections = FirebaseFirestore.instance
      .collection('user')
      .doc(getUid())
      .collection('task');

  List<Todo> todos = [];
  StreamSubscription<QuerySnapshot>? _todoSubscription;

  void streamTodos() {
    _todoSubscription = todoCollections.snapshots().listen((querySnapshot) {
      todos = querySnapshot.docs.map((e) {
        final data = e.data() as Map<String, dynamic>;
        return Todo.fromMap(data, e.id);
      }).toList();
      notifyListeners();
    });
  }

  // validate and create a todo

  Future<void> validateAndCreateTask(
      BuildContext context,
      String? id,
      String? title,
      String? description,
      DateTime? date,
      DateTime? time,
      String? priority,
      bool? isCompleted) async {
    if (title!.isEmpty ||
        description!.isEmpty ||
        date == null ||
        time == null) {
      showDialog(
        context: context,
        builder: (dialogBoxContext) {
          return AlertDialog(
            title: const Text("Invalid Inputs"),
            content: title.isEmpty
                ? const Text("Title is empty, enter a title")
                : title.isEmpty
                    ? const Text("Description is Empty")
                    : date == null
                        ? const Text("Date is not selected, select a date")
                        : time == null
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
    final DocumentReference docref = firestore
        .collection('user')
        .doc(getUid())
        .collection('task')
        .doc(taskId);
    Todo newtodo =
        Todo(id, title, description, date, time, priority, isCompleted);
    try {
      await docref.set(newtodo.toMap());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // update only the status
  Future<void> updateTodoStatus(Todo todo, bool isCompleted) async {
    DocumentReference documentReference = todoCollections.doc(todo.id);
    print(todo.id);
    await documentReference.update({'isCompleted': isCompleted});
  }

//   Future<void> updateTodoStatus(Todo todo, bool isCompleted) async {
//   DocumentReference docRef = todoCollections.doc(todo.id);
//   DocumentSnapshot docSnapshot = await docRef.get();

//   if (docSnapshot.exists) {
//     await docRef.update({'isCompleted': isCompleted});
//     int todoIndex = todos.indexOf(todo);
//     todos[todoIndex] = todo.copyWith(isCompleted: isCompleted);
//     notifyListeners();
//   } else {
//     // Handle the case where the document does not exist
//     print('Todo document not found');
//   }
// }

  Stream<List<Todo>> get todoStream =>
      todoCollections.snapshots().map((querysnapshots) {
        return querysnapshots.docs.map((e) {
          final data = e.data() as Map<String, dynamic>;
          return Todo.fromMap(data, e.id);
        }).toList();
      });
}
