import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/project/widgets/create_project_dialog.dart';
import 'package:hatio_todo_app/presentation/todo/views/todo_screen.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutButtonPressed());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 100,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Project $index'),
              subtitle: Text('Project Description $index'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const TodoScreen(),
                  ),
                );
              },
            );
          }),
      floatingActionButton: Expanded(
        child: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => const CreateProjectDialog(),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Create a new Project'),
        ),
      ),
    );
  }
}
