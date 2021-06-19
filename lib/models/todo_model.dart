class ToDoModel {
  String title;
  int userId;
  int id;
  bool completed;

  ToDoModel({this.title, this.userId, this.id, this.completed});

  factory ToDoModel.fromMap(Map map) {
    return ToDoModel(
      title: map["title"],
      id: map["id"],
      userId: map["userId"],
      completed: map["completed"],
    );
  }
}
