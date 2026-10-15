class Todo {

  final int? id; 
  

  final String todoTitle;
  final String? description;
  final bool isCompleted;

  Todo({
    this.id,
    required this.todoTitle,
    this.description,
    this.isCompleted = false, 
  });

  // READ from Server
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      
      id: json['id'] as int?,
      todoTitle: json['todoTitle'] as String? ?? 'Untitled', 
      description: json['description'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'todoTitle': todoTitle,
      'description': description,
      'isCompleted': isCompleted,
    };
  }


  Todo copyWith({
    int? id,
    String? todoTitle,
    String? description,
    bool? isCompleted,
  }) {
    return Todo(
      id: id ?? this.id,
      todoTitle: todoTitle ?? this.todoTitle,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() => "Todo(id: $id, todo_title: $todoTitle, isCompleted: $isCompleted)";
}