class Task {
  int id;
  String name;
  bool isDone;

  Task({this.name, this.isDone = false});

  void toggleDone() {
    isDone = !isDone;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'checked': isDone ? 1 : 0,
    };
    return map;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    isDone = map['checked'] == 1 ? true : false;
  }
}
