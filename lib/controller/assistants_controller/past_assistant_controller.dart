import 'package:get/get.dart';
import '../../models/past_assistant_model.dart';

class PastAssistantsController extends GetxController {
  var pastAssistants = <PastAssistant>[].obs;

  void addPastAssistant(PastAssistant pastAssistant) {
    pastAssistants.add(pastAssistant);
  }

  void reviewAssistant(PastAssistant pastAssistant, String review) {
    final index = pastAssistants.indexOf(pastAssistant);
    if (index != -1) {
      pastAssistants[index].review = review;
      pastAssistants.refresh();
    }
  }
}
