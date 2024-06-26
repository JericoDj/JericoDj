import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/assistants_controller/my_assistant_controller.dart';
import '../../controller/assistants_controller/past_assistant_controller.dart';

import '../hire_page/hire_assistant_page.dart';
import '../messages_page/messages_page.dart';
import 'assitants_widget/my_assistant_widget.dart';
import 'mypast_assistant_page.dart';

class AssistantsController extends GetxController {
  var selectedIndex = 0.obs;
}

class AssistantsPage extends StatelessWidget {
  const AssistantsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssistantsController assistantsController = Get.put(AssistantsController());
    final PastAssistantsController pastAssistantsController = Get.put(PastAssistantsController());

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
                    title: 'Past Assistants',
                    isSelected: assistantsController.selectedIndex.value == 1,
                    onTap: () {
                      assistantsController.selectedIndex.value = 1;
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
                      return PastAssistantsPage();
                    default:
                      return MyAssistantsPage();
                  }
                }),
              ),
            ],
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
