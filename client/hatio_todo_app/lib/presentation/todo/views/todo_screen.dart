import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/todo_tile.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final TextEditingController _projectController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _projectController.text = "Project Name";
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
              onPressed: () {
                print("Sharing success");
              },
            ),
          ),
        ],
        title: EditableText(
          controller: _projectController,
          focusNode: FocusNode(),
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
          ),
          showCursor: false,
          cursorColor: Colors.black,
          backgroundCursorColor: Colors.black,
          onEditingComplete: () {
            print("completed");
          },
        ),
      ),
      body: ListView.builder(
        itemCount: 100,
        itemBuilder: (context, index) {
          return TodoTile();
        },
      ),
    );
  }
}
