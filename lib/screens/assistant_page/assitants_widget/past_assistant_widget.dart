import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../controller/assistants_controller/past_assistant_controller.dart';
import '../../../models/past_assistant_model.dart';


class PastAssistantWidget extends StatelessWidget {
  final PastAssistant pastAssistant;

  const PastAssistantWidget({Key? key, required this.pastAssistant}) : super(key: key);

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
            Text('Date Hired: ${DateFormat('yyyy-MM-dd').format(DateTime.parse(pastAssistant.assistant.startDate))}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 5),
            Text('Date Finished Contract: ${DateFormat('yyyy-MM-dd').format(pastAssistant.dateFinishedContract)}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showReviewDialog(context, pastAssistant);
              },
              child: const Text('Review Assistant'),
            ),
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

  void _showReviewDialog(BuildContext context, PastAssistant pastAssistant) {
    String reviewText = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Review ${pastAssistant.assistant.name}'),
          content: TextField(
            onChanged: (value) => reviewText = value,
            decoration: InputDecoration(hintText: 'Enter your review'),
            maxLines: 3,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.find<PastAssistantsController>().reviewAssistant(pastAssistant, reviewText);
                Get.back();
              },
              child: Text('Submit Review'),
            ),
          ],
        );
      },
    );
  }
}
