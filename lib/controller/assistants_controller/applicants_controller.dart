import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../models/applicant_model.dart';
import '../../models/my_assistant_model.dart';
import 'my_assistant_controller.dart';

class ApplicantsController extends GetxController {
  var applicants = <Applicant>[
    Applicant(
      name: 'Jerico De Jesus',
      skills: 'Web Development, Mobile App Development,',
      rating: 5.0,
      email: 'dejesusjerico528@gmail.com',
      phone: '09760143260',
      location: 'Taguig City, Philippines',
      professionalSummary: 'Highly skilled badminton player and motivated everyday individual.',
      jobAppliedFor: 'CEO or Big Boss',
    ),
    Applicant(
      name: 'Applicant 1',
      skills: 'Skill Set 1',
      rating: 4.0,
      email: 'applicant1@example.com',
      phone: '+1234567890',
      location: 'City, Country',
      professionalSummary: 'Experienced professional in various skills.',
      jobAppliedFor: 'Job Posting 1',
    ),
    Applicant(
      name: 'Applicant 2',
      skills: 'Skill Set 2',
      rating: 4.5,
      email: 'applicant2@example.com',
      phone: '+1234567891',
      location: 'City, Country',
      professionalSummary: 'Highly skilled and motivated individual.',
      jobAppliedFor: 'Job Posting 2',
    ),
    Applicant(
      name: 'Applicant 3',
      skills: 'Skill Set 3',
      rating: 4.2,
      email: 'applicant3@example.com',
      phone: '+1234567892',
      location: 'City, Country',
      professionalSummary: 'Dedicated and results-oriented professional.',
      jobAppliedFor: 'Job Posting 3',
    ),
  ].obs;

  void scheduleInterview(String name, DateTime date, TimeOfDay time) {
    final applicant = applicants.firstWhere((a) => a.name == name);
    applicant.interviewDate = DateFormat('yyyy-MM-dd').format(date);
    applicant.interviewTime = time.format(Get.context!);
    applicant.status = 'Scheduled';
    applicants.refresh();
  }

  void hireApplicant(Applicant applicant) {
    final MyAssistantsController myAssistantsController = Get.put(MyAssistantsController());
    final newAssistant = MyAssistant(
      name: applicant.name,
      skills: applicant.skills,
      rating: applicant.rating,
      jobAppliedFor: applicant.jobAppliedFor,
      startDate: DateFormat('yyyy-MM-dd').format(DateTime.now()),
      email: applicant.email,
      phone: applicant.phone,
      profilePictureUrl: 'https://loremflickr.com/320/240',
    );
    myAssistantsController.addAssistant(newAssistant);
    applicants.remove(applicant);
    myAssistantsController.assistants.refresh();
    applicants.refresh();
  }

  void declineApplicant(Applicant applicant) {
    applicants.remove(applicant);
    applicants.refresh();
  }
}
