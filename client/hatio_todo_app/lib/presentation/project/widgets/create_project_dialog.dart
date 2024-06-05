import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';

class CreateProjectDialog extends StatefulWidget {
  const CreateProjectDialog({super.key});

  @override
  State<CreateProjectDialog> createState() => _CreateProjectDialogState();
}

class _CreateProjectDialogState extends State<CreateProjectDialog> {
  final TextEditingController _projectNameController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //return a bottom sheet asking for the project name and have a save or discard button
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Create a new Project',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          TextField(
            controller: _projectNameController,
            decoration: const InputDecoration(
              hintText: 'Project Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.green),
                ),
                onPressed: () {
                  projectBloc.add(
                    AddProjectButtonPressed(
                      name: _projectNameController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Create',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.red),
                ),
                onPressed: () {
                  _projectNameController.clear();
                  Navigator.of(context).pop();
                },
                child: const Padding(
                  padding: EdgeInsets.all(14.0),
                  child: Text(
                    'Discard',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
