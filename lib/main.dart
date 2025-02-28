import 'package:flutter/material.dart';

void main() {
  runApp(TaskApp());
}

class Task {
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        brightness: Brightness.light,
      ),
      home: TaskListScreen(),
    );
  }
}

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final List<Task> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    String taskName = _taskController.text.trim();
    if (taskName.isNotEmpty) {
      setState(() {
        _tasks.add(Task(name: taskName));
      });
      _taskController.clear();
    }
  }

  void _clearTasks() {
    setState(() {
      _tasks.clear();
    });
  }

  void _toggleTaskCompletion(int index) {
    setState(() {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _taskController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Enter task',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.purple.shade50,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Add'),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _clearTasks,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Clear'),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: _tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: _tasks[index].isCompleted ? Colors.purple.shade200 : Colors.purple.shade100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Checkbox(
                          value: _tasks[index].isCompleted,
                          onChanged: (value) => _toggleTaskCompletion(index),
                          activeColor: Colors.purple,
                        ),
                        title: Text(
                          _tasks[index].name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            decoration: _tasks[index].isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                            color: Colors.purple.shade900,
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteTask(index),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.purple.shade50,
    );
  }
}
