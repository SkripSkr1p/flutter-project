import 'package:flutter/material.dart';
import 'package:repository_template/common/colors/app_colors.dart';
import 'package:repository_template/common/typography/app_typography.dart';
import 'package:repository_template/domain/entites/todo_entity.dart';
import 'package:repository_template/ui/screens/todo/todo_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<TodoEntity> _todos = [];
  int _nextId = 0;

  void _addTodo() => _openTodoScreen();

  Future<void> _openTodoScreen({TodoEntity? todo}) async {
    final result = await Navigator.of(context).push<TodoEntity>(
      MaterialPageRoute(
        builder: (_) => TodoInfoScreen(todo: todo),
      ),
    );

    if (result == null) return;

    setState(() {
      if (todo != null) {
        final index = _todos.indexWhere((t) => t.id == todo.id);
        if (index != -1) {
          _todos[index] = result;
        }
      } else {
        _todos.add(result.copyWith(id: _nextId++));
      }
    });
  }

  void _toggleTodo(int index) {
    setState(() {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
    });
  }

  void _deleteTodo(int index) {
    final removed = _todos[index];
    setState(() {
      _todos.removeAt(index);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('«${removed.title}» удалено'),
        action: SnackBarAction(
          label: 'Отменить',
          onPressed: () {
            setState(() {
              _todos.insert(index, removed);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo list', style: AppTypography.bold16),
        actions: [
          IconButton(
            onPressed: _addTodo,
            icon: const Icon(Icons.add, color: AppColors.white),
          ),
        ],
      ),
      body: _todos.isEmpty
          ? const Center(
              child: Text(
                'Нет задач.\nНажмите + чтобы добавить.',
                style: AppTypography.regular14,
                textAlign: TextAlign.center,
              ),
            )
          : ListView.builder(
              itemCount: _todos.length,
              itemBuilder: (context, index) {
                final todo = _todos[index];
                return Dismissible(
                  key: ValueKey(todo.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    color: Colors.red,
                    child: const Icon(Icons.delete, color: AppColors.white),
                  ),
                  onDismissed: (_) => _deleteTodo(index),
                  child: ListTile(
                    onTap: () => _openTodoScreen(todo: todo),
                    leading: Checkbox(
                      value: todo.isCompleted,
                      onChanged: (_) => _toggleTodo(index),
                      checkColor: AppColors.black,
                      activeColor: AppColors.white,
                      side: const BorderSide(color: AppColors.white),
                    ),
                    title: Text(
                      todo.title,
                      style: AppTypography.regular14.copyWith(
                        decoration: todo.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: todo.isCompleted
                            ? AppColors.gray
                            : AppColors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
