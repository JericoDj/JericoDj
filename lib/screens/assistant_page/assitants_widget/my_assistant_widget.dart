import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/assistants_controller/my_assistant_controller.dart';
import '../../../controller/task_controller/task_controller.dart';
import '../../../models/my_assistant_model.dart';

import '../../../widgets/task_dialog/create_task_dialog.dart';


class MyAssistantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyAssistantsController myAssistantsController = Get.put(MyAssistantsController());
    final TasksController tasksController = Get.put(TasksController());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('My Assistants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: myAssistantsController.assistants.length,
              itemBuilder: (context, index) {
                final assistant = myAssistantsController.assistants[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => AssistantDetailPage(assistant: assistant));
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
                            backgroundImage: NetworkImage(assistant.profilePictureUrl),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(assistant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const SizedBox(height: 5),
                                Text('Skills: ${assistant.skills}', style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              tasksController.setAssistants(myAssistantsController.assistants.map((a) => a.name).toList());
                              Get.dialog(CreateTaskDialog(assistant: assistant, assistants: myAssistantsController.assistants));
                            },
                            child: const Text('Assign Task'),
                          ),
                          const SizedBox(width: 5),
                          ElevatedButton(
                            onPressed: () {
                              myAssistantsController.moveToPastAssistants(assistant);
                            },
                            child: const Text('Move to Past'),
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
    );
  }
}

class AssistantDetailPage extends StatelessWidget {
  final MyAssistant assistant;

  AssistantDetailPage({required this.assistant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${assistant.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(assistant.profilePictureUrl),
            ),
            const SizedBox(height: 20),
            Text(assistant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(height: 10),
            Text('Skills: ${assistant.skills}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Rating: ${assistant.rating}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Job: ${assistant.jobAppliedFor}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Start Date: ${assistant.startDate}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Email: ${assistant.email}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Phone: ${assistant.phone}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Track performance action
              },
              child: const Text('Track Performance'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Give feedback action
              },
              child: const Text('Give Feedback'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // View reports action
              },
              child: const Text('View Reports'),
            ),
          ],
        ),
      ),
    );
  }
}
