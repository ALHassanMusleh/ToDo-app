import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/todo_dm.dart';
import 'package:todo_app/ui/provider/list_provider.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import 'package:todo_app/ui/utils/extension.dart';

class AddBottomSheet extends StatefulWidget {
  const AddBottomSheet({super.key});
  @override
  State<AddBottomSheet> createState() => _AddBottomSheetState();

  // static void show(BuildContext context) {
  //   showModalBottomSheet(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) => Padding(
  //       padding: MediaQuery.of(context).viewInsets,
  //       child: const AddBottomSheet(),
  //     ),
  //   );
  // }
}

class _AddBottomSheetState extends State<AddBottomSheet> {
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Container(
      // height: MediaQuery.of(context).size.height * .5,
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: AppStyle.bottomSheetTitle,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'Enter task title',
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter task desciption',
              ),
              minLines: 6,
              maxLines: 10,
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Select date',
              style: AppStyle.bottomSheetTitle.copyWith(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            InkWell(
              onTap: () {
                showMyDatePicker();
              },
              child: Text(
                selectedDate.toFormattedDate,
                style: AppStyle.normalGreyTextStyle,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton(
              onPressed: () {
                addTodoToFireStore();
              },
              child: Text('Add text'),
            ),
          ],
        ),
      ),
    );
  }

  void addTodoToFireStore() {
    CollectionReference todosCollection =
        FirebaseFirestore.instance.collection(TodoDM.collectionName);

    /// create document first way
    // todosCollection.add(data);

    /// create document second way
    DocumentReference doc = todosCollection.doc();
    TodoDM todo = TodoDM(
        id: doc.id,
        title: titleController.text,
        description: titleController.text,
        date: selectedDate,
        isDone: false);
    doc.set(todo.toJson()).then((_) {}).onError((error, stacktrace) {}).timeout(
      const Duration(microseconds: 500),
      onTimeout: () {
        listProvider.getTodosListFromFireStore();
        Navigator.pop(context);
      },
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
          context: context,
          initialDate: selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
        ) ??
        selectedDate;
    setState(() {});
  }
}
