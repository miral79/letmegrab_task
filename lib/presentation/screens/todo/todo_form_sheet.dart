import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_event.dart';

class TodoFormSheet extends StatefulWidget {
  final String? editId;
  const TodoFormSheet({super.key, this.editId});

  @override
  State<TodoFormSheet> createState() => _TodoFormSheetState();
}

class _TodoFormSheetState extends State<TodoFormSheet> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _desc = TextEditingController();

  int minutes = 0;
  int seconds = 30;

  @override
  void dispose() {
    _title.dispose();
    _desc.dispose();
    super.dispose();
  }

  Future<void> _showTimePicker() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (context) {
        return SizedBox(
          height: 250,
          child: Column(
            children: [
              const SizedBox(height: 12),
              const Text(
                "Select Timer",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: minutes,
                        ),
                        itemExtent: 32,
                        onSelectedItemChanged: (v) =>
                            setState(() => minutes = v),
                        children: List.generate(6, (i) => Text('$i min')),
                      ),
                    ),
                    Expanded(
                      child: CupertinoPicker(
                        scrollController: FixedExtentScrollController(
                          initialItem: seconds,
                        ),
                        itemExtent: 32,
                        onSelectedItemChanged: (v) =>
                            setState(() => seconds = v),
                        children: List.generate(60, (i) => Text('$i sec')),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Done"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatTime() {
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add TODO', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),

              TextFormField(
                controller: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Title is required';
                  if (v.trim().length < 3) {
                    return 'Title must be at least 3 characters';
                  }
                  if (v.trim().length > 50) {
                    return 'Title must be under 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _desc,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 2,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) {
                    return 'Description is required';
                  }
                  if (v.trim().length < 5) {
                    return 'Description must be at least 5 characters';
                  }
                  if (v.trim().length > 200) {
                    return 'Description must be under 200 characters';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 15),

              InkWell(
                onTap: _showTimePicker,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Timer: ${_formatTime()}",
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.timer_outlined),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) return;

                      int totalSeconds = minutes * 60 + seconds;
                      totalSeconds = math.max(
                        1,
                        math.min(300, totalSeconds),
                      ); // Clamp 1–300 sec

                      context.read<TodoBloc>().add(
                        AddTodo(
                          _title.text.trim(),
                          _desc.text.trim(),
                          totalSeconds,
                        ),
                      );

                      Navigator.pop(context);
                    },
                    child: const Text("Save"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
