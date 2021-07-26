import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolistflutter/models/task_data.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String inputTask;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 40.0,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add Task',
                style: TextStyle(
                  color: Colors.lightBlueAccent,
                  fontSize: 30.0,
                ),
                textAlign: TextAlign.center,
              ),
              TextField(
                maxLength: 50,
                onChanged: (text) {
                  inputTask = text;
                },
                autofocus: true,
                autocorrect: false,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              FlatButton(
                padding: EdgeInsets.symmetric(vertical: 15.0),
                color: Colors.lightBlueAccent,
                onPressed: () {
                  if (inputTask == null) {
                    return;
                  }
                  Provider.of<TaskData>(context, listen: false)
                      .addData(inputTask);
                  Navigator.pop(context);
                },
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
