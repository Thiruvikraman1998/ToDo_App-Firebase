import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';

class CompletedTodo extends StatelessWidget {
  const CompletedTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(
        left: AppLayout.getWidth(15),
        right: AppLayout.getWidth(15),
        top: AppLayout.getHeight(5),
        bottom: AppLayout.getHeight(5),
      ),
      color: AppColorsLight.mediumPriority,
      child: Container(
        height: AppLayout.getHeight(150),
        width: double.infinity,
        margin: EdgeInsets.only(left: AppLayout.getWidth(12)),
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
              title: const Text(
                'Title',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    decoration: TextDecoration.lineThrough),
              ),
              subtitle: const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Transform.scale(
                scale: 1.3,
                child: CupertinoCheckbox(
                    activeColor: AppColorsLight.buttonColor,
                    shape: const CircleBorder(),
                    value: true,
                    onChanged: (value) {}),
              ),
            ),
            const Gap(10),
            const Divider(height: 3, indent: 20, endIndent: 20),
            const Gap(10),
            Padding(
              padding: EdgeInsets.only(left: AppLayout.getWidth(20)),
              child: const Text(
                "Today, 11.30 PM",
                style: TextStyle(fontSize: 17),
              ),
            )
          ],
        ),
      ),
    );
  }
}
