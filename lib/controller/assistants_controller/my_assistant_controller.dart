import 'package:get/get.dart';
import '../../models/my_assistant_model.dart';
import '../../models/past_assistant_model.dart';
import 'past_assistant_controller.dart';

class MyAssistantsController extends GetxController {
  var assistants = <MyAssistant>[].obs;
  final PastAssistantsController pastAssistantsController = Get.put(PastAssistantsController());

  void addAssistant(MyAssistant assistant) {
    assistants.add(assistant);
  }

  void moveToPastAssistants(MyAssistant assistant) {
    assistants.remove(assistant);
    pastAssistantsController.addPastAssistant(PastAssistant(
      assistant: assistant,
      dateHired: DateTime.parse(assistant.startDate),
      dateFinishedContract: DateTime.now(),
    ));
  }
}
