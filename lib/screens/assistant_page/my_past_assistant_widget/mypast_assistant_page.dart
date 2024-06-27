import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/assistants_controller/past_assistant_controller.dart';
import '../../../models/past_assistant_model.dart';


class PastAssistantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PastAssistantsController pastAssistantsController = Get.put(PastAssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Past Assistants'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Past Assistants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() => ListView.builder(
                itemCount: pastAssistantsController.pastAssistants.length,
                itemBuilder: (context, index) {
                  final pastAssistant = pastAssistantsController.pastAssistants[index];
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => PastAssistantDetailPage(pastAssistant: pastAssistant));
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(pastAssistant.assistant.profilePictureUrl),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(pastAssistant.assistant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 5),
                                  Text('Skills: ${pastAssistant.assistant.skills}', style: const TextStyle(fontSize: 14)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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

class PastAssistantDetailPage extends StatelessWidget {
  final PastAssistant pastAssistant;

  PastAssistantDetailPage({required this.pastAssistant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${pastAssistant.assistant.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(pastAssistant.assistant.profilePictureUrl),
            ),
            const SizedBox(height: 20),
            Text(pastAssistant.assistant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 10),
            Text('Skills: ${pastAssistant.assistant.skills}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Rating: ${pastAssistant.assistant.rating}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Job: ${pastAssistant.assistant.jobAppliedFor}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Start Date: ${pastAssistant.assistant.startDate}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Email: ${pastAssistant.assistant.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Phone: ${pastAssistant.assistant.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Tasks Updated: ${pastAssistant.assistant.tasksUpdated}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Task Status: ${pastAssistant.assistant.taskStatus}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Date Hired: ${pastAssistant.dateHired}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Date Finished Contract: ${pastAssistant.dateFinishedContract}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            if (pastAssistant.review != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Review:', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Text(pastAssistant.review!, style: const TextStyle(fontSize: 16)),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
