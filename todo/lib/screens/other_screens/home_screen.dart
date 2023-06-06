import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/reusable/active_todo_cards.dart';
import 'package:todo/widgets/reusable/completed__todo.dart';

import '../../services/firebase_services.dart';
import '../../widgets/active_todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColorsLight.scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: AppColorsLight.scaffoldBackgroundColor,
            automaticallyImplyLeading: false,
            expandedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                margin: EdgeInsets.only(
                    top: AppLayout.getHeight(40),
                    left: AppLayout.getWidth(10),
                    bottom: AppLayout.getHeight(10),
                    right: AppLayout.getWidth(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: AppLayout.getHeight(70),
                      width: AppLayout.getHeight(70),
                      decoration: const BoxDecoration(
                        //color: AppColorsLight.scaffoldBackgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        image: DecorationImage(
                          fit: BoxFit.contain,
                          image: AssetImage(
                              "assets/images/profile_placeholder.png"),
                        ),
                      ),
                    ),
                    const Gap(10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hello,",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          context.read<User>().displayName!,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_vert_rounded,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppLayout.getWidth(12),
                vertical: AppLayout.getHeight(10),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "On Progress ",
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                          children: [
                            TextSpan(
                              text: "(10)",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[600],
                              ),
                            )
                          ],
                        ),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              AppColorsLight.buttonColor),
                        ),
                        child: const Text(
                          "View more",
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(left: AppLayout.getWidth(10)),
              height: AppLayout.getHeight(200),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                itemBuilder: (context, index) => ActiveTodoCard(),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              margin: EdgeInsets.only(
                left: AppLayout.getWidth(12),
                right: AppLayout.getWidth(12),
                top: AppLayout.getHeight(20),
                bottom: AppLayout.getHeight(5),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Text(
                        "Completed",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {},
                        style: const ButtonStyle(
                          foregroundColor: MaterialStatePropertyAll(
                              AppColorsLight.buttonColor),
                        ),
                        child: const Text(
                          "View more",
                          style: TextStyle(fontSize: 15),
                        ),
                      )
                    ],
                  ),
                  const Gap(10),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 10,
              (context, index) => const CompletedTodo(),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(
          Icons.add,
          size: 28,
        ),
        backgroundColor: AppColorsLight.buttonColor,
        foregroundColor: AppColorsLight.backgroundColor,
        elevation: 0.0,
        extendedPadding:
            EdgeInsets.symmetric(horizontal: AppLayout.getWidth(100)),
        onPressed: () {},
        label: const Text(
          "Create New",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
