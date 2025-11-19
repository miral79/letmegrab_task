// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letmegrab_task/data/models/todo.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_event.dart';
import 'package:letmegrab_task/presentation/screens/todo/todo_edit_form.dart';

class TodoDetailsPage extends StatelessWidget {
  final TodoModel todo;
  const TodoDetailsPage({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final state = context.select((TodoBloc bloc) => bloc.state);
    final current = state.todos.firstWhere(
      (t) => t.id == todo.id,
      orElse: () => todo,
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF3F6FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
        title: const Text("Todo Details"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black87),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => TodoEditForm(todo: current),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 120, 16, 16),
        child: Column(
          children: [
            // ---------------------- GLASS CARD ----------------------
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.65),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.white30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        current.title,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        current.description,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),

                      const SizedBox(height: 16),

                      // ------------------ STATUS CHIP ------------------
                      Align(
                        alignment: Alignment.centerLeft,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          padding: const EdgeInsets.symmetric(
                            vertical: 6,
                            horizontal: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _statusColor(
                              current.status,
                            ).withOpacity(.15),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            current.status.name.toUpperCase(),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: _statusColor(current.status),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ------------------ BIG TIMER -------------------
                      Center(
                        child: Text(
                          _formatTime(current.remainingSeconds),
                          style: const TextStyle(
                            fontSize: 60,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 2,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ------------------ ACTION BUTTONS -------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _actionButton(
                            icon: Icons.play_arrow,
                            color: Colors.green,
                            enabled: current.status != TodoStatus.done,
                            onTap: () => context.read<TodoBloc>().add(
                              StartTodo(current.id),
                            ),
                          ),
                          const SizedBox(width: 16),
                          _actionButton(
                            icon: Icons.pause,
                            color: Colors.amber,
                            onTap: () => context.read<TodoBloc>().add(
                              PauseTodo(current.id),
                            ),
                          ),
                          const SizedBox(width: 16),
                          _actionButton(
                            icon: Icons.stop,
                            color: Colors.red,
                            onTap: () => context.read<TodoBloc>().add(
                              StopTodo(current.id),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ------------------ DELETE BUTTON -------------------
                      Center(
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.redAccent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 22,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          icon: const Icon(Icons.delete),
                          label: const Text("Delete"),
                          onPressed: () {
                            context.read<TodoBloc>().add(
                              DeleteTodo(current.id),
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _statusColor(TodoStatus status) {
    switch (status) {
      case TodoStatus.created:
        return Colors.blue;
      case TodoStatus.todo:
        return Colors.indigo; // choose any color
      case TodoStatus.inProgress:
        return Colors.orange;
      case TodoStatus.done:
        return Colors.green;
    }
  }

  Widget _actionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    bool enabled = true,
  }) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          color: enabled ? color : Colors.grey.shade400,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.3),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Icon(
          Icons.play_arrow,
          color: Colors.white,
          size: 30,
        ).withIcon(icon),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return "${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
  }
}

extension _IconExt on Widget {
  Widget withIcon(IconData icon) => Icon(icon, color: Colors.white, size: 30);
}
