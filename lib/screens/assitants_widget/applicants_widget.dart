import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:slider_button/slider_button.dart';
import '../../controller/assistants_controller/applicants_controller.dart';
import '../../controller/assistants_controller/my_assistant_controller.dart';
import '../../models/applicant_model.dart';
import '../../models/my_assistant_model.dart';

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

  AssistantTile({
    required this.applicant,
    required this.onTap,
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
          final applicant = applicantsController.applicants.firstWhereOrNull((a) => a.name == name);
          if (applicant == null) {
            return Center(child: Text('Applicant not found'));
          }
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
                    Navigator.of(context).pop(false);  // Ensure false is returned
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
                Navigator.of(context).pop(true);  // Ensure true is returned
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
                    Navigator.of(context).pop(false);  // Ensure false is returned
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
            SliderButton(
              buttonColor: Colors.yellow,
              shimmer: true,
              action: () async {
                final ApplicantsController applicantsController = Get.find();
                if (action == 'Hire') {
                  applicantsController.hireApplicant(applicant);
                } else {
                  applicantsController.declineApplicant(applicant);
                }
                Get.back();  // Close the dialog
                Get.back();  // Go back to the previous screen
              },
              label: Text(
                'Slide to $action',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(Icons.arrow_right_alt, color: Colors.blueAccent, size: 30,),
              width: 300,
              height: 60,
              buttonSize: 60,
              backgroundColor: Colors.grey.shade300,
              highlightedColor: Colors.green,
              baseColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
