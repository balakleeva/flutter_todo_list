import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({
    Key? key,
    required this.handleAddTodo,
  }) : super(key: key);

  final Function(String) handleAddTodo;

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final todoTextController = TextEditingController();

  void handleAddTodo() {
    if (_formKey.currentState!.validate()) {
      widget.handleAddTodo(todoTextController.text);
      todoTextController.clear();
    }
  }

  @override
  void dispose() {
    todoTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: TextFormField(
                controller: todoTextController,
                decoration: const InputDecoration(
                  hintText: 'Enter your todo',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please add todo title';
                  }

                  return null;
                },
              ),
            ),
            IconButton(
                onPressed: handleAddTodo,
                icon: const Icon(
                  Icons.add,
                  color: Colors.blueAccent,
                )),
          ],
        ));
  }
}
