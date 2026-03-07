import 'package:flutter/material.dart';
import 'package:repository_template/common/colors/app_colors.dart';
import 'package:repository_template/common/typography/app_typography.dart';
import 'package:repository_template/domain/entites/todo_entity.dart';

class TodoInfoScreen extends StatefulWidget {
  const TodoInfoScreen({super.key, this.todo});

  final TodoEntity? todo;

  @override
  State<TodoInfoScreen> createState() => _TodoInfoScreenState();
}

class _TodoInfoScreenState extends State<TodoInfoScreen> {
  late final TextEditingController _nameController;
  late bool _isCompleted;

  bool get _isEditing => widget.todo != null;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.todo?.title ?? '');
    _isCompleted = widget.todo?.isCompleted ?? false;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _save() {
    final title = _nameController.text.trim();
    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите название задачи')),
      );
      return;
    }

    final todo = TodoEntity(
      id: widget.todo?.id ?? -1,
      title: title,
      isCompleted: _isCompleted,
    );

    Navigator.of(context).pop(todo);
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white, width: 1),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _save,
        backgroundColor: AppColors.gray,
        child: const Icon(Icons.check, color: AppColors.white),
      ),
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Редактирование' : 'Новая задача',
          style: AppTypography.bold16,
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Text('Название', style: AppTypography.bold16),
              const SizedBox(height: 8),
              TextField(
                controller: _nameController,
                style: AppTypography.regular14,
                autofocus: !_isEditing,
                decoration: InputDecoration(
                  hintText: 'Введите название задачи',
                  hintStyle: AppTypography.regular14.copyWith(
                    color: AppColors.gray,
                  ),
                  border: border,
                  enabledBorder: border,
                  focusedBorder: border,
                ),
              ),
              if (_isEditing) ...[
                const SizedBox(height: 24),
                CheckboxListTile(
                  value: _isCompleted,
                  onChanged: (value) {
                    setState(() {
                      _isCompleted = value ?? false;
                    });
                  },
                  title: const Text('Выполнено', style: AppTypography.regular14),
                  checkColor: AppColors.black,
                  activeColor: AppColors.white,
                  side: const BorderSide(color: AppColors.white),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
