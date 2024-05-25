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
    // TODO: implement dispose
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
          TextField(
            controller: _projectNameController,
            decoration: const InputDecoration(
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
                  projectBloc.add(
                    AddProjectButtonPressed(
                      name: _projectNameController.text,
                    ),
                  );
                  Navigator.of(context).pop();
                },
                child: const Text('Save'),
              ),
              ElevatedButton(
                onPressed: () {
                  //discard the
                  _projectNameController.clear();
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
