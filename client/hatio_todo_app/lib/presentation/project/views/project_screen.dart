import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/presentation/auth/bloc/auth_bloc.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
import 'package:hatio_todo_app/presentation/project/widgets/create_project_dialog.dart';
import 'package:hatio_todo_app/presentation/project/widgets/project_list_tile.dart';

class ProjectScreen extends StatefulWidget {
  const ProjectScreen({super.key});

  @override
  State<ProjectScreen> createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    projectBloc.add(InitialProjectEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Hatio | Projects'),
        actions: [
          TextButton.icon(
            label: const Text("Logout"),
            onPressed: () {
              authBloc.add(LogoutButtonPressed());
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocListener<ProjectBloc, ProjectState>(
        bloc: projectBloc,
        listener: (context, state) {
          if (state is ProjectUpdated) {
            setState(() {});
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Project updated successfully!'),
              ),
            );
          } else if (state is ProjectAdded) {
            setState(() {});
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Project added successfully!'),
              ),
            );
          } else if (state is ProjectLoadFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong! ${state.error}'),
              ),
            );
          }
        },
        child: BlocBuilder<ProjectBloc, ProjectState>(
          bloc: projectBloc,
          builder: (context, state) {
            if (state is ProjectInitial) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProjectLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ProjectLoadSuccess) {
              if (state.projects.isEmpty) {
                return const Center(
                  child: Text('No Projects yet!'),
                );
              } else {
                return listBuilder(state);
              }
            } else {
              return listBuilder(state);
            }
          },
        ),
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

  Widget listBuilder(state) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: state.projects.length,
        itemBuilder: (context, index) {
          if (index == state.projects.length - 1) {
            return Column(
              children: [
                ProjectListTile(project: state.projects[index]),
                const SizedBox(height: 80),
              ],
            );
          }
          final project = state.projects[index];
          return ProjectListTile(project: project);
        },
      ),
    );
  }
}
