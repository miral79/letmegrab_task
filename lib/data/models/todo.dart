import 'dart:convert';

enum TodoStatus { todo, inProgress, done, created }

class TodoModel {
  String id;
  String title;
  String description;
  int totalSeconds; // configured duration
  int remainingSeconds; // remaining seconds
  TodoStatus status;
  bool isRunning;

  TodoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.totalSeconds,
    required this.remainingSeconds,
    this.status = TodoStatus.todo,
    this.isRunning = false,
  });

  factory TodoModel.fromMap(Map<String, dynamic> m) {
    return TodoModel(
      id: m['id'] as String,
      title: m['title'] as String,
      description: m['description'] as String,
      totalSeconds: m['totalSeconds'] as int,
      remainingSeconds: m['remainingSeconds'] as int,
      status: TodoStatus.values[m['status'] as int],
      isRunning: m['isRunning'] as bool,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'description': description,
    'totalSeconds': totalSeconds,
    'remainingSeconds': remainingSeconds,
    'status': status.index,
    'isRunning': isRunning,
  };

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String s) => TodoModel.fromMap(json.decode(s));

  TodoModel copyWith({
    String? id,
    String? title,
    String? description,
    int? totalSeconds,
    int? remainingSeconds,
    TodoStatus? status,
    bool? isRunning,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      totalSeconds: totalSeconds ?? this.totalSeconds,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      status: status ?? this.status,
      isRunning: isRunning ?? this.isRunning,
    );
  }
}
