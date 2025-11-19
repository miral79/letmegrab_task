import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';

import 'package:letmegrab_task/core/di/locator.dart';
import 'package:letmegrab_task/presentation/screens/splash/splash_screen.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_event.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  setupLocator();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => locator<TodoBloc>()..add(LoadTodos())),
      ],
      child: MaterialApp(
        title: 'LetMeGrab Task',
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      ),
    );
  }
}
