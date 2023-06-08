import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

class ActiveTodoCard extends StatefulWidget {
  final Todo todo;
  const ActiveTodoCard({super.key, required this.todo});

  @override
  State<ActiveTodoCard> createState() => _ActiveTodoCardState();
}

class _ActiveTodoCardState extends State<ActiveTodoCard> {
  bool isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(10)),
      color: widget.todo.priority == 1
          ? AppColorsLight.highPriority
          : widget.todo.priority == 2
              ? AppColorsLight.mediumPriority
              : widget.todo.priority == 3
                  ? AppColorsLight.lowPriority
                  : null,
      child: Container(
        margin: EdgeInsets.only(bottom: AppLayout.getHeight(10)),
        padding: EdgeInsets.all(AppLayout.getHeight(5)),
        height: AppLayout.getHeight(200),
        width: AppLayout.getWidth(320),
        decoration: BoxDecoration(
          color: AppColorsLight.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppLayout.getHeight(12)),
            topRight: Radius.circular(AppLayout.getHeight(12)),
          ),
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(widget.todo.title!,
                  style: const TextStyle(fontSize: 20, color: Colors.black)),
              subtitle: Text(widget.todo.date.toString(),
                  style: const TextStyle(fontSize: 17, color: Colors.black)),
              trailing: Transform.scale(
                scale: 1.3,
                child: CupertinoCheckbox(
                  activeColor: AppColorsLight.buttonColor,
                  shape: const CircleBorder(),
                  value: isCompleted,
                  onChanged: (value) {
                    setState(
                      () {
                        isCompleted = value!;
                      },
                    );
                  },
                ),
              ),
            ),
            const Gap(10),
            Divider(
              height: AppLayout.getHeight(8),
              indent: 22,
              endIndent: 22,
            ),
            const Gap(10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: AppLayout.getWidth(15)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Description :"),
                  const Gap(5),
                  Text(
                    widget.todo.description!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
