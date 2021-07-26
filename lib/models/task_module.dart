class Task {
  int id;

  String title;

  DateTime date;

  String priority;

  int status;

  Task(
      {required this.id,
      required this.date,
      required this.title,
      required this.priority,
      required this.status});

  Task.withId(
      {required this.id,
      required this.date,
      required this.title,
      required this.priority,
      required this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['status'] = status;
    map['priority'] = priority;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
        id: map['id'],
        date: DateTime.parse(map['date']),
        title: map['title'],
        priority: map['priority'],
        status: map['status']);
  }
}