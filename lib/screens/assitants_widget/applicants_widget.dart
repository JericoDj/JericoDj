import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:slider_button/slider_button.dart';
import '../../controller/assistants_controller/applicants_controller.dart';
import '../../controller/assistants_controller/my_assistant_controller.dart';
import '../../models/applicant_model.dart';
import '../../models/my_assistant_model.dart';
import '../../task_dialog/hire_or_decline_dialog.dart';

class ApplicantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ApplicantsController applicantsController = Get.put(ApplicantsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Applicants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Applicants', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
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
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: NetworkImage('https://loremflickr.com/100/100'),
                    radius: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(applicant.name ?? 'N/A', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                        const SizedBox(height: 5),
                        Text(applicant.skills ?? 'N/A', style: const TextStyle(fontSize: 14)),
                      ],
                    ),
                  ),
                  if (applicant.status == 'Scheduled')
                    Chip(
                      label: Text(applicant.status ?? 'Scheduled', style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.green,
                    )
                  else
                    ElevatedButton(
                      onPressed: () {
                        Get.dialog(ScheduleInterviewDialog(name: applicant.name));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: const Text('Set Interview',
                        style: TextStyle(color: Colors.black54),),
                    ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.orange),
                  const SizedBox(width: 5),
                  Text('Rating: ${applicant.rating}', style: const TextStyle(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(Icons.work, size: 16, color: Colors.blue),
                  const SizedBox(width: 5),
                  Text('Applied For: ${applicant.jobAppliedFor ?? 'N/A'}', style: const TextStyle(fontSize: 14)),
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
          final applicant = applicantsController.applicants.firstWhereOrNull((a) => a.name == name);
          if (applicant == null) {
            return Center(child: Text('Applicant not found'));
          }
          return ListView(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.blue,
                    backgroundImage: NetworkImage('https://loremflickr.com/320/240'),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Skills: ${applicant.skills ?? 'N/A'}',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Rating: ${applicant.rating}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Personal Details',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Email: ${applicant.email ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                      Text('Phone: ${applicant.phone ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                      Text('Location: ${applicant.location ?? 'N/A'}', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Professional Summary',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(applicant.professionalSummary ?? 'N/A', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Job Applied For',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(applicant.jobAppliedFor ?? 'N/A', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Interview Details',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                          'Interview Date: ${applicant.interviewDate ?? 'Not Scheduled'}',
                          style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Text(
                          'Interview Time: ${applicant.interviewTime ?? 'Not Scheduled'}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
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

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      selectedDate = selectedDay;
    });
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
                  'Set Interview',
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
            TableCalendar(
              firstDay: DateTime.now(),
              lastDay: DateTime(2025),
              focusedDay: selectedDate,
              selectedDayPredicate: (day) {
                return isSameDay(selectedDate, day);
              },
              onDaySelected: _onDaySelected,
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _selectTime(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text(
                'Select Time',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Date:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  DateFormat('yyyy-MM-dd').format(selectedDate),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Time:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  selectedTime.format(context),
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final ApplicantsController applicantsController = Get.find();
                applicantsController.scheduleInterview(widget.name, selectedDate, selectedTime);
                Navigator.of(context).pop(true);  // Ensure true is returned
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Set Interview'),
            ),
          ],
        ),
      ),
    );
  }
}
