import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_todo_app/future_provider.dart';
import 'package:flutter_riverpod_todo_app/providers/all_providers.dart';
import 'package:flutter_riverpod_todo_app/widgets/title_widget.dart';
import 'package:flutter_riverpod_todo_app/widgets/todo_list_item_widget.dart';
import 'package:flutter_riverpod_todo_app/widgets/toolbar_widget.dart';

class TodoApp extends ConsumerWidget {
  TodoApp({Key? key}) : super(key: key);
  final newTodoController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _allTodos = ref.watch(filteredTodoList);
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        children: [
          const TitleWidget(),
          TextField(
            controller: newTodoController,
            decoration:
                const InputDecoration(labelText: 'Neler yapacaksın bugün?'),
            onSubmitted: (newTodo) {
              ref.read(todoListProvider.notifier).addTodo(newTodo);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ToolBarWidget(),
          _allTodos.isEmpty
              ? const Center(child: Text('Herhangi bir görev yok'))
              : const SizedBox(),
          for (var i = 0; i < _allTodos.length; i++)
            Dismissible(
              onDismissed: (_) {
                ref.read(todoListProvider.notifier).remove(_allTodos[i]);
              },
              key: ValueKey(_allTodos[i].id),
              child: ProviderScope(overrides: [
                currentTodoProvider.overrideWithValue(_allTodos[i])
              ], child: const TodoListItemWidget()),
            ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.orange),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const FutureProviderExample()));
              },
              child: const Text('Future Provider Example'))
        ],
      ),
    );
  }
}
