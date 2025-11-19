import 'package:get_it/get_it.dart';
import 'package:letmegrab_task/data/repositories/todo_repository.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton<TodoRepository>(() => TodoRepository());

  locator.registerFactory<TodoBloc>(
    () => TodoBloc(repository: locator<TodoRepository>()),
  );
}
