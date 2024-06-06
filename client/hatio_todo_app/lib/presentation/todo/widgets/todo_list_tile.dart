import 'package:flutter/material.dart';
import 'package:hatio_todo_app/data/model/todo.dart';
import 'package:hatio_todo_app/presentation/todo/bloc/todo_bloc.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    super.key,
    required this.todo,
    required this.projectId,
  });

  final Todo todo;
  final String projectId;

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  late bool isChecked;
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    isChecked = widget.todo.status;
    _nameController.text = widget.todo.title;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Card(
          shape: const RoundedRectangleBorder(
            side: BorderSide(
              color: Colors.black,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          borderOnForeground: true,
          color: isChecked ? Colors.green[50] : Colors.orange[50],
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            leading: MSHCheckbox(
              size: 26,
              value: isChecked,
              colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
                checkedColor: Colors.blue,
              ),
              style: MSHCheckboxStyle.stroke,
              duration: const Duration(milliseconds: 200),
              onChanged: (selected) {
                setState(() {
                  isChecked = selected;
                });
                todoBloc.add(
                  UpdateTodoStatus(
                    todoId: widget.todo.id,
                    projectId: widget.projectId,
                    status: isChecked,
                  ),
                );
              },
            ),
            title: TextField(
              controller: _nameController,
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  todoBloc.add(
                    UpdateTodo(
                      projectId: widget.projectId,
                      name: value,
                      todoId: widget.todo.id,
                    ),
                  );
                } else {
                  _nameController.text = widget.todo.title;
                }
              },
              decoration: const InputDecoration(
                hintText: 'Update Todo Name',
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(0),
              ),
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                decoration: isChecked ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              "Last Updated at: ${widget.todo.updatedAt?.day}/${widget.todo.updatedAt?.month}/${widget.todo.updatedAt?.year}",
              style: const TextStyle(
                overflow: TextOverflow.clip,
              ),
            ),
            //show timestamp
            trailing: IconButton(
              onPressed: () {
                todoBloc.add(
                  DeleteTodo(
                    todoId: widget.todo.id,
                    projectId: widget.projectId,
                  ),
                );
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
                semanticLabel: 'Delete',
              ),
              hoverColor: Colors.grey,
              highlightColor: Colors.red,
            ),
          ),
        ),
      ),
    );
  }
}
