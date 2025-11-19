import 'package:get_storage/get_storage.dart';
import 'package:letmegrab_task/data/models/todo.dart';
import 'package:uuid/uuid.dart';

class TodoRepository {
  static const String _key = 'lmg_todos';
  final GetStorage _storage = GetStorage();
  final _uuid = const Uuid();

  List<TodoModel> loadTodos() {
    final List? raw = _storage.read<List>(_key);
    if (raw == null) return [];
    return raw
        .map((e) => TodoModel.fromMap(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final raw = todos.map((t) => t.toMap()).toList();
    await _storage.write(_key, raw);
  }

  Future<TodoModel> createTodo({
    required String title,
    required String description,
    required int totalSeconds,
  }) async {
    final model = TodoModel(
      id: _uuid.v4(),
      title: title,
      description: description,
      totalSeconds: totalSeconds,
      remainingSeconds: totalSeconds,
    );
    final list = loadTodos();
    list.add(model);
    await saveTodos(list);
    return model;
  }

  Future<void> updateTodos(List<TodoModel> todos) async {
    await saveTodos(todos);
  }

  Future<void> deleteTodo(String id) async {
    final list = loadTodos();
    list.removeWhere((t) => t.id == id);
    await saveTodos(list);
  }
}
