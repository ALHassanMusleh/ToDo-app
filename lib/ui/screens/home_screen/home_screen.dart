import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/model/app_user.dart';
import 'package:todo_app/ui/provider/list_provider.dart';
import 'package:todo_app/ui/screens/auth/login_screen/login_screen.dart';
import 'package:todo_app/ui/screens/home_screen/add_bottom_sheet/add_bottom_sheet.dart';
import 'package:todo_app/ui/screens/home_screen/tabs/list/list_tab.dart';
import 'package:todo_app/ui/screens/home_screen/tabs/settings/settings_tab.dart';
import 'package:todo_app/ui/utils/app_colors.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "HomeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabs = [ListTab(), SettingTab()];
  late ListProvider listProvider;
  @override
  Widget build(BuildContext context) {
    listProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title:  Text('ToDo App ${AppUser.currentUser!.name}'),
        actions: [
          InkWell(
            onTap: (){
              listProvider.reset();
              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
            },
              child: Icon(Icons.logout)),
        ],
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: buildBottomNavigation(),
      floatingActionButton: buildFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget buildBottomNavigation() => BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 12,
        clipBehavior: Clip.hardEdge,
        child: BottomNavigationBar(
          onTap: (index) {
            selectedIndex = index;
            setState(() {});
          },
          currentIndex: selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              label: "List",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.settings,
              ),
              label: "Settings",
            ),
          ],
        ),
      );

  buildFab() => FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const StadiumBorder(
          side: BorderSide(
            color: AppColors.white,
            width: 3,
          ),
        ),
        onPressed: () {
          // AddBottomSheet.show(context);
          showModalBottomSheet(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: const AddBottomSheet(),
            ),
          );
        },
        child: Icon(Icons.add),
      );
}
