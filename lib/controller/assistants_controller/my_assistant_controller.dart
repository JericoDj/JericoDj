import 'package:get/get.dart';
import '../../models/my_assistant_model.dart';

class MyAssistantsController extends GetxController {
  var assistants = <MyAssistant>[].obs;

  void addAssistant(MyAssistant assistant) {
    assistants.add(assistant);
  }
}
