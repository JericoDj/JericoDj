import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplemobileapp/screens/assistants_page.dart';
import 'package:samplemobileapp/screens/hire_assistant_page.dart';
import 'package:samplemobileapp/screens/homepage.dart';
import 'package:samplemobileapp/screens/profile_page.dart';
import 'package:samplemobileapp/screens/reports_page.dart';
import 'package:samplemobileapp/screens/tasks_page.dart';

import '../screens/assitants_widget/my_assistant_widget.dart';

class NavigationBarMenu extends StatelessWidget {
  const NavigationBarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Obx(() => buildNavigationBar(navigationController)),
      body: Obx(() => navigationController.screens[navigationController.selectedIndex.value]),
    );
  }

  Widget buildNavigationBar(NavigationController controller) {
    return NavigationBar(
      height: 80,
      elevation: 0,
      selectedIndex: controller.selectedIndex.value,
      onDestinationSelected: (index) => controller.selectedIndex.value = index,
      destinations: const [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.hail), label: "Hire"),
        NavigationDestination(icon: Icon(Icons.assignment), label: "Tasks"),
        NavigationDestination(icon: Icon(Icons.group), label: "Assistants"),
        NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
      ],
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
