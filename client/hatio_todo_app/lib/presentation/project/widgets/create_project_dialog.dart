import 'package:flutter/material.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  @override
  Widget build(BuildContext context) {
    //return a bottom sheet asking for the project name and have a save or discard button
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Project Name',
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
                child: Text('Save'),
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
