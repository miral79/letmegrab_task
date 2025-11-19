import 'package:equatable/equatable.dart';
import 'package:letmegrab_task/data/models/todo.dart';

class TodoState extends Equatable {
  final List<TodoModel> todos;
  final bool loading;

  const TodoState({this.todos = const [], this.loading = false});

  TodoState copyWith({List<TodoModel>? todos, bool? loading}) {
    return TodoState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object?> get props => [todos, loading];
}
