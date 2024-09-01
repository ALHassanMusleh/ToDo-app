import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/app_user.dart';

class TodoDM {
  static const String collectionName = 'todo';
  late String id;
  late String title;
  late String description;
  late DateTime date;
  late bool isDone;

  static CollectionReference get userTodosCollection => FirebaseFirestore.instance
      .collection(AppUser.collectionName)
      .doc(AppUser.currentUser!.id)
      .collection(TodoDM.collectionName);

  TodoDM({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.isDone,
  });

  TodoDM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['description'];
    description = json['description'];
    Timestamp timestamp = json['date'];
    date = timestamp.toDate();
    isDone = json['isDone'];
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "date": date,
        "isDone": isDone,
      };
}
