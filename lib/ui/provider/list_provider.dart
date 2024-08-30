import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_dm.dart';
import 'package:todo_app/ui/utils/extension.dart';

class ListProvider extends ChangeNotifier {
  DateTime selectedDateCalender = DateTime.now();
  List<TodoDM> todosList = [];

  void getTodosListFromFireStore() async {
    CollectionReference todoCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);
    QuerySnapshot querySnapShot = await todoCollection.get();
    List<QueryDocumentSnapshot> documents = querySnapShot.docs;
    // print(documents.length);
    todosList = documents.map((doc) {
      Map<String, dynamic> json = doc.data() as Map<String, dynamic>;
      return TodoDM.fromJson(json);
    }).toList();
    print(todosList);

    todosList = todosList.where((todo) =>
        // todo.date.year == selectedDateCalender.year &&
        // todo.date.month == selectedDateCalender.month &&
        // todo.date.day == selectedDateCalender.day,
        selectedDateCalender.isSameDate(todo.date)).toList(); // extension

    todosList.sort((todo1, todo2) {
      return todo1.date.compareTo(todo2.date);
    });
    notifyListeners();
  }
}
