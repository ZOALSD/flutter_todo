import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/modules/home/controller.dart';
import 'package:todo/widgets/dismissble_widget.dart';

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
                            child: DismissbleWidget(
                              item: e,
                              onDismissed: (direction) {
                                homeCcontroller.dismissItem(
                                            e.title!, direction) ==
                                        DismissStatus.deleted
                                    ? EasyLoading.showSuccess('Task Deteted')
                                    : EasyLoading.showSuccess('Task Archived');
                              },
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
