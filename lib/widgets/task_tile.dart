import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String text;
  final bool checked;
  final Function toggleCheckbox;
  final Function textTouch;
  final Function deleteTask;

  TaskTile(
      {this.text,
      this.checked,
      this.toggleCheckbox,
      this.textTouch,
      this.deleteTask});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: deleteTask,
      onTap: textTouch,
      child: ListTile(
          title: Text(text,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                decoration: checked ? TextDecoration.lineThrough : null,
              )),
          trailing: Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: checked,
            onChanged: toggleCheckbox,
          )),
    );
  }
}
