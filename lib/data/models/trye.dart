import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Task extends Equatable {
  final String title;
  final int icon;
  final String color;
  final List<Todo>? todo;
  Task({
    required this.title,
    required this.icon,
    required this.color,
    this.todo,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<Todo>? todo,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todo: todo ?? this.todo,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'icon': icon,
      'color': color,
      'todo': todo?.map((x) => x.toMap()).toList(),
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      icon: map['icon'].toInt() as int,
      color: map['color'] as String,
      todo: List<Todo>.from(
        (map['todo'] as List<int>).map<Todo>(
          (x) => Todo.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(title: $title, icon: $icon, color: $color, todo: $todo)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.icon == icon &&
        other.color == color &&
        listEquals(other.todo, todo);
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ color.hashCode ^ todo.hashCode;
  }

  @override
  List<Object?> get props => [title, icon, color];
}

class Todo {
  final String title;
  final bool done;
  Todo({
    required this.title,
    required this.done,
  });

  Todo copyWith({
    String? title,
    bool? done,
  }) {
    return Todo(
      title: title ?? this.title,
      done: done ?? this.done,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'done': done,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      title: map['title'] as String,
      done: map['done'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) =>
      Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Todo(title: $title, done: $done)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;

    return other.title == title && other.done == done;
  }

  @override
  int get hashCode => title.hashCode ^ done.hashCode;
}
