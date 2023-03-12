import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/data/providers/task/provider.dart';
import 'package:todo/data/services/storage/repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final fonmKey = GlobalKey<FormState>();
  final editController = TextEditingController();
  final chipIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.wirteTask(tasks));
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }
}
