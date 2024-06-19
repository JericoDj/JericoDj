import 'package:get/get.dart';

class ApplicantsController extends GetxController {
  var applicants = <Applicant>[].obs;
}

class Applicant {
  String name;
  String skills;
  double rating;

  Applicant({
    required this.name,
    required this.skills,
    required this.rating,
  });
}
