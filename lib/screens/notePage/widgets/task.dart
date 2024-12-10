import 'package:asset_icon/asset_icon.dart';
import 'package:flutter/material.dart';
import 'package:note_files/collection/Note.dart';
import 'package:note_files/provider/ListViewProvider.dart';
import 'package:note_files/requiredData.dart';
import 'package:provider/provider.dart';

import '../../../generated/icons.g.dart';

enum TaskState {
  notTask(AssetIcons.task, null),
  checked(AssetIcons.checked, true),
  unchecked(AssetIcons.unchecked, false);

  final String icon;
  final bool? value;

  const TaskState(this.icon, this.value);

  // Get the next state
  TaskState get nextState {
    switch (this) {
      case TaskState.notTask:
        return TaskState.unchecked;
      case TaskState.unchecked:
        return TaskState.checked;
      case TaskState.checked:
        return TaskState.notTask; // or notTask if you want to cycle back
    }
  }

  // Helper to get TaskState from a bool? value
  static TaskState fromValue(bool? value) {
    return TaskState.values.firstWhere(
      (state) => state.value == value,
      orElse: () => TaskState.notTask,
    );
  }
}

class Task extends StatefulWidget {
  final int noteId;

  const Task({Key? key, required this.noteId}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  late Future<Note?> noteFuture;
  late TaskState taskState;

  @override
  void initState() {
    super.initState();
    noteFuture = requiredData.db.getNote(widget.noteId);
  }

  Future<void> _rotateTaskState(Note note) async {
    setState(() {
      // Rotate the state using TaskState.nextState
      taskState = taskState.nextState;
      // Update the note's isDone field based on the current state
      note.isDone = taskState.value;

    });

    // Update the database asynchronously
    try {
      await requiredData.db.updateNote(note);
      context.read<ListViewProvider>().updateNote(note);
      print("didi");
      print( (await requiredData.db.getNote(widget.noteId))?.isDone??"");
    } catch (e) {
      print("Error updating task state: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    //  final Map<String, String> locale = requiredData.locale;
    return FutureBuilder<Note?>(
      future: noteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        // if (snapshot.hasError) {
        //   return Text(
        //     locale[TranslationsKeys.task] ?? "Error fetching task",
        //     style: TextStyle(color: Colors.red),
        //   );
        // }

        final note = snapshot.data;

        // if (note == null) {
        //   return Text(
        //     locale[TranslationsKeys.task] ?? "Task not found",
        //     style: TextStyle(color: Colors.red),
        //   );
        // }

        // Initialize the TaskState from the note's isDone value
        taskState = TaskState.fromValue(note?.isDone);
        return TextButton(
          onPressed:() { _rotateTaskState(note!);   },
          child: AssetIcon(
            taskState.icon,
            color: Colors.black87,
          ),
        );
      },
    );
  }
}
