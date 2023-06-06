import 'package:flutter/material.dart';
import 'package:todo/widgets/reusable/active_todo_cards.dart';

class OnProgressTodos extends StatefulWidget {
  const OnProgressTodos({super.key});

  @override
  State<OnProgressTodos> createState() => _OnProgressTodosState();
}

class _OnProgressTodosState extends State<OnProgressTodos> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 10,
      itemBuilder: (context, index) {
        return const ActiveTodoCard();
      },
    );
  }
}
