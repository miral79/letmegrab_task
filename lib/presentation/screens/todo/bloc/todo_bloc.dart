// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:letmegrab_task/data/models/todo.dart';
import 'package:letmegrab_task/data/repositories/todo_repository.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository repository;
  Timer? _ticker;

  TodoBloc({required this.repository}) : super(const TodoState()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<UpdateTodo>(_onUpdateTodo);
    on<StartTodo>(_onStartTodo);
    on<PauseTodo>(_onPauseTodo);
    on<StopTodo>(_onStopTodo);
    on<Tick>(_onTick);

    // start a periodic ticker to update running todos every second
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => add(Tick()));
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(loading: true));
    final list = repository.loadTodos();
    emit(state.copyWith(todos: list, loading: false));
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    final model = await repository.createTodo(
      title: event.title,
      description: event.description,
      totalSeconds: event.totalSeconds,
    );
    final updated = List<TodoModel>.from(state.todos)..add(model);
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    final updated = List<TodoModel>.from(state.todos)
      ..removeWhere((t) => t.id == event.id);
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onUpdateTodo(UpdateTodo event, Emitter<TodoState> emit) async {
    final updated = state.todos
        .map((t) => t.id == event.todo.id ? event.todo : t)
        .toList();
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onStartTodo(StartTodo event, Emitter<TodoState> emit) async {
    final updated = state.todos.map((t) {
      if (t.id == event.id) {
        final s = t.copyWith(isRunning: true, status: TodoStatus.inProgress);
        return s;
      }
      return t;
    }).toList();
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onPauseTodo(PauseTodo event, Emitter<TodoState> emit) async {
    final updated = state.todos.map((t) {
      if (t.id == event.id) {
        return t.copyWith(isRunning: false);
      }
      return t;
    }).toList();
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onStopTodo(StopTodo event, Emitter<TodoState> emit) async {
    final updated = state.todos.map((t) {
      if (t.id == event.id) {
        final reset = t.copyWith(
          isRunning: false,
          remainingSeconds: t.totalSeconds,
          status: TodoStatus.todo,
        );
        return reset;
      }
      return t;
    }).toList();
    await repository.updateTodos(updated);
    emit(state.copyWith(todos: updated));
  }

  Future<void> _onTick(Tick event, Emitter<TodoState> emit) async {
    var changed = false;
    final updated = state.todos.map((t) {
      if (t.isRunning &&
          t.remainingSeconds > 0 &&
          t.status != TodoStatus.done) {
        changed = true;
        final rem = t.remainingSeconds - 1;
        if (rem <= 0) {
          return t.copyWith(
            remainingSeconds: 0,
            isRunning: false,
            status: TodoStatus.done,
          );
        }
        return t.copyWith(remainingSeconds: rem);
      }
      return t;
    }).toList();

    if (changed) {
      await repository.updateTodos(updated);
      emit(state.copyWith(todos: updated));
    }
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
