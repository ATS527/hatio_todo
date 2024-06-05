import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key, required this.projectId});

  final String projectId;

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  final TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              hintText: 'Todo Title',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  todoBloc.add(
                    AddTodoButtonPressed(
                      name: _nameController.text,
                      projectId: widget.projectId,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  //discard the project
                  Navigator.of(context).pop();
                },
                child: const Text('Discard'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
