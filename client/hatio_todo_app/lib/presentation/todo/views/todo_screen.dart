import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hatio_todo_app/data/model/project.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/add_todo_dialog.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/todo_list_tile.dart';

import 'dart:html' as html;

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.project});

  final Project project;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _projectController = TextEditingController();

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  List<dynamic> todoList = [];

  @override
  void initState() {
    _projectController.text = widget.project.title;
    super.initState();
  }

  void createAndDownloadFile(String content, String filename) {
    final bytes = html.Blob([content], 'text/plain', 'native');
    final url = html.Url.createObjectUrlFromBlob(bytes);
    html.AnchorElement(href: url)
      ..setAttribute('download', filename)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  String generateContent(List<dynamic> todos) {
    if (todos.isEmpty) {
      return """
# ${_projectController.text}

**Summary:** 0/0 todos completed

<h3>Pending</h3>
<h3>Completed</h3>
      """;
    }

    String pending = "";
    String completed = "";
    for (var todo in todos) {
      if (todo.status) {
        completed += '<input type="checkbox" checked> ${todo.title}<br>';
      } else {
        pending += '<input type="checkbox"> ${todo.title}<br>';
      }
    }
    return """
#${_projectController.text}

**Summary:** ${todos.where((todo) => todo.status).length}/${todos.length} todos completed

<h3>Pending</h3>

$pending

<h3>Completed</h3>
$completed
""";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Tooltip(
              message:
                  "Download Markdown, so that you can import to github readme",
              child: TextButton.icon(
                label: const Text(
                  "Download Markdown",
                ),
                icon: const Icon(Icons.share),
                onPressed: () {
                  createAndDownloadFile(generateContent(todoList), "todos.md");
                },
              ),
            ),
          ),
        ],
        title: Tooltip(
          key: tooltipkey,
          preferBelow: true,
          triggerMode: TooltipTriggerMode.manual,
          showDuration: const Duration(seconds: 1),
          message:
              "You can edit the project name here (Press enter after editing)",
          child: TextField(
            controller: _projectController,
            onSubmitted: (value) {
              projectBloc.add(
                UpdateProject(
                  projectId: widget.project.id,
                  name: value,
                ),
              );
            },
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: BlocListener<TodoBloc, TodoState>(
        bloc: todoBloc,
        listener: (context, state) {
          if (state is TodoLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Something went wrong! ${state.error}'),
              ),
            );
          }
          if (state is TodoAdded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Todo Added!'),
              ),
            );
          }
          if (state is TodoUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Todo Updated!'),
              ),
            );
          }
          if (state is TodoDeleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Todo Deleted!'),
              ),
            );
          }
        },
        child: BlocBuilder<TodoBloc, TodoState>(
          bloc: todoBloc,
          builder: (context, state) {
            if (state is TodoInitial) {
              todoBloc.add(
                InitialTodoEvent(
                  projectId: widget.project.id,
                ),
              );
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TodoLoadSuccess) {
              return loadList(state);
            } else if (state is TodoAdded) {
              return loadList(state);
            } else if (state is TodoUpdated) {
              return loadList(state);
            } else if (state is TodoDeleted) {
              return loadList(state);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => AddTodoDialog(
              projectId: widget.project.id,
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Todo"),
      ),
    );
  }

  Widget loadList(state) {
    final todos = state.todos;
    if (todos.isEmpty) {
      return const Center(
        child: Text('No Todos yet!'),
      );
    } else {
      todoList = todos;
      return ListView.builder(
        itemCount: state.todos.length,
        itemBuilder: (context, index) {
          if (index == state.todos.length - 1) {
            return Column(
              children: [
                TodoTile(todo: todos[index], projectId: widget.project.id),
                const SizedBox(height: 80),
              ],
            );
          }
          return TodoTile(
            todo: todos[index],
            projectId: widget.project.id,
          );
        },
      );
    }
  }
}
