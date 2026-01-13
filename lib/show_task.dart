import 'package:flutter/material.dart';
import 'task_model.dart';
import 'database_helper.dart';

class ShowTask extends StatefulWidget {
  const ShowTask({super.key});

  @override
  State<ShowTask> createState() => _ShowTaskState();
}

class _ShowTaskState extends State<ShowTask> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  bool _editIsDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Show Task')),
      floatingActionButton: FloatingActionButton(
        onPressed: showInsertTaskForm,
        child: const Icon(Icons.add),
      ),
      body: FutureBuilder<List<Task>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tasks available.'));
          }

          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      task.isDone
                          ? Icons.check_box
                          : Icons.check_box_outline_blank,
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => showEditTaskForm(task),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => confirmDeleteTask(task.id!),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // ---------- ADD ----------
  void showInsertTaskForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await _addNewTask(
                  _titleController.text,
                  _descriptionController.text,
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addNewTask(String title, String description) async {
    final newTask = Task(title: title, description: description, isDone: false);
    await DatabaseHelper.instance.insertTask(newTask);
    _titleController.clear();
    _descriptionController.clear();
    setState(() {});
    Navigator.pop(context);
  }

  // ---------- FETCH ----------
  Future<List<Task>> _fetchTasks() async {
    return DatabaseHelper.instance.getTasks();
  }

  // ---------- DELETE ----------
  void confirmDeleteTask(int taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          content: const Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await DatabaseHelper.instance.deleteTask(taskId);
                setState(() {});
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  // ---------- EDIT ----------
  void showEditTaskForm(Task task) {
    _titleController.text = task.title;
    _descriptionController.text = task.description;
    _editIsDone = task.isDone;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Edit Task'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  Row(
                    children: [
                      const Text('Completed'),
                      Checkbox(
                        value: _editIsDone,
                        onChanged: (value) {
                          setDialogState(() {
                            _editIsDone = value ?? false;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    final updatedTask = Task(
                      id: task.id,
                      title: _titleController.text,
                      description: _descriptionController.text,
                      isDone: _editIsDone,
                    );

                    await DatabaseHelper.instance.updateTask(updatedTask);

                    _titleController.clear();
                    _descriptionController.clear();
                    setState(() {});
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
