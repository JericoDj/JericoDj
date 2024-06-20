import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/assistants_controller/job_posting_controller.dart';
import 'assitants_widget/applicants_widget.dart';
import 'assitants_widget/job_posting_widget.dart';
import 'messages_page.dart';

class HireAssistantsController extends GetxController {
  var selectedIndex = 0.obs;
  var jobPostings = <JobPosting>[].obs;
}

class HireAssistantsPage extends StatelessWidget {
  const HireAssistantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HireAssistantsController hireAssistantsController = Get.put(HireAssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Hire Assistants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => FeatureCard(
                    title: 'Job Postings',
                    isSelected: hireAssistantsController.selectedIndex.value == 0,
                    onTap: () {
                      hireAssistantsController.selectedIndex.value = 0;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Applicants',
                    isSelected: hireAssistantsController.selectedIndex.value == 1,
                    onTap: () {
                      hireAssistantsController.selectedIndex.value = 1;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  switch (hireAssistantsController.selectedIndex.value) {
                    case 0:
                      return JobPostingsPage();
                    case 1:
                      return ApplicantsPage();
                    default:
                      return JobPostingsPage();
                  }
                }),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(const HireAssistantDialog());
                },
                child: const Text('Hire Assistant'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  FeatureCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: isSelected ? Colors.blue : Colors.grey, width: 2),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.45,
          height: 100,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
