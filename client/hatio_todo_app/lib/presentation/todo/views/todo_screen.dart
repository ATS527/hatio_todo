import 'package:flutter/material.dart';
import 'package:hatio_todo_app/data/model/project.dart';
import 'package:hatio_todo_app/presentation/project/bloc/project_bloc.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/add_todo_dialog.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key, required this.project});

  final Project project;

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _projectController = TextEditingController();

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();

  bool isEditing = false;

  @override
  void initState() {
    _projectController.text = widget.project.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: IconButton(
              icon: const Icon(Icons.share),
              onPressed: () {},
            ),
          ),
        ],
        title: Tooltip(
          key: tooltipkey,
          triggerMode: TooltipTriggerMode.manual,
          showDuration: const Duration(seconds: 1),
          message:
              "You can edit the project name here (Press enter after editing)",
          child: TextField(
            controller: _projectController,
            onSubmitted: (value) {
              setState(() {
                isEditing = false;
              });
              projectBloc.add(
                UpdateProject(
                  projectId: widget.project.id,
                  name: value,
                ),
              );
            },
            onTap: () {
              setState(() {
                isEditing = true;
              });
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
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return const TodoTile();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => const AddTodoDialog(),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Todo"),
      ),
    );
  }
}
