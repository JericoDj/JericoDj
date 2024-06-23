import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/assistants_controller/past_assistant_controller.dart';
import 'assitants_widget/past_assistant_widget.dart';

class PastAssistantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final PastAssistantsController pastAssistantsController = Get.put(PastAssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Past Assistants'),
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: pastAssistantsController.pastAssistants.length,
          itemBuilder: (context, index) {
            final pastAssistant = pastAssistantsController.pastAssistants[index];
            return ListTile(
              title: Text(pastAssistant.assistant.name),
              subtitle: Text('Finished on: ${pastAssistant.dateFinishedContract}'),
              onTap: () {
                Get.to(() => PastAssistantWidget(pastAssistant: pastAssistant));
              },
            );
          },
        );
      }),
    );
  }
}
