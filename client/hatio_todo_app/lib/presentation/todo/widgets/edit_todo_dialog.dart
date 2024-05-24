import 'package:flutter/material.dart';

class EditTodoDialog extends StatefulWidget {
  const EditTodoDialog({super.key});

  @override
  State<EditTodoDialog> createState() => _EditTodoDialogState();
}

class _EditTodoDialogState extends State<EditTodoDialog> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Todo Description',
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  //save the project
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  //discard the project
                  Navigator.of(context).pop();
                },
                child: Text('Discard'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
