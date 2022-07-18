import 'package:flutter/material.dart';
import 'package:fluuter_todo/models/Todo.dart';
import 'package:uuid/uuid.dart';

import 'components/TodoItem.dart';
import 'components/TodoInput.dart';

enum Filter { all, active, completed }

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Todo List'),
        ),
        body: const TodoList(),
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({Key? key}) : super(key: key);

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<Todo> todos = [
    Todo(const Uuid().v4(), 'Go to school', true),
    Todo(const Uuid().v4(), 'Have a dinner', false),
    Todo(const Uuid().v4(), 'Make a homework', false),
  ];

  Filter filter = Filter.all;

  void handleAddTodo(String text) {
    setState(() {
      todos.add(Todo(const Uuid().v4(), text, false));
    });
  }

  void handleDeleteTodo(Todo todo) {
    setState(() {
      todos.removeWhere((element) => element.id == todo.id);
    });
  }

  void handleChangeTodo(Todo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TodoInput(handleAddTodo: handleAddTodo),
          todos.isEmpty
              ? const Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text(
                      'Please add todos',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                )
              : Flexible(
                  child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: ((context, index) {
                      return TodoItem(
                        todo: todos[index],
                        handleDeleteTodo: handleDeleteTodo,
                        handleChangeTodo: handleChangeTodo,
                      );
                    }),
                  ),
                )
        ],
      ),
    );
  }
}
