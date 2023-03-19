import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/data/models/task.dart';
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
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.all(3.0.wp),
              child: Row(
                children: [
                  BackButton(
                    onPressed: () {
                      Get.back();
                      homeController.changeTask(null);
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
            )
          ],
        ),
      ),
    );
  }
}
