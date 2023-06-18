import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

import '../../models/todo.dart';

class CompletedTodo extends StatelessWidget {
  const CompletedTodo({super.key, required this.completedTodo});
  final Todo completedTodo;

  @override
  Widget build(BuildContext context) {
    final TodoProvider todoProvider = context.watch<TodoProvider>();
    return Card(
      margin: EdgeInsets.only(
        left: AppLayout.getWidth(15),
        right: AppLayout.getWidth(15),
        top: AppLayout.getHeight(5),
        bottom: AppLayout.getHeight(5),
      ),
      color: completedTodo.priority == Priorities.high.toString()
          ? AppColorsLight.highPriority
          : completedTodo.priority == Priorities.medium.toString()
              ? AppColorsLight.mediumPriority
              : completedTodo.priority == Priorities.low.toString()
                  ? AppColorsLight.lowPriority
                  : null,
      child: Container(
        height: AppLayout.getHeight(150),
        width: double.infinity,
        margin: EdgeInsets.only(
          left: AppLayout.getWidth(11),
        ),
        decoration: const BoxDecoration(
          color: AppColorsLight.backgroundColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                completedTodo.title!,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough),
              ),
              subtitle: Text(
                completedTodo.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Transform.scale(
                scale: 1.3,
                child: CupertinoCheckbox(
                    activeColor: AppColorsLight.buttonColor,
                    shape: const CircleBorder(),
                    value: completedTodo.isCompleted,
                    onChanged: (value) {
                      todoProvider.updateTodoStatus(completedTodo, value!);
                      print(value);
                    }),
              ),
            ),
            const Gap(10),
            const Divider(height: 3, indent: 20, endIndent: 20),
            const Gap(10),
            Padding(
              padding: EdgeInsets.only(left: AppLayout.getWidth(20)),
              child: Text(
                completedTodo.date!.toString(),
                style: const TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
