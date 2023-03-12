import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Task extends Equatable {
  final String? title;
  final int? icon;
  final String? color;
  final List<dynamic>? todos;
  const Task({
    required this.title,
    required this.icon,
    required this.color,
    required this.todos,
  });

  Task copyWith({
    String? title,
    int? icon,
    String? color,
    List<String>? todos,
  }) {
    return Task(
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      todos: todos ?? this.todos,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'icon': icon,
      'color': color,
      'todos': todos,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'] as String,
      icon: map['icon'].toInt() as int,
      color: map['color'] as String,
      todos: map['todos'] as List<dynamic>,
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) =>
      Task.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Task(title: $title, icon: $icon, color: $color, todos: $todos)';
  }

  @override
  bool operator ==(covariant Task other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.icon == icon &&
        other.color == color &&
        listEquals(other.todos, todos);
  }

  @override
  int get hashCode {
    return title.hashCode ^ icon.hashCode ^ color.hashCode ^ todos.hashCode;
  }

  @override
  List<Object?> get props => [title, icon, color];
}
