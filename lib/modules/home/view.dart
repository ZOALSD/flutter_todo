import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/modules/home/controller.dart';
import 'package:todo/modules/home/widgets/add_card.dart';
import 'package:todo/modules/home/widgets/add_task.dart';
import 'package:todo/modules/home/widgets/task_card.dart';
import 'package:todo/modules/report/report.dart';

class Home extends GetView<HomeController> {
  // final homeController = Get.find<HomeController>();
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => IndexedStack(
            index: controller.index.value,
            children: [
              ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(4.0.wp),
                    child: Text(
                      "My List",
                      style: TextStyle(
                        fontSize: 24.0.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Obx(
                    () => GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      children: [
                        ...controller.tasks
                            .map(
                              (element) => LongPressDraggable(
                                data: element,
                                feedback: Opacity(
                                  opacity: 0.8,
                                  child: TaskCard(task: element),
                                ),
                                child: TaskCard(task: element),
                                onDragStarted: () =>
                                    controller.changeDeleting(true),
                                onDraggableCanceled: (_, __) =>
                                    controller.changeDeleting(false),
                                onDragEnd: (_) =>
                                    controller.changeDeleting(false),
                              ),
                            )
                            .toList(),
                        AddCard()
                      ],
                    ),
                  )
                ],
              ),
              Report()
            ],
          ),
        ),
      ),
      floatingActionButton: DragTarget<Task>(
        builder: (context, candidateData, rejectedData) => Obx(() =>
            FloatingActionButton(
                backgroundColor:
                    controller.deleteing.value ? Colors.red : Colors.blue,
                onPressed: () =>
                    Get.to(() => AddTask(), transition: Transition.upToDown),
                child: Icon(
                  controller.deleteing.value ? Icons.delete : Icons.add,
                  color: Colors.white,
                ))),
        onAccept: (Task task) {
          controller.deleteTask(task);
          EasyLoading.showSuccess("Task Deleted");
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: controller.index.value,
          onTap: (value) => controller.changeIndex(value),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.apps),
              ),
            ),
            BottomNavigationBarItem(
              label: 'report',
              icon: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Icon(Icons.data_usage),
              ),
            )
          ]),
    );
  }
}
