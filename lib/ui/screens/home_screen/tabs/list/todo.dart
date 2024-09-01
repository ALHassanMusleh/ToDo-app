import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_dm.dart';
import 'package:todo_app/ui/provider/list_provider.dart';
import 'package:todo_app/ui/screens/edit_todo/edit_todo.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';

class Todo extends StatelessWidget {
  Todo({super.key, required this.todoDM});
  final TodoDM todoDM;

  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Slidable(
      startActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: clearTodo,
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            spacing: 1,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(context, EditTodo.routeName,arguments: todoDM);
            },
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Edit',
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              bottomLeft: Radius.circular(24),
            ),
            spacing: 1,
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppColors.white,
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8,vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
        height: MediaQuery.of(context).size.height * .12,
        child: Row(
          children: [
            buildVerticalLine(context),
            const SizedBox(
              width: 25,
            ),
            buildTodoInfo(),
            buildTodoState(),
          ],
        ),
      ),
    );
  }

  buildVerticalLine(BuildContext context) => Container(
        height: MediaQuery.of(context).size.height * .07,
        width: 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: todoDM.isDone ? Colors.green : AppColors.primary,
        ),
      );

  buildTodoInfo() => Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Spacer(),
            Text(
              todoDM.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppStyle.bottomSheetTitle.copyWith(
                  color: todoDM.isDone ? Colors.green : AppColors.primary),
            ),
            Spacer(),
            Text(
              todoDM.description,
              style: AppStyle.bodyTextStyle,
            ),
            Spacer(),
          ],
        ),
      );

  // buildTodoState() => Container(
  //   decoration: BoxDecoration(
  //     color: AppColors.primary,
  //     borderRadius: BorderRadius.circular(16),
  //   ),
  //   padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
  //   child: const Icon(Icons.done,color: AppColors.white,size: 35,),
  // );

  buildTodoState() => InkWell(
        onTap: () async {
          await TodoDM.userTodosCollection.doc(todoDM.id).update({
            "isDone": !todoDM.isDone,
          });
          listProvider.getTodosListFromFireStore();
        },
        child: todoDM.isDone ? buildCheckedState() : buildUnCheckedState(),
      );
  Container buildCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: todoDM.isDone ? AppColors.white : AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Text(
        "Done",
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.green),
      ),
    );
  }

  Container buildUnCheckedState() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Icon(
        Icons.done,
        color: AppColors.white,
        size: 30,
      ),
    );
  }

  void clearTodo(BuildContext context) async {
    await TodoDM.userTodosCollection.doc(todoDM.id).delete();
    listProvider.getTodosListFromFireStore();
  }
}
