import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_client.dart';
import 'todo.dart';

class TodoService {
  final ApiClient _apiClient;
  //Constructor
  TodoService(this._apiClient);
  //Read Get
  Future<List<Todo>> fetchTodos() async {
    final response = await _apiClient.get(ApiEndpoints.todos);

    return (response.data as List).map((json) => Todo.fromJson(json)).toList();
  }

  //post
  Future<Todo> addTodo(Todo newTodo) async {
    final response = await _apiClient.post(
      ApiEndpoints.todos,
      data: newTodo.toJson(),
    );

    return Todo.fromJson(response.data);
  }

  //patch (update)
  // In todo_service.dart
  Future<Todo> updateTodo(Todo updatedTodo) async {
    final response = await _apiClient.patch( // or .patch
      '${ApiEndpoints.todos}/${updatedTodo.id}',
      data: updatedTodo.toJson(), // Sends title, description, AND the status
    );
    return Todo.fromJson(response.data);
  }
  //delete
  Future<void> deleteTodo(int id)async{
    await _apiClient.delete('${ApiEndpoints.todos}/$id');

  }
}
