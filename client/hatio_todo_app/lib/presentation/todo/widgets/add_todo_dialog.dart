import 'package:flutter/material.dart';

class AddTodoDialog extends StatefulWidget {
  const AddTodoDialog({super.key});

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Todo Title',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          const TextField(
            decoration: InputDecoration(
              hintText: 'Todo Description',
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  //save the project
                  
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
