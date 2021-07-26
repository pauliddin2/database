import 'package:flutter/material.dart';
import 'package:todolist/add_taskscreen.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  Widget _buildTask(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          ListTile(
            title: Text('Task title'),
            subtitle: Text('Oct 2, 2019 * High'),
            trailing: Checkbox(
              onChanged: (value) {
                print(value);
              },
              activeColor: Theme.of(context).primaryColor,
              value: true,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To do list')),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 150),
        child: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen())),
        ),
      ),
      body: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'My tasks',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '1 of 10',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            }
            return _buildTask(index);
          }),
    );
  }
}
