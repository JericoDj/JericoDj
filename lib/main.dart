import 'package:Sourcefully/controller/navigation_controller.dart';
import 'package:Sourcefully/splashScreen/splash_screen.dart';

import 'package:Sourcefully/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/assistants_controller/my_assistant_controller.dart';
import 'controller/assistants_controller/past_assistant_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

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
      theme: LightTheme.theme, // Apply the light theme
      darkTheme: DarkTheme.theme, // Apply the dark theme
      themeMode: ThemeMode.system, // Use system theme mode
      home: NavigationBarMenu(),
    );
  }
}
