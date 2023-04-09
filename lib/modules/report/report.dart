import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:intl/intl.dart';
import 'package:todo/modules/home/controller.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15.0.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat.yMMMd().format(DateTime.now()),
                  style: const TextStyle(fontSize: 17, color: Colors.grey),
                ),
                const Divider()
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              stepBuilder(color: Colors.green, amount: 7, title: 'Live Tasks'),
              stepBuilder(color: Colors.orange, amount: 7, title: 'Complated'),
              stepBuilder(color: Colors.blue, amount: 7, title: ' Created'),
            ],
          ),
          SizedBox(height: 20.0.wp),
          UnconstrainedBox(
            child: SizedBox(
              width: 70.0.wp,
              height: 70.0.wp,
              child: CircularStepProgressIndicator(
                totalSteps: 70, //homeController.totalDoneTask(task: task),
                currentStep: 5,
                stepSize: 20,
                selectedColor: Colors.green,
                unselectedColor: Colors.grey.shade200,
                padding: 0,
                selectedStepSize: 21,
                roundedCap: (p0, p1) => true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '70 %',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      'Effciency',
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  stepBuilder(
          {required MaterialColor color,
          required int amount,
          required String title}) =>
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 3.0.wp,
              height: 3.0.wp,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: color, width: 0.5.wp),
              )),
          SizedBox(width: 3.0.wp),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                amount.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(title)
            ],
          )
        ],
      );
}
