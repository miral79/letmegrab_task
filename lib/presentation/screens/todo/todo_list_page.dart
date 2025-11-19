// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letmegrab_task/data/models/todo.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_state.dart';
import 'package:letmegrab_task/presentation/screens/todo/todo_details_page.dart';
import 'todo_form_sheet.dart';

class TodoListPage extends StatelessWidget {
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FF),
      appBar: AppBar(
        title: Text("LMG - TODO", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.todos.isEmpty) {
            return const Center(
              child: Text(
                'No todos. Tap + to add',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: state.todos.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final t = state.todos[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TodoDetailsPage(todo: t)),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.65),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.white30),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.title,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            t.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _statusChip(t.status),
                              Text(
                                _formatTime(t.remainingSeconds),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => const TodoFormSheet(),
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _statusChip(TodoStatus status) {
    Color color;
    switch (status) {
      case TodoStatus.created:
        color = Colors.blue;
        break;
      case TodoStatus.todo:
        color = Colors.indigo;
        break;
      case TodoStatus.inProgress:
        color = Colors.orange;
        break;
      case TodoStatus.done:
        color = Colors.green;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}
