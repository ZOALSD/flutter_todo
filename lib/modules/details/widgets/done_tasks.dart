import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/modules/home/controller.dart';

class DoneTasks extends StatelessWidget {
  DoneTasks({Key? key}) : super(key: key);
  final homeCcontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => homeCcontroller.doneTask.isEmpty
          ? Container(height: 0)
          : Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 3.0.wp, vertical: 2.0.wp),
              child: ListView(
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                children: [
                  const Divider(),
                  const SizedBox(height: 15),
                  Text(
                    'Compeled (${homeCcontroller.doneTask.length})',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  ...homeCcontroller.doneTask
                      .map((e) => SizedBox(
                            height: 50,
                            child: Dismissible(
                              key: ObjectKey(e),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                if (direction == DismissDirection.endToStart) {}
                                if (direction == DismissDirection.endToStart) {}
                              },
                              background: Container(
                                color: Colors.red.withOpacity(0.8),
                                alignment: Alignment.centerRight,
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.delete, color: Colors.white),
                                    SizedBox(width: 10)
                                  ],
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5.0.wp, vertical: 1.0.wp),
                                  child: Row(
                                    children: [
                                      const Icon(Icons.check),
                                      const SizedBox(width: 15),
                                      Text(
                                        e.title!,
                                        style: const TextStyle(
                                            decoration:
                                                TextDecoration.lineThrough),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ))
                      .toList()
                ],
              ),
            ),
    );
  }
}
