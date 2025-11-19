import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:letmegrab_task/data/models/todo.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_bloc.dart';
import 'package:letmegrab_task/presentation/screens/todo/bloc/todo_event.dart';

class TodoEditForm extends StatefulWidget {
  final TodoModel todo;
  const TodoEditForm({super.key, required this.todo});

  @override
  State<TodoEditForm> createState() => _TodoEditFormState();
}

class _TodoEditFormState extends State<TodoEditForm> {
  late TextEditingController _title;
  late TextEditingController _desc;
  late int minutes;
  late int seconds;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController(text: widget.todo.title);
    _desc = TextEditingController(text: widget.todo.description);
    minutes = widget.todo.totalSeconds ~/ 60;
    seconds = widget.todo.totalSeconds % 60;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(height: 4, width: 50, color: Colors.grey.shade300),
            const SizedBox(height: 14),

            Text(
              "Edit Todo",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _title,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            const SizedBox(height: 10),

            TextField(
              controller: _desc,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),

            // ---------- Timer Picker ----------
            InkWell(
              onTap: () => _showTimerPicker(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade400),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const Icon(Icons.timer_outlined),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: () {
                    final total = (minutes * 60 + seconds).clamp(1, 300);
                    final updated = widget.todo.copyWith(
                      title: _title.text.trim(),
                      description: _desc.text.trim(),
                      totalSeconds: total,
                      remainingSeconds: total,
                    );
                    context.read<TodoBloc>().add(UpdateTodo(updated));
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTimerPicker(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (_) => SizedBox(
        height: 250,
        child: Row(
          children: [
            Expanded(
              child: CupertinoPicker(
                itemExtent: 30,
                scrollController: FixedExtentScrollController(
                  initialItem: minutes,
                ),
                onSelectedItemChanged: (v) => setState(() => minutes = v),
                children: List.generate(6, (i) => Text("$i min")),
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                itemExtent: 30,
                scrollController: FixedExtentScrollController(
                  initialItem: seconds,
                ),
                onSelectedItemChanged: (v) => setState(() => seconds = v),
                children: List.generate(60, (i) => Text("$i sec")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
