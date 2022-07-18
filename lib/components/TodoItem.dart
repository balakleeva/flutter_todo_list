import 'package:flutter/material.dart';
import 'package:fluuter_todo/models/Todo.dart';

class TodoItem extends StatelessWidget {
  const TodoItem(
      {Key? key,
      required this.todo,
      required this.handleDeleteTodo,
      required this.handleChangeTodo})
      : super(key: key);

  final Todo todo;
  final Function(Todo) handleDeleteTodo;
  final Function(Todo) handleChangeTodo;

  void handleClick() {
    handleDeleteTodo(todo);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              handleChangeTodo(todo);
            },
            child: Text(
              todo.title,
              style: TextStyle(
                  fontSize: 20,
                  decoration: todo.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
          IconButton(
              onPressed: handleClick,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
