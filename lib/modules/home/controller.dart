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
  final deleteing = false.obs;
  final chipIndex = 0.obs;
  final task = Rx<Task?>(null);

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(taskRepository.readTasks());
    ever(tasks, (_) => taskRepository.wirteTask(tasks));
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) return false;
    tasks.add(task);
    return true;
  }

  void changeDeleting(bool value) {
    deleteing.value = value;
  }

  void changeChipIndex(int value) {
    chipIndex.value = value;
  }

  void deleteTask(Task task) {
    tasks.remove(task);
  }

  changeTask(Task select) {
    task.value = select;
  }
}
