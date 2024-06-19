import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:action_slider/action_slider.dart';

void main() {
  runApp(GetMaterialApp(
    home: Scaffold(
      appBar: AppBar(title: Text('Applicants Page')),
      body: ApplicantsPage(),
    ),
  ));
}

class ApplicantsController extends GetxController {
  var applicants = <Applicant>[
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

  void hireApplicant(String name) {
    final applicant = applicants.firstWhere((a) => a.name == name);
    applicant.status = 'Hired';
    applicants.refresh();
  }

  void declineApplicant(String name) {
    final applicant = applicants.firstWhere((a) => a.name == name);
    applicant.status = 'Declined';
    applicants.refresh();
  }
}

class Applicant {
  String name;
  String skills;
  double rating;
  String email;
  String phone;
  String location;
  String professionalSummary;
  String jobAppliedFor;
  String? interviewDate;
  String? interviewTime;
  String status = 'Pending'; // Possible statuses: Pending, Scheduled, Hired, Declined

  Applicant({
    required this.name,
    required this.skills,
    required this.rating,
    required this.email,
    required this.phone,
    required this.location,
    required this.professionalSummary,
    required this.jobAppliedFor,
    this.interviewDate,
    this.interviewTime,
  });
}

class ApplicantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicantsController applicantsController = Get.put(ApplicantsController());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Applicants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: applicantsController.applicants.length,
              itemBuilder: (context, index) {
                final applicant = applicantsController.applicants[index];
                return AssistantTile(
                  applicant: applicant,
                  onTap: () {
                    Get.to(() => AssistantProfilePage(name: applicant.name));
                  },
                  onScheduleInterview: () {
                    Get.dialog(ScheduleInterviewDialog(name: applicant.name));
                  },
                  onHireOrDecline: () {
                    Get.dialog(HireDeclineDialog(applicant: applicant, action: 'Hire or Decline'));
                  },
                  onAssignTasks: () {
                    Get.to(() => AssignTasksPage(name: applicant.name));
                  },
                  onTrackPerformance: () {
                    Get.to(() => TrackPerformancePage(name: applicant.name));
                  },
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

class AssistantTile extends StatelessWidget {
  final Applicant applicant;
  final VoidCallback onTap;
  final VoidCallback onScheduleInterview;
  final VoidCallback onHireOrDecline;
  final VoidCallback onAssignTasks;
  final VoidCallback onTrackPerformance;

  AssistantTile({
    required this.applicant,
    required this.onTap,
    required this.onScheduleInterview,
    required this.onHireOrDecline,
    required this.onAssignTasks,
    required this.onTrackPerformance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: applicant.status == 'Scheduled' ? Colors.green : Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(applicant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(applicant.skills, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text('Rating: ${applicant.rating}', style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text('Applied For: ${applicant.jobAppliedFor}', style: const TextStyle(fontSize: 14)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.schedule),
                    onPressed: onScheduleInterview,
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: onHireOrDecline,
                  ),
                  IconButton(
                    icon: const Icon(Icons.task),
                    onPressed: onAssignTasks,
                  ),
                  IconButton(
                    icon: const Icon(Icons.track_changes),
                    onPressed: onTrackPerformance,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AssistantProfilePage extends StatelessWidget {
  final String name;

  AssistantProfilePage({required this.name});

  @override
  Widget build(BuildContext context) {
    final ApplicantsController applicantsController = Get.put(ApplicantsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('$name\'s Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final applicant = applicantsController.applicants.firstWhere((a) => a.name == name);
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.blue,
                        backgroundImage: NetworkImage('https://loremflickr.com/320/240'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Skills: ${applicant.skills}',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            'Rating: ${applicant.rating}',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Personal Details',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Text('Email: ${applicant.email}'),
                    Text('Phone: ${applicant.phone}'),
                    Text('Location: ${applicant.location}'),
                    const SizedBox(height: 10),
                    Text(
                      'Professional Summary',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(applicant.professionalSummary),
                    const SizedBox(height: 10),
                    Text(
                      'Job Applied For',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 5),
                    Text(applicant.jobAppliedFor),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Interview Details',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Interview Date: ${applicant.interviewDate ?? 'Not Scheduled'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Interview Time: ${applicant.interviewTime ?? 'Not Scheduled'}',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              if (applicant.status == 'Scheduled')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(HireDeclineDialog(
                          applicant: applicant,
                          action: 'Hire',
                        ));
                      },
                      child: const Text('Hire'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(HireDeclineDialog(
                          applicant: applicant,
                          action: 'Decline',
                        ));
                      },
                      child: const Text('Decline'),
                    ),
                  ],
                ),
              if (applicant.status == 'Scheduled')
                ElevatedButton(
                  onPressed: () {
                    Get.dialog(ScheduleInterviewDialog(name: applicant.name));
                  },
                  child: const Text('Reschedule Interview'),
                ),
              if (applicant.status != 'Scheduled')
                ElevatedButton(
                  onPressed: () {
                    Get.dialog(ScheduleInterviewDialog(name: applicant.name));
                  },
                  child: const Text('Schedule Interview'),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class ScheduleInterviewDialog extends StatefulWidget {
  final String name;

  ScheduleInterviewDialog({required this.name});

  @override
  _ScheduleInterviewDialogState createState() => _ScheduleInterviewDialogState();
}

class _ScheduleInterviewDialogState extends State<ScheduleInterviewDialog> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Schedule Interview',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select Date'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              child: Text('Select Time'),
            ),
            const SizedBox(height: 20),
            Text(
              'Selected Date: ${DateFormat('yyyy-MM-dd').format(selectedDate)}',
            ),
            const SizedBox(height: 10),
            Text(
              'Selected Time: ${selectedTime.format(context)}',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ApplicantsController applicantsController = Get.find();
                applicantsController.scheduleInterview(widget.name, selectedDate, selectedTime);
                Navigator.of(context).pop();
              },
              child: const Text('Schedule Interview'),
            ),
          ],
        ),
      ),
    );
  }
}

class HireDeclineDialog extends StatelessWidget {
  final Applicant applicant;
  final String action;

  HireDeclineDialog({
    required this.applicant,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  action == 'Hire' ? 'Hire Applicant' : 'Decline Applicant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage('https://loremflickr.com/320/240'),
            ),
            const SizedBox(height: 10),
            Text(
              applicant.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Are you sure you want to ${action.toLowerCase()} this applicant?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            ActionSlider.standard(
              sliderBehavior: SliderBehavior.stretch,
              toggleColor:
              Colors.yellow,
              action: (controller) async {
                final ApplicantsController applicantsController = Get.find();
                if (action == 'Hire') {
                  applicantsController.hireApplicant(applicant.name);
                } else {
                  applicantsController.declineApplicant(applicant.name);
                }
                controller.success();
                await Future.delayed(Duration(seconds: 1));
                Navigator.of(context).pop();
              },
              child: Text('Slide to $action'),
            ),
          ],
        ),
      ),
    );
  }
}

class AssignTasksPage extends StatelessWidget {
  final String name;

  AssignTasksPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Tasks to $name'),
      ),
      body: Center(
        child: Text('Task assignment details for $name'),
      ),
    );
  }
}

class TrackPerformancePage extends StatelessWidget {
  final String name;

  TrackPerformancePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track $name\'s Performance'),
      ),
      body: Center(
        child: Text('Performance tracking details for $name'),
      ),
    );
  }
}
