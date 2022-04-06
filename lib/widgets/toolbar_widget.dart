import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({Key? key}) : super(key: key);
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt){
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unCompletedTodo = ref.watch(unCompletedTodoCountProvider);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            unCompletedTodo == 0
                ? 'All todos completed'
                : unCompletedTodo.toString() + ' Todo left',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.all)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.all;
              },
              child: const Text('All')),
        ),
        Tooltip(
          message: 'Active',
          child: TextButton(
              style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.active)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state = TodoListFilter.active;
              },
              child: const Text('Active')),
        ),
        Tooltip(
          message: 'Completed',
          child: TextButton(
              style: TextButton.styleFrom(primary: changeTextColor(TodoListFilter.completed)),
              onPressed: () {
                ref.read(todoListFilter.notifier).state =
                    TodoListFilter.completed;
              },
              child: const Text('Completed')),
        ),
      ],
    );
  }
}
