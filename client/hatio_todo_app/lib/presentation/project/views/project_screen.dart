import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
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
              authBloc.add(LogoutButtonPressed());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        builder: (context, state) {
          if (state is ProjectInitial) {
            projectBloc.add(
              InitialProjectEvent(),
            );
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProjectLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ProjectLoadSuccess) {
            return ListView.builder(
              itemCount: state.projects.length,
              itemBuilder: (context, index) {
                final project = state.projects[index];
                return ListTile(
                  title: Text(project.title),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TodoScreen(project: project),
                      ),
                    );
                  },
                );
              },
            );
          } else if (state is ProjectLoadFailure) {
            return Center(
              child: Text('Something went wrong! ${state.error}'),
            );
          } else {
            return const Center(
              child: Text("Invalid state"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const CreateProjectDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Create a new Project'),
      ),
    );
  }
}
