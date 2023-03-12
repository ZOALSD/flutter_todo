// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:todo/data/providers/task/provider.dart';

import '../../models/task.dart';

class TaskRepository {
  TaskProvider taskProvider;
  TaskRepository({
    required this.taskProvider,
  });

  List<Task> readTasks() => taskProvider.readTasks();
  void wirteTask(List<Task> tasks) => taskProvider.writeTasks(tasks);
}
