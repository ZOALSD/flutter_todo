// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/modules/home/controller.dart';

class TodoTasks extends StatelessWidget {
  TodoTasks({Key? key}) : super(key: key);

  final homeCcontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCcontroller.todoingTask.isEmpty &&
              homeCcontroller.doneTask.isEmpty
          ? Padding(
              padding: EdgeInsets.symmetric(vertical: 15.0.wp),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/no_task.png',
                    width: Get.width * .5,
                  ),
                  const SizedBox(height: 20),
                  const Text('Add Task',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                ],
              ),
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...homeCcontroller.todoingTask
                    .map((e) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 5.0.wp, vertical: 1.0.wp),
                          child: Row(
                            children: [
                              Checkbox(
                                value: e.done,
                                onChanged: (value) {
                                  homeCcontroller.doneTodo(title: e.title!);
                                },
                              ),
                              const SizedBox(width: 15),
                              Text(e.title!),
                            ],
                          ),
                        ))
                    .toList()
              ],
            ),
    );
  }
}
 // : 

 