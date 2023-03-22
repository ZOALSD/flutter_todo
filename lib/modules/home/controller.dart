import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo/data/models/task.dart';
import 'package:todo/data/services/storage/repository.dart';

class HomeController extends GetxController {
  final TaskRepository taskRepository;
  HomeController({required this.taskRepository});

  final tasks = <Task>[].obs;
  final formKey = GlobalKey<FormState>();
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
    updateTodos();
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

  changeTodo(List<Todo> todos) {
    todoingTask.clear();
    doneTask.clear();
    for (Todo todo in todos) {
      if (todo.done!) {
        doneTask.add(todo);
      } else {
        todoingTask.add(todo);
      }
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

  bool addTodo(String text) {
    List<Todo>? todos = tasks[tasks.indexOf(task.value)].todo;
    if (todos?.any((element) => element.title != text) ?? true) {
      todoingTask.add(Todo(title: text, done: false));
      return true;
    }
    return false;
  }

  void updateTodos() {
    int index = tasks.indexOf(task.value);
    tasks[index] = tasks[index].copyWith(todo: [...todoingTask, ...doneTask]);
    tasks.refresh();
  }

  void doneTodo({required String title}) {
    int index = todoingTask.indexWhere((element) => element.title == title);
    todoingTask.removeAt(index);
    doneTask.add(Todo(title: title, done: true));
    todoingTask.refresh();
    doneTask.refresh();
  }

  bool isEmptyTodo({required Task task}) =>
      (tasks[tasks.indexOf(task)].todo ?? []).isEmpty;
  ////
  int totalTodos({required Task task}) =>
      (tasks[tasks.indexOf(task)].todo ?? []).length;
  ////
  int totalDoneTask({required Task task}) {
    int count = 0;
    tasks[tasks.indexOf(task)].todo?.forEach((element) {
      if (element.done ?? false) count++;
    });
    return count;
  }

  DismissStatus dismissItem(
    String title,
    DismissDirection direction,
  ) {
    int index = doneTask.indexWhere((element) => element.title == title);
    doneTask.removeAt(index);
    doneTask.refresh();
    late DismissStatus dismissStatus;
    if (direction == DismissDirection.startToEnd) {
      todoingTask.add(Todo(title: title, done: false));
      dismissStatus = DismissStatus.archived;
      todoingTask.refresh();
    } else {
      dismissStatus = DismissStatus.deleted;
    }
    return dismissStatus;
  }
}

enum DismissStatus { deleted, archived }
