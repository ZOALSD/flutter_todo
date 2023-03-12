import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/core/utils/extensions.dart';
import 'package:todo/core/values/colors.dart';
import 'package:todo/modules/home/controller.dart';
import 'package:todo/widgets/icons.dart';

class AddCard extends StatelessWidget {
  AddCard({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    final icons = getIcons();
    var squareWidth = Get.width - 12.0.wp;
    return Container(
      width: squareWidth / 2,
      height: squareWidth / 2,
      margin: EdgeInsets.all(3.0.wp),
      child: InkWell(
        onTap: () async {
          await Get.defaultDialog(
            titlePadding: EdgeInsets.symmetric(vertical: 5.0.wp),
            radius: 5,
            title: "Task type",
            content: Form(
              key: homeController.fonmKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0.wp),
                    child: TextFormField(
                      controller: homeController.editController,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Plase enter your task title';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(), labelText: 'Title'),
                    ),
                  ),
                  Wrap(
                    spacing: 2.0.wp,
                    children: icons
                        .map((e) => Obx(() {
                              final index = icons.indexOf(e);
                              return ChoiceChip(
                                label: e,
                                pressElevation: 0,
                                backgroundColor: Colors.white,
                                selected:
                                    homeController.chipIndex.value == index,
                                onSelected: (bool selected) {
                                  homeController.chipIndex.value =
                                      selected ? index : 0;
                                },
                              );
                            }))
                        .toList(),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: blue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          minimumSize: const Size(150, 40)),
                      onPressed: () {
                        if (homeController.fonmKey.currentState!.validate()) {}
                      },
                      child: const Text("Confirm"))
                ],
              ),
            ),
          );
        },
        child: DottedBorder(
            dashPattern: const [8, 4],
            color: Colors.grey.shade400,
            child: Center(
              child: Icon(
                Icons.add,
                size: 10.0.wp,
                color: Colors.grey,
              ),
            )),
      ),
    );
  }
}


// icons.map((e) => Obx((){
//                           final index = icons.indexOf(e);
//                           return  ChoiceChip(label: e,
//                          selected: homeController.chipIndex.value == index))).toList()