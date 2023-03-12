import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/data/services/storage/services.dart';

import '../../../core/utils/keys.dart';

class TaskProvider {
  final _storage = Get.find<StorageService>();

  List<Task> readTasks() {
    var task = <Task>[];
    jsonDecode(_storage.read(testKey).toString())
        .forEach((e) => task.add(Task.fromJson(e)));
    return task;
  }

  void writeTasks(List<Task> tasks) {
    _storage.write(testKey, jsonEncode(tasks));
  }
}
