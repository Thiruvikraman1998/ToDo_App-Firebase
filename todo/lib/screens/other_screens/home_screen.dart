import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/settings_enum.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/providers/todo_provider.dart';
import 'package:todo/screens/other_screens/all_active_todo_list.dart';
import 'package:todo/utils/app_colors.dart';
import 'package:todo/utils/app_layout.dart';
import 'package:todo/widgets/input_modal.dart';
import 'package:todo/widgets/reusable/active_todo_cards.dart';
import 'package:todo/widgets/reusable/completed__todo.dart';
import 'package:intl/intl.dart';

import '../../services/firebase_services.dart';
import '../../widgets/popupmenu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String uid = '';

  @override
  void initState() {
    getUid();
    Provider.of<TodoProvider>(context, listen: false).streamTodos();
    super.initState();
  }

  void getUid() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoProvider todoProvider = Provider.of<TodoProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppColorsLight.scaffoldBackgroundColor,
      body:
          // used stack to have a container with opacity in the bottom that looks like faded from bottom.
          Stack(
        children: [
          Positioned.fill(
            child: CustomScrollView(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                          const PopupMenuTheme(
                            data: PopupMenuThemeData(
                                surfaceTintColor:
                                    AppColorsLight.scaffoldBackgroundColor),
                            child: PopUpMenuAction(),
                          ),
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
                                    text:
                                        "(${todoProvider.activeTodoList().length})",
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
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/all_active_todo');
                                },
                                child: const Text(
                                  "View all",
                                  style: TextStyle(fontSize: 15),
                                ),
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
                      height: size.height * 0.25,
                      child: StreamBuilder<List<Todo>>(
                        stream: todoProvider.todoStream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CupertinoActivityIndicator(),
                            );
                          } else {
                            List<Todo> activeTodos =
                                todoProvider.activeTodoList();
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: activeTodos.length,
                              itemBuilder: (context, index) {
                                //if (todos[index].isCompleted == false) {
                                return AnimationConfiguration.staggeredList(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  child: SlideAnimation(
                                    horizontalOffset: 65.0,
                                    child: FadeInAnimation(
                                      child: ActiveTodoCard(
                                        todo: activeTodos[index],
                                      ),
                                    ),
                                  ),
                                );
                                //}
                              },
                            );
                          }
                        },
                      )),
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
                                "View all",
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
                StreamBuilder<List<Todo>>(
                  stream: todoProvider.todoStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverToBoxAdapter(
                          child: CupertinoActivityIndicator());
                    } else if (snapshot.hasData) {
                      List<Todo> completedTodos =
                          todoProvider.completedTodoList();
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          childCount: completedTodos.length,
                          (context, index) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              child: SlideAnimation(
                                verticalOffset: 44.0,
                                child: FadeInAnimation(
                                  child: CompletedTodo(
                                    completedTodo: completedTodos[index],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return const Center(child: Text("No completed todos"));
                  },
                )
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  blurRadius: 40,
                  spreadRadius: 30,
                  offset: Offset(0, 5),
                  color: Colors.white.withOpacity(0.8),
                )
              ]),
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
        onPressed: _openInputModal,
        label: const Text(
          "Create New",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _openInputModal() {
    showModalBottomSheet(
        isScrollControlled: true,
        showDragHandle: true,
        backgroundColor: AppColorsLight.backgroundColor,
        context: context,
        builder: (bottomSheetContext) {
          return TaskInputModal();
        },
        enableDrag: true);
  }
}
