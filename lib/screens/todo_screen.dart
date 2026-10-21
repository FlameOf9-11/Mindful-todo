import 'package:flutter/material.dart';
import '../models/api_client.dart';
import '../models/todo_service.dart';
import '../models/todo.dart';
import '../models/todo_filter.dart'; // Added the new file here!
import '../models/token_storage.dart';
import '../routes/app_routes.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final ApiClient _apiClient = ApiClient();
  late final TodoService _todoService;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  List<Todo> _todos = [];
  bool _isLoading = true;
  String? _errorMessage;

  TodoFilter _currentFilter = TodoFilter.all;

  //methods
  Future<void> _logout() async {
    await TokenStorage.deleteToken(); // Clears stored JWT
    //remove the email as well so the remember me button doesn't use it
    // await TokenStorage.saveRememberMe(remember: true, email: '',password: '');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.loginRoute,
        (route) => false, // Removes all back history
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _todoService = TodoService(_apiClient);
    _fetchTodos();
    //test for 401 code

    //  TokenStorage.saveToken("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjMsImVtYWlsIjoieW91c2ZAZ3MuY29tIiwiaWF0IjoxNzkyMzkyODMwLCJleHAiOjE3OTIzOTMxMzB9.Mc8caVW9Rl9BEK6MRLTKzgaEGcqP_NvPJgE67Kldr2A").then((_) {

    //  });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  // --- FRONTEND FILTER LOGIC ---
  List<Todo> get _filteredTodos {
    // We deleted the long switch statement from here.
    // Now, we just ask our new helper file to do the work!
    return TodoFilterHelper.getFilteredList(_todos, _currentFilter);
  }

  // --- CRUD METHODS ---

  Future<void> _fetchTodos({bool showLoader = true}) async {
    if (showLoader) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    try {
      final fetched = await _todoService.fetchTodos();
      setState(() {
        _todos = fetched;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _addTodo() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) return;

    try {
      final newTodo = Todo(
        todoTitle: title,
        description: desc.isNotEmpty ? desc : null,
      );
      final created = await _todoService.addTodo(newTodo);

      setState(() {
        _todos.insert(0, created);
      });

      _titleController.clear();
      _descController.clear();
      FocusScope.of(context).unfocus();
    } catch (e) {
      _showErrorSnackBar('Failed to add task: $e');
    }
  }

  Future<void> _toggleStatus(Todo todo) async {
    if (todo.id == null) return;

    final originalIndex = _todos.indexWhere((t) => t.id == todo.id);
    if (originalIndex == -1) return;

    final originalTodo = _todos[originalIndex];
    final toggledTodo = originalTodo.copyWith(
      isCompleted: !originalTodo.isCompleted,
    );

    setState(() {
      _todos[originalIndex] = toggledTodo;
    });

    try {
      final updatedTodo = await _todoService.updateTodo(toggledTodo);

      setState(() {
        final verifyIndex = _todos.indexWhere((t) => t.id == updatedTodo.id);
        if (verifyIndex != -1) {
          _todos[verifyIndex] = updatedTodo;
        }
      });
    } catch (e) {
      setState(() {
        final revertIndex = _todos.indexWhere((t) => t.id == originalTodo.id);
        if (revertIndex != -1) {
          _todos[revertIndex] = originalTodo;
        }
      });
      _showErrorSnackBar('Failed to update status: $e');
    }
  }

  Future<void> _deleteTodo(int id) async {
    try {
      await _todoService.deleteTodo(id);
      setState(() {
        _todos.removeWhere((t) => t.id == id);
      });
    } catch (e) {
      _showErrorSnackBar('Failed to delete: $e');
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.redAccent),
    );
  }

  // --- UI WIDGETS ---

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1F22),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ✅ AFTER: Tasks title on the left, Logout icon on the right
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Tasks',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1B1D1C),
                                letterSpacing: -0.5,
                              ),
                            ),
                            IconButton(
                              tooltip: 'Log Out',
                              splashRadius: 20,
                              icon: const Icon(
                                Icons.logout_rounded,
                                size: 22,
                                color: Color(
                                  0xFF6B7B72,
                                ), // Matches input hint / secondary tone
                              ),
                              onPressed: () {
                                // Optional: Show a quick confirmation dialog before logging out
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Log Out'),
                                    content: const Text(
                                      'Are you sure you want to log out?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(ctx),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(ctx);
                                          _logout();
                                        },
                                        child: const Text(
                                          'Log Out',
                                          style: TextStyle(
                                            color: Colors.redAccent,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildInputCard(),
                        const SizedBox(height: 16),
                        _buildFilterBar(),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                    color: Color(0xFFECEFEF),
                  ),
                  Expanded(child: _buildTaskList()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F4),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.add, size: 20, color: Color(0xFF6B7B72)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: _titleController,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF232B27),
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Task title...',
                          hintStyle: TextStyle(
                            color: Color(0xFF8B9890),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                        onSubmitted: (_) => _addTodo(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Padding(
                  padding: const EdgeInsets.only(left: 28),
                  child: TextField(
                    controller: _descController,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF45504A),
                    ),
                    decoration: const InputDecoration(
                      hintText: 'Add description or notes...',
                      hintStyle: TextStyle(
                        color: Color(0xFFA0ABA5),
                        fontSize: 13,
                      ),
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: InputBorder.none,
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          InkWell(
            onTap: _addTodo,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF345444),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6F4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildFilterButton('All', TodoFilter.all),
          _buildFilterButton('Not Completed', TodoFilter.notCompleted),
          _buildFilterButton('Completed', TodoFilter.completed),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String text, TodoFilter filterType) {
    final isSelected = _currentFilter == filterType;

    return GestureDetector(
      onTap: () {
        setState(() {
          _currentFilter = filterType;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? const Color(0xFF232B27)
                : const Color(0xFF6B7B72),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskList() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: Color(0xFF345444)),
      );
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 13),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _fetchTodos,
                child: const Text(
                  'Try Again',
                  style: TextStyle(color: Color(0xFF345444)),
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredTodos.isEmpty) {
      return const Center(
        child: Text(
          'No tasks match this filter.',
          style: TextStyle(color: Color(0xFF9AA49E), fontSize: 14),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: _filteredTodos.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final todo = _filteredTodos[index];

        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFAFBFB),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8ECE9)),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 2,
            ),
            leading: Checkbox(
              activeColor: const Color(0xFF345444),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              value: todo.isCompleted,
              onChanged: (_) => _toggleStatus(todo),
            ),
            title: Text(
              todo.todoTitle,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: todo.isCompleted
                    ? const Color(0xFFA5AEA8)
                    : const Color(0xFF252D29),
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: todo.description != null && todo.description!.isNotEmpty
                ? Text(
                    todo.description!,
                    style: TextStyle(
                      fontSize: 12,
                      color: todo.isCompleted
                          ? const Color(0xFFB8C0BA)
                          : const Color(0xFF6B7770),
                    ),
                  )
                : null,
            trailing: IconButton(
              icon: const Icon(
                Icons.close_rounded,
                size: 20,
                color: Color(0xFFA7B1AA),
              ),
              splashRadius: 18,
              onPressed: () {
                if (todo.id != null) {
                  _deleteTodo(todo.id!);
                }
              },
            ),
          ),
        );
      },
    );
  }
}
