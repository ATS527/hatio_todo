import 'package:flutter/material.dart';
import 'package:hatio_todo_app/data/model/project.dart';
import 'package:hatio_todo_app/presentation/todo/views/todo_screen.dart';
import 'package:lottie/lottie.dart';

class ProjectListTile extends StatefulWidget {
  const ProjectListTile({super.key, required this.project});

  final Project project;

  @override
  State<ProjectListTile> createState() => _ProjectListTileState();
}

class _ProjectListTileState extends State<ProjectListTile> {
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
          color: Colors.teal[50],
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            leading:
                Lottie.asset("assets/animations/project_bullet_animation.json"),
            title: Text(
              widget.project.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.clip,
              ),
            ),
            subtitle: Text(
              "${widget.project.todoIds?.length} Todos",
              style: const TextStyle(
                overflow: TextOverflow.clip,
              ),
            ),

            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return TodoScreen(project: widget.project);
                  },
                ),
              ).then((_) {
                setState(() {});
              });
            },
            //show timestamp
            trailing: Text(
              // format time by day month and year
              "Updated at: ${widget.project.updatedAt?.day}/${widget.project.updatedAt?.month}/${widget.project.updatedAt?.year}",
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
