import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobPosting {
  String title;
  String vaNiche;
  List<String> skills;
  Map<String, List<String>> skillRequirements;
  List<String> generalRequirements;
  String salaryExpectation;
  RxString status;

  JobPosting({
    required this.title,
    required this.vaNiche,
    required this.skills,
    required this.skillRequirements,
    required this.generalRequirements,
    required this.salaryExpectation,
    required this.status,
  });
}

class JobPostingsController extends GetxController {
  var jobPostings = <JobPosting>[].obs;

  void addJobPosting(JobPosting jobPosting) {
    jobPostings.add(jobPosting);
  }

  void updateJobPostingStatus(JobPosting jobPosting, String status) {
    jobPosting.status.value = status;
    jobPostings.refresh();
  }
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Open':
      return Colors.green;
    case 'Submitted':
      return Colors.blue;
    case 'In Review':
      return Colors.orange;
    case 'On Hold':
      return Colors.yellow;
    case 'Cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}
