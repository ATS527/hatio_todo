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

  // @override
  // Widget build(BuildContext context) {
  //   return ListTile(
  //     contentPadding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
  //     leading: MSHCheckbox(
  //       size: 26,
  //       value: isChecked!,
  //       colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
  //         checkedColor: Colors.blue,
  //       ),
  //       style: MSHCheckboxStyle.stroke,
  //       duration: const Duration(milliseconds: 200),
  //       onChanged: (selected) {
  //         setState(() {
  //           isChecked = selected;
  //         });
  //         todoBloc.add(
  //           UpdateTodoStatus(
  //             todoId: widget.todo.id,
  //             projectId: widget.projectId,
  //             status: isChecked!,
  //           ),
  //         );
  //       },
  //     ),
  //     title: TextField(
  //         controller: _nameController,
  //         onSubmitted: (value) {
  //           todoBloc.add(
  //             UpdateTodo(
  //               projectId: widget.projectId,
  //               name: value,
  //               todoId: widget.todo.id,
  //             ),
  //           );
  //         },
  //         decoration: const InputDecoration(
  //           hintText: 'Update Todo Name',
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.all(0),
  //         ),
  //         style: TextStyle(
  //           fontSize: 18,
  //           color: Colors.black,
  //           decoration: isChecked! ? TextDecoration.lineThrough : null,
  //         )),
  //     trailing: IconButton(
  //       onPressed: () {
  //         todoBloc.add(
  //           DeleteTodo(
  //             todoId: widget.todo.id,
  //             projectId: widget.projectId,
  //           ),
  //         );
  //       },
  //       icon: const Icon(
  //         Icons.delete,
  //         color: Colors.red,
  //         semanticLabel: 'Delete',
  //       ),
  //       hoverColor: Colors.grey,
  //       highlightColor: Colors.red,
  //     ),
  //   );
  // }
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
                todoBloc.add(
                  UpdateTodo(
                    projectId: widget.projectId,
                    name: value,
                    todoId: widget.todo.id,
                  ),
                );
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

// import 'package:flutter/material.dart';
// import 'package:hatio_todo_app/data/model/project.dart';
// import 'package:hatio_todo_app/presentation/todo/views/todo_screen.dart';

// class ProjectListTile extends StatefulWidget {
//   const ProjectListTile({super.key, required this.project});

//   final Project project;

//   @override
//   State<ProjectListTile> createState() => _ProjectListTileState();
// }

// class _ProjectListTileState extends State<ProjectListTile> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
//         child: Card(
//           shape: const RoundedRectangleBorder(
//             side: BorderSide(
//               color: Colors.black,
//               width: 1.0,
//             ),
//             borderRadius: BorderRadius.all(
//               Radius.circular(10),
//             ),
//           ),
//           borderOnForeground: true,
//           color: Colors.orange[50],
//           child: ListTile(
//             contentPadding:
//                 const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
//             leading: CircleAvatar(
//               backgroundColor: Colors.red,
//               radius: 30,
//               backgroundImage: const AssetImage(
//                 "assets/images/list_bullet.jpg",
//               ),
//               onBackgroundImageError: (exception, stackTrace) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(
//                     content: Text("Error loading image"),
//                   ),
//                 );
//               },
//             ),
//             title: Text(
//               widget.project.title,
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//                 overflow: TextOverflow.clip,
//               ),
//             ),
//             subtitle: Text(
//               "${widget.project.todoIds?.length} Todos",
//               style: const TextStyle(
//                 overflow: TextOverflow.clip,
//               ),
//             ),

//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) {
//                     return TodoScreen(project: widget.project);
//                   },
//                 ),
//               );
//             },
//             //show timestamp
//             trailing: Text(
//               // format time by day month and year
//               "Updated at: ${widget.project.updatedAt?.day}/${widget.project.updatedAt?.month}/${widget.project.updatedAt?.year}",
//               style: const TextStyle(
//                 fontSize: 10,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

