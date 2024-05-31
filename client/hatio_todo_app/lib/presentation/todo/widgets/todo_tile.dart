import 'package:flutter/material.dart';
import 'package:hatio_todo_app/presentation/todo/widgets/edit_todo_dialog.dart';
import 'package:msh_checkbox/msh_checkbox.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({super.key});

  @override
  State<TodoTile> createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  var isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: MSHCheckbox(
        size: 40,
        value: isChecked,
        colorConfig: MSHColorConfig.fromCheckedUncheckedDisabled(
          checkedColor: Colors.blue,
        ),
        style: MSHCheckboxStyle.fillScaleColor,
        onChanged: (selected) {
          setState(() {
            isChecked = selected;
          });
        },
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => const EditTodoDialog(),
        );
      },
      title: const StrikeThroughText(
        text: "Todo Title",
        duration: Duration(seconds: 2),
      ),
      subtitle: const Text('Todo Description'),
      trailing: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.delete,
          color: Colors.red,
          semanticLabel: 'Delete',
        ),
        hoverColor: Colors.grey,
        highlightColor: Colors.red,
      ),
    );
  }
}

class StrikeThroughText extends StatefulWidget {
  final String text;
  final Duration duration;

  const StrikeThroughText(
      {super.key, required this.text, required this.duration});

  @override
  _StrikeThroughTextState createState() => _StrikeThroughTextState();
}

class _StrikeThroughTextState extends State<StrikeThroughText>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double textWidth;

  @override
  void initState() {
    super.initState();

    // Create a TextPainter to measure the text width
    final textPainter = TextPainter(
      text: TextSpan(text: widget.text, style: TextStyle(fontSize: 24)),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textWidth = textPainter.width;

    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: textWidth).animate(_controller)
      ..addListener(() {
        setState(() {});
      });

    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 24,
            decoration: TextDecoration.none,
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          bottom: 0,
          child: CustomPaint(
            painter: StrikeThroughPainter(_animation.value),
          ),
        ),
      ],
    );
  }
}

class StrikeThroughPainter extends CustomPainter {
  final double progress;

  StrikeThroughPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;

    final y = size.height / 2;
    final x = progress;

    canvas.drawLine(Offset(0, y), Offset(x, y), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
