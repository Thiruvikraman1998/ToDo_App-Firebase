import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../models/todo.dart';

String getUid() {
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser!;
  String userId = user.uid;
  return userId;
}

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

  Future<void> updateTodoStatus(Todo todo, bool isCompleted) async {
    DocumentReference documentReference = todoCollections.doc(todo.id);
    await documentReference.update({'isCompleted': isCompleted});
  }

  Stream<List<Todo>> get todoStream =>
      todoCollections.snapshots().map((querysnapshots) {
        return querysnapshots.docs.map((e) {
          final data = e.data() as Map<String, dynamic>;
          return Todo.fromMap(data, e.id);
        }).toList();
      });
}
