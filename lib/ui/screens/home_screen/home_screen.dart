import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDo App'),
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
          AddBottomSheet.show(context);
        },
        child: Icon(Icons.add),
      );
}
