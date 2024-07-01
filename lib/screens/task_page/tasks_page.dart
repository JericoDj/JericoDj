import 'package:Sourcefully/screens/task_page/task_page_widgets/calendar_widget/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Sourcefully/screens/task_page/task_page_widgets/task_overview.dart';
import '../../controller/assistants_controller/my_assistant_controller.dart';
import '../../controller/task_controller/task_controller.dart';
import '../../models/my_assistant_model.dart';
import '../../widgets/task_dialog/create_task_dialog.dart';
import '../messages_page/messages_page.dart';

class TasksPage extends StatelessWidget {
  final MyAssistant? assistant;

  const TasksPage({Key? key, this.assistant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.put(TasksController());
    final MyAssistantsController myAssistantsController =
    Get.put(MyAssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CalendarWidget(),
          ),
          const Expanded(child: TasksOverview()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final assistants = myAssistantsController.assistants;

          if (assistant != null) {
            tasksController.setAssistants([assistant!.name]);
            Get.dialog(CreateTaskDialog(
                assistant: assistant!, assistants: assistants));
          } else {
            Get.dialog(CreateTaskDialog(assistants: assistants));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
