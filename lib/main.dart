import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplemobileapp/controller/navigation_controller.dart';
import 'controller/assistants_controller/my_assistant_controller.dart';
import 'controller/assistants_controller/past_assistant_controller.dart';

void main() {
  // Initialize controllers
  Get.put(MyAssistantsController());
  Get.put(PastAssistantsController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: NavigationBarMenu(),
    );
  }
}
