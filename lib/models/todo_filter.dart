import 'todo.dart'; // We need this to know what a 'Todo' is

// 1. We moved the choices (enum) here
enum TodoFilter { all, notCompleted, completed }

// 2. We moved the filtering logic into a Helper class
class TodoFilterHelper {
  
  // This function takes your full list of tasks and your current filter choice,
  // and returns a new, filtered list.
  static List<Todo> getFilteredList(List<Todo> allTodos, TodoFilter filter) {
    switch (filter) {
      case TodoFilter.notCompleted:
        return allTodos.where((t) => !t.isCompleted).toList();
      case TodoFilter.completed:
        return allTodos.where((t) => t.isCompleted).toList();
      case TodoFilter.all:
      default:
        return allTodos;
    }
  }
}