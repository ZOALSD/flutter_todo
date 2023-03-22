import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/modules/details/widgets/done_tasks.dart';
import 'package:todo/modules/details/widgets/todo_tasks.dart';
import 'package:todo/modules/home/controller.dart';

class Details extends StatelessWidget {
  final homeController = Get.find<HomeController>();

  Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Task task = homeController.task.value!;
    Color color = HexColor.fromHex(task.color);
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: homeController.formKey,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(3.0.wp),
                child: Row(
                  children: [
                    BackButton(
                      onPressed: () {
                        Get.back();
                        homeController.updateTodos();
                        homeController.changeTask(null);
                        homeController.editController.clear();
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.wp),
                child: Row(
                  children: [
                    Icon(
                      IconData(task.icon, fontFamily: 'materialIcons'),
                      color: color,
                    ),
                    SizedBox(width: 3.0.wp),
                    Text(
                      task.title,
                      style: TextStyle(
                          fontSize: 12.0.sp, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 3.0.wp, left: 16.0.wp, right: 16.0.wp, bottom: 5.0.wp),
                child: Obx(
                  () {
                    final int tasksToal = homeController.todoingTask.length +
                        homeController.doneTask.length;
                    return Row(
                      children: [
                        Text(
                          '$tasksToal Tasks',
                          style: TextStyle(
                              fontSize: 12.0.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                        SizedBox(width: 3.0.wp),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: tasksToal == 0 ? 1 : tasksToal,
                            currentStep: homeController.doneTask.length,
                            size: 5,
                            padding: 0,
                            selectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [color.withOpacity(0.5), color],
                            ),
                            unselectedGradientColor: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.grey[300]!, Colors.grey[300]!],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 2.0.wp, horizontal: 5.0.wp),
                child: TextFormField(
                  controller: homeController.editController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank,
                      color: Colors.grey.shade400,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (homeController.formKey.currentState!.validate()) {
                          bool success = homeController
                              .addTodo(homeController.editController.text);
                          if (success) {
                            EasyLoading.showSuccess('Todo item add success');
                          } else {
                            EasyLoading.showError('Todo item already exist');
                          }
                          homeController.editController.clear();
                        }
                      },
                      icon: const Icon(Icons.done),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your todo item';
                    }
                    return null;
                  },
                ),
              ),
              TodoTasks(),
              DoneTasks(),
            ],
          ),
        ),
      ),
    );
  }
}
