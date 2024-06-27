import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../../controller/assistants_controller/my_assistant_controller.dart';
import '../../../../controller/task_controller/task_controller.dart';
import '../../../../models/my_assistant_model.dart';
import '../../../../widgets/task_dialog/create_task_dialog.dart';
import '../../../messages_page/messages_page.dart';

class AssistantTasksPage extends StatelessWidget {
  final MyAssistant assistant;

  AssistantTasksPage({required this.assistant});

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.put(TasksController());

    return Scaffold(
      appBar: AppBar(
        title: Text('${assistant.name} Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(assistant.profilePictureUrl),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(assistant.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(() => AssistantDetailPage(assistant: assistant));
                        },
                        child: const Text('View Profile'),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text('Tasks Currently Working On', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                final currentTasks = tasksController.tasks.where((task) =>
                    task.descriptions.any((description) => description.selectedAssistant.value == assistant.name && task.priority == 'working')
                ).toList();
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: currentTasks.length,
                  itemBuilder: (context, index) {
                    final task = currentTasks[index];
                    final description = task.descriptions.firstWhere((d) => d.selectedAssistant.value == assistant.name);
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(TaskDetailsDialog(task: task, assistantName: assistant.name));
                      },
                      child: TaskTile(
                        taskTitle: task.title,
                        description: description.description.value,
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
              Text('Tasks Assigned Today', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                final todayTasks = tasksController.getTasksForToday(assistant.name);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: todayTasks.length,
                  itemBuilder: (context, index) {
                    final task = todayTasks[index];
                    final description = task.descriptions.firstWhere((d) => d.selectedAssistant.value == assistant.name);
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(TaskDetailsDialog(task: task, assistantName: assistant.name));
                      },
                      child: TaskTile(
                        taskTitle: task.title,
                        description: description.description.value,
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
              Text('All Assigned Tasks', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                final allTasks = tasksController.getTasksForAssistant(assistant.name);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    final task = allTasks[index];
                    final description = task.descriptions.firstWhere((d) => d.selectedAssistant.value == assistant.name);
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(TaskDetailsDialog(task: task, assistantName: assistant.name));
                      },
                      child: TaskTile(
                        taskTitle: task.title,
                        description: description.description.value,
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
              Text('Create New Task', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  tasksController.setAssistants(Get.find<MyAssistantsController>().assistants.map((a) => a.name).toList());
                  Get.dialog(CreateTaskDialog(assistant: assistant, assistants: Get.find<MyAssistantsController>().assistants));
                },
                child: const Text('Create Task'),
              ),
              const SizedBox(height: 20),
              Text('Finished Tasks', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Obx(() {
                final finishedTasks = tasksController.getFinishedTasksForAssistant(assistant.name);
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: finishedTasks.length,
                  itemBuilder: (context, index) {
                    final task = finishedTasks[index];
                    final description = task.descriptions.firstWhere((d) => d.selectedAssistant.value == assistant.name);
                    return GestureDetector(
                      onTap: () {
                        Get.dialog(TaskDetailsDialog(task: task, assistantName: assistant.name));
                      },
                      child: TaskTile(
                        taskTitle: task.title,
                        description: description.description.value,
                      ),
                    );
                  },
                );
              }),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(MessagesPage());
                  },
                  child: const Text('Message VA'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskTile extends StatelessWidget {
  final String taskTitle;
  final String description;

  const TaskTile({
    super.key,
    required this.taskTitle,
    required this.description,
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
        subtitle: Text(description),
        isThreeLine: true,
      ),
    );
  }
}

class TaskDetailsDialog extends StatelessWidget {
  final Task task;
  final String assistantName;

  const TaskDetailsDialog({required this.task, required this.assistantName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find();
    final taskDescription = task.descriptions.firstWhere((description) => description.selectedAssistant.value == assistantName);
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task Description: ${taskDescription.description.value}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Assigned to: ${taskDescription.selectedAssistant.value}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Start Date: ${taskDescription.startDate.value != null ? DateFormat('yyyy-MM-dd').format(taskDescription.startDate.value!) : 'No date chosen'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'End Date: ${taskDescription.endDate.value != null ? DateFormat('yyyy-MM-dd').format(taskDescription.endDate.value!) : 'No date chosen'}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Weekly Completion: ${taskDescription.weeklyCompletion.value}',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hours per Week: ${taskDescription.hoursPerWeek.value}',
                  style: const TextStyle(fontSize: 16),
                ),
                const Divider(),
              ],
            ),
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

class AssistantDetailPage extends StatelessWidget {
  final MyAssistant assistant;

  AssistantDetailPage({required this.assistant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${assistant.name} Profile'),
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
          ],
        ),
      ),
    );
  }
}
