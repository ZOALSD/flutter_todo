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
  final todoingTask = <Todo>[].obs;
  final doneTask = <Todo>[].obs;

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

  changeTask(Task? select) {
    task.value = select;
  }

  changeTodo(Todo todo) {
    todoingTask.clear();
    doneTask.clear();
    if (todo.done!) {
      doneTask.add(todo);
    } else {
      todoingTask.add(todo);
    }
  }

  bool updateTask(Task task, String title) {
    List<Todo> todos = task.todo ?? [];
    if (containeTodo(todos, title)) {
      return false;
    }
    var todo = Todo(title: title, done: false);
    todos.add(todo);
    var newTask = task.copyWith(todo: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containeTodo(List todos, title) {
    return todos.any((element) => element == title);
  }
}
