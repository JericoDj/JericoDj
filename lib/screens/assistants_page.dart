import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/assistants_controller/job_posting_controller.dart';
import 'assitants_widget/applicants_widget.dart';
import 'assitants_widget/job_posting_widget.dart';
import 'assitants_widget/my_assistant_widget.dart';
import 'assitants_widget/past_assistant_widget.dart';
import 'messages_page.dart';


class AssistantsController extends GetxController {
  var selectedIndex = 0.obs;
  var jobPostings = <JobPosting>[].obs;
}

class AssistantsPage extends StatelessWidget {
  const AssistantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AssistantsController assistantsController = Get.put(AssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistants'),
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
                    title: 'My Assistants',
                    isSelected: assistantsController.selectedIndex.value == 0,
                    onTap: () {
                      assistantsController.selectedIndex.value = 0;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Job Postings',
                    isSelected: assistantsController.selectedIndex.value == 1,
                    onTap: () {
                      assistantsController.selectedIndex.value = 1;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Applicants',
                    isSelected: assistantsController.selectedIndex.value == 2,
                    onTap: () {
                      assistantsController.selectedIndex.value = 2;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Past Assistants',
                    isSelected: assistantsController.selectedIndex.value == 3,
                    onTap: () {
                      assistantsController.selectedIndex.value = 3;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  switch (assistantsController.selectedIndex.value) {
                    case 0:
                      return MyAssistantsPage();
                    case 1:
                      return JobPostingsPage();
                    case 2:
                      return ApplicantsPage();
                    case 3:
                      return PastAssistantsPage();
                    default:
                      return MyAssistantsPage();
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
          width: MediaQuery.of(context).size.width * 0.22,
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
