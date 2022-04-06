import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';
import '../models/todo_model.dart';

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: 'Spora git'),
    TodoModel(id: const Uuid().v4(), description: 'Alışverişe git'),
    TodoModel(id: const Uuid().v4(), description: 'Okula git'),
    TodoModel(id: const Uuid().v4(), description: 'Havaalanından kızını al'),
  ]);
});

final unCompletedTodoCountProvider = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.active:
      return todoList.where((element) => !element.completed).toList();
    case TodoListFilter.completed:
      return todoList.where((element) => element.completed).toList();
  }
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});

enum TodoListFilter { all, active, completed }

final todoListFilter = StateProvider((ref) => TodoListFilter.all);
