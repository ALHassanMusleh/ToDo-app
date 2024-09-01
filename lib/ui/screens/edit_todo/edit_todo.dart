import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/app_user.dart';
import 'package:todo_app/model/todo_dm.dart';
import 'package:todo_app/ui/provider/list_provider.dart';
import 'package:todo_app/ui/screens/home_screen/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_app/ui/utils/app_colors.dart';
import 'package:todo_app/ui/utils/app_styles.dart';
import 'package:todo_app/ui/utils/dialog_utils.dart';
import 'package:todo_app/ui/utils/extension.dart';

class EditTodo extends StatefulWidget {
  EditTodo({super.key});
  static const String routeName = "UpdateTodo";

  @override
  State<EditTodo> createState() => _EditTodoState();
}

class _EditTodoState extends State<EditTodo> {
  DateTime selectedDate = DateTime.now();

  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  late ListProvider listProvider;
  late TodoDM todoDM;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      /// This block is called after build it is only called only once
      titleController.text = todoDM.title;
      descriptionController.text = todoDM.description;
      selectedDate = todoDM.date;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    todoDM = ModalRoute.of(context)!.settings.arguments as TodoDM;
    listProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo App ${AppUser.currentUser!.name}'),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.primary,
            height: MediaQuery.of(context).size.height * .1,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * .8,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: AppColors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Edit Task',
                    textAlign: TextAlign.center,
                    style: AppStyle.bottomSheetTitle,
                  ),
                  const SizedBox(
                    height: 12,
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
                    onPressed: () async {
                      await TodoDM.userTodosCollection.doc(todoDM.id).update({
                        "title": titleController.text,
                        "description": descriptionController.text,
                        "date": selectedDate,
                      });
                      listProvider.getTodosListFromFireStore();
                    },
                    child: Text('Edit text'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showMyDatePicker() async {
    selectedDate = await showDatePicker(
          context: context,
          initialDate: todoDM.date,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(
            const Duration(days: 365),
          ),
        ) ??
        selectedDate;
    setState(() {});
  }
}
