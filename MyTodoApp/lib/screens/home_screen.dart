import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/models/filter.dart';
import '../models/todo.dart';
import '../widgets/todo_tile.dart';
import 'todo_details_screen.dart';
import '../providers/todo_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String userName;

  const HomeScreen({super.key, required this.userName});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  TodoFilter _currentFilter = TodoFilter.all;

  final primaryColor = Color(0xFF1976D2);
  final accentColor = Color(0xFF64B5F6);

  List<Todo> _filteredTodos(List<Todo> todos) {
    switch (_currentFilter) {
      case TodoFilter.completed:
        return todos.where((t) => t.isDone).toList();
      case TodoFilter.pending:
        return todos.where((t) => !t.isDone).toList();
      case TodoFilter.all:
        return todos;
    }
  }

  void _showAddTodoDialog() {
    final titleCtrl = TextEditingController();
    final descCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text('Add New Task',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleCtrl,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: descCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: TextStyle(color: primaryColor)),
          ),
          ElevatedButton(
            onPressed: () {
              final todo = Todo(title: titleCtrl.text, description: descCtrl.text);
              ref.read(todoProvider.notifier).addTodo(todo);
              Navigator.pop(context);
            },
            child: Text('Add Task'),
            style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(todoProvider);
    final filteredTodos = _filteredTodos(todos);

    return Scaffold(
      appBar: AppBar(
        title: Text('Todo Dashboard'),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColor,
        onPressed: _showAddTodoDialog,
        child: Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: accentColor,
                  child: Text(widget.userName[0].toUpperCase(),
                      style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 10),
                Text("Welcome, ${widget.userName}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(height: 20),
            Wrap(
              spacing: 10,
              children: TodoFilter.values.map((f) {
                final isSelected = f == _currentFilter;
                return ChoiceChip(
                  label: Text(f.name),
                  selected: isSelected,
                  selectedColor: primaryColor,
                  onSelected: (_) => setState(() => _currentFilter = f),
                  labelStyle:
                      TextStyle(color: isSelected ? Colors.white : Colors.black),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Expanded(
              child: filteredTodos.isEmpty
                  ? Center(
                      child: Text('No Tasks Available',
                          style: TextStyle(color: Colors.grey)),
                    )
                  : ListView.builder(
                      itemCount: filteredTodos.length,
                      itemBuilder: (_, i) {
                        final todo = filteredTodos[i];
                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: ListTile(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => TodoDetailsScreen(todo: todo),
                              ),
                            ),
                            title: Text(todo.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    decoration: todo.isDone
                                        ? TextDecoration.lineThrough
                                        : null)),
                            subtitle: Text(todo.description),
                            trailing: Checkbox(
                              value: todo.isDone,
                              onChanged: (_) => ref
                                  .read(todoProvider.notifier)
                                  .toggleTodo(todo.id),
                              activeColor: primaryColor,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}