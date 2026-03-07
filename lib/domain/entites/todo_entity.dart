class TodoEntity {
  TodoEntity({required this.id, required this.title, required this.isCompleted});

  final int id;
  final String title;
  final bool isCompleted;

  static TodoEntity empty() => TodoEntity(id: -1, title: '', isCompleted: false);

  TodoEntity copyWith({
    int? id,
    String? title,
    bool? isCompleted,
}){
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
