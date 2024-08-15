import 'package:Sourcefully/screens/timecard/timecard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/assistant_page/assistants_page.dart';
import '../screens/hire_page/hire_assistant_page.dart';
import '../screens/homepage/homepage.dart';
import '../screens/profilepage/profile_page.dart';
import '../screens/task_page/tasks_page.dart';
import '../utils/colors/colors.dart';


class NavigationBarMenu extends StatelessWidget {
  const NavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      bottomNavigationBar: Obx(() => buildNavigationBar(navigationController, darkTheme)),
      body: Obx(() => navigationController.screens[navigationController.selectedIndex.value]),
    );
  }

  Widget buildNavigationBar(NavigationController controller, bool darkTheme) {
    return NavigationBar(
      height: 60,
      elevation: 0,
      backgroundColor: darkTheme ? AppColors.secondary : AppColors.lightBackground,
      selectedIndex: controller.selectedIndex.value,
      onDestinationSelected: (index) => controller.selectedIndex.value = index,
      destinations: [
        buildNavigationDestination(Icons.home, "Home", controller.selectedIndex.value == 0, darkTheme),
        buildNavigationDestination(Icons.hail, "Hire", controller.selectedIndex.value == 1, darkTheme),
        buildNavigationDestination(Icons.assignment, "Tasks", controller.selectedIndex.value == 2, darkTheme),
        buildNavigationDestination(Icons.group, "Assistants", controller.selectedIndex.value == 3, darkTheme),
        buildNavigationDestination(Icons.person, "Profile", controller.selectedIndex.value == 4, darkTheme),
      ],
    );
  }

  NavigationDestination buildNavigationDestination(IconData icon, String label, bool isSelected, bool darkTheme) {

    Color unselectedColor = darkTheme ? AppColors.buttonGradientStart : AppColors.primary;


    return NavigationDestination(
      icon: Icon(
        size: 16,
        icon,
        color: isSelected ? Colors.white : unselectedColor,
      ),
      label: label,

      selectedIcon: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: darkTheme ? AppColors.buttonGradientEnd : AppColors.darkText,
        ),
      ),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
    HomePage(),
    HireAssistantsPage(),
    TasksPage(),
    AssistantsPage(),
    ProfilePage(),
  ];
}
