import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/model/todo_dm.dart';
import 'package:todo_app/ui/screens/home_screen/tabs/list/todo.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import 'package:todo_app/ui/utils/date_time_extension.dart';

class ListTab extends StatefulWidget {
  const ListTab({super.key});

  @override
  State<ListTab> createState() => _ListTabState();
}

class _ListTabState extends State<ListTab> {
  DateTime selectedDateCalender = DateTime.now();
  List<TodoDM> todosList = [];

  @override
  Widget build(BuildContext context) {
    getTodosListFromFireStore();
    return Column(
      children: [
        buildCalender(),
        Expanded(
          flex: 75,
          child: ListView.builder(
            itemCount: todosList.length,
            itemBuilder: (context, index) {
              return Todo(
                todoDM: todosList[index],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget buildCalender() => Expanded(
        flex: 25,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    color: AppColors.primary,
                  ),
                ),
                Expanded(
                  child: Container(
                    color: AppColors.bgColor,
                  ),
                ),
              ],
            ),
            EasyInfiniteDateTimeLine(
              firstDate: DateTime.now().subtract(Duration(days: 365)),
              focusDate: selectedDateCalender,
              lastDate: DateTime.now().add(Duration(days: 365)),
              onDateChange: (selectedDate) {
                selectedDateCalender = selectedDate;
                setState(() {});
              },
              itemBuilder: (context, date, isSelected, onDateTabbed) {
                return InkWell(
                  onTap: () {
                    selectedDateCalender = date;
                    setState(() {});
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          date.dayName.toUpperCase(),
                          style: isSelected
                              ? AppStyle.selectedCalendarDayStyle
                              : AppStyle.unSelectedCalendarDayStyle,
                        ),
                        Spacer(),
                        Text(
                          date.day.toString(),
                          style: isSelected
                              ? AppStyle.selectedCalendarDayStyle
                              : AppStyle.unSelectedCalendarDayStyle,
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      );

  getTodosListFromFireStore() async {
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

    todosList = todosList
        .where(
          (todo) =>
              todo.date.year == selectedDateCalender.year &&
              todo.date.month == selectedDateCalender.month &&
              todo.date.day == selectedDateCalender.day,
        )
        .toList();

    setState(() {});
  }

  void onDateTabbed() {}
}
