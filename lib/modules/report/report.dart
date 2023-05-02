import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/modules/home/controller.dart';

class Report extends StatelessWidget {
  Report({Key? key}) : super(key: key);

  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Text(
              'Report',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [],
            )
          ],
        ),
      )),
    );
  }
}
