import 'package:get/get.dart';
import 'my_assistant_model.dart';

class PastAssistant {
  MyAssistant assistant;
  DateTime dateHired;
  DateTime dateFinishedContract;
  String? review;

  PastAssistant({
    required this.assistant,
    required this.dateHired,
    required this.dateFinishedContract,
    this.review,
  });
}
