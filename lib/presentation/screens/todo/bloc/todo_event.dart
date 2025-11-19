import 'package:equatable/equatable.dart';
import 'package:letmegrab_task/data/models/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
  @override
  List<Object?> get props => [];
}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String description;
  final int totalSeconds;
  const AddTodo(this.title, this.description, this.totalSeconds);

  @override
  List<Object?> get props => [title, description, totalSeconds];
}

class DeleteTodo extends TodoEvent {
  final String id;
  const DeleteTodo(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateTodo extends TodoEvent {
  final TodoModel todo;
  const UpdateTodo(this.todo);
  @override
  List<Object?> get props => [todo];
}

class StartTodo extends TodoEvent {
  final String id;
  const StartTodo(this.id);
  @override
  List<Object?> get props => [id];
}

class PauseTodo extends TodoEvent {
  final String id;
  const PauseTodo(this.id);
  @override
  List<Object?> get props => [id];
}

class Tick extends TodoEvent {}

class StopTodo extends TodoEvent {
  final String id;
  const StopTodo(this.id);
  @override
  List<Object?> get props => [id];
}
