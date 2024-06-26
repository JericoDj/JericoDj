import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
    final MyAssistantsController myAssistantsController = Get.put(MyAssistantsController());

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
      body: const TasksOverview(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final assistants = myAssistantsController.assistants;

          if (assistant != null) {
            tasksController.setAssistants([assistant!.name]);
            Get.dialog(CreateTaskDialog(assistant: assistant!, assistants: assistants));
          } else {
            Get.dialog(CreateTaskDialog(assistants: assistants));
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TasksOverview extends StatelessWidget {
  const TasksOverview({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.put(TasksController());

    return Obx(() => ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: tasksController.tasks.length,
      itemBuilder: (context, index) {
        final task = tasksController.tasks[index];
        return GestureDetector(
          onTap: () {
            Get.dialog(TaskDetailsDialog(task: task));
          },
          child: TaskTile(
            vaName: task.descriptions.isNotEmpty
                ? task.descriptions[0].selectedAssistant.value
                : 'Not assigned',
            taskTitle: task.title,
            taskStatus: 'In Progress',
          ),
        );
      },
    ));
  }
}

class TaskTile extends StatelessWidget {
  final String vaName;
  final String taskTitle;
  final String taskStatus;

  const TaskTile({
    super.key,
    required this.vaName,
    required this.taskTitle,
    required this.taskStatus,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey),
      ),
      child: ListTile(
        title: Text(taskTitle),
        subtitle: Text('Assigned to: $vaName\nStatus: $taskStatus'),
        isThreeLine: true,
      ),
    );
  }
}

class TaskDetailsDialog extends StatelessWidget {
  final Task task;

  const TaskDetailsDialog({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find();
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Task Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Task Title: ${task.title}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Due Date: ${task.dueDate != null ? DateFormat('yyyy-MM-dd').format(task.dueDate!) : 'No date chosen'}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...task.descriptions.map((description) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Description: ${description.description.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Assigned to: ${description.selectedAssistant.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Start Date: ${description.startDate.value != null ? DateFormat('yyyy-MM-dd').format(description.startDate.value!) : 'No date chosen'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'End Date: ${description.endDate.value != null ? DateFormat('yyyy-MM-dd').format(description.endDate.value!) : 'No date chosen'}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Weekly Completion: ${description.weeklyCompletion.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Hours per Week: ${description.hoursPerWeek.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _selectDueDate(context, tasksController, task);
              },
              child: const Text('Set Due Date'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDueDate(BuildContext context, TasksController tasksController, Task task) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: task.dueDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != task.dueDate) {
      tasksController.setDueDate(pickedDate);
      task.dueDate = pickedDate;
      tasksController.tasks.refresh();
    }
  }
}
