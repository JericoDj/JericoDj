import 'package:get/get.dart';

class PastAssistantsController extends GetxController {
  var pastAssistants = <PastAssistant>[].obs;
}

class PastAssistant {
  String name;
  String skills;
  double rating;

  PastAssistant({
    required this.name,
    required this.skills,
    required this.rating,
  });
}
