import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formKey = GlobalKey<FormState>();

  String title = '';
  String priority = '';
  DateTime _date = DateTime.now();
  TextEditingController _dateController = TextEditingController();

  final List<String> priorities = ['Low', 'Medium', 'High', 'Critical'];

  initState() {
    super.initState();
    _dateController.text = DateFormat('MMM dd, yy').format(_date);
  }

  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  _handleDatepicker() async {
    final DateTime? date = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: DateTime(2021),
        lastDate: DateTime(2100));

    if (date != null && date != _date) {
      setState(() {
        _date = date;
      });
      _dateController.text = DateFormat('MMM dd, yy').format(date);
    }
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print('$_date, $title, $priority');

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40, vertical: 80),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    size: 30,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Add task',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              labelText: 'Title',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            validator: (input) => input!.trim().isEmpty
                                ? 'Task title is reqired'
                                : null,
                            onSaved: (input) => title = input!,
                            initialValue: title,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: TextFormField(
                            readOnly: true,
                            controller: _dateController,
                            style: TextStyle(fontSize: 18),
                            onTap: _handleDatepicker,
                            decoration: InputDecoration(
                              labelText: 'Date',
                              labelStyle: TextStyle(fontSize: 18),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: DropdownButtonFormField(
                              isDense: true,
                              items: priorities.map((String priority) {
                                return DropdownMenuItem(
                                    value: priority,
                                    child: Text(priority,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18)));
                              }).toList(),
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                  labelText: 'Select priority',
                                  labelStyle: TextStyle(fontSize: 18),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              validator: (input) {
                                if (input == null) {
                                  return 'Priority is needed';
                                }
                              },
                              onChanged: (value) {
                                setState(() {
                                  value = priority;
                                });
                              },
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 20),
                          height: 60,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Theme.of(context).primaryColor),
                          child: TextButton(
                            child: Text('Add',
                                style: TextStyle(
                                  color: Colors.white,
                                )),
                            onPressed: _submit,
                          ),
                        )
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
