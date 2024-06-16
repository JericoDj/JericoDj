import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samplemobileapp/controller/task_controller/task_controller.dart';
import 'messages_page.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.put(TasksController());

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
          Get.dialog(CreateTaskDialog());
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
    final TasksController tasksController = Get.find();

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

class CreateTaskDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find();

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Create Task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: tasksController.taskTitleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tasksController.taskDescriptions.length,
                  itemBuilder: (context, index) {
                    return TaskDescriptionWidget(
                      description: tasksController.taskDescriptions[index],
                      assistants: tasksController.assistants,
                      onRemove: () {
                        tasksController.removeTaskDescription(index);
                      },
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                tasksController.addTaskDescription();
              },
              child: const Text('Add Task Description'),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Due Date:'),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDueDate(context);
                  },
                ),
              ],
            ),
            Obx(() {
              return Text(tasksController.selectedDueDate.value != null
                  ? tasksController.selectedDueDate.value.toString()
                  : 'No date chosen');
            }),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_validateTask(tasksController)) {
                  tasksController.createTask();
                  Get.back();
                } else {
                  Get.snackbar('Error', tasksController.errorMessage.value,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white);
                }
              },
              child: const Text('Create Task'),
            ),
          ],
        ),
      ),
    );
  }

  bool _validateTask(TasksController tasksController) {
    if (tasksController.taskTitleController.text.isEmpty) {
      tasksController.setErrorMessage('Task title is required.');
      return false;
    }
    if (tasksController.taskDescriptions.isEmpty) {
      tasksController.setErrorMessage('At least one task description is required.');
      return false;
    }
    for (var description in tasksController.taskDescriptions) {
      if (description.description.value.isEmpty) {
        tasksController.setErrorMessage('Task description cannot be empty.');
        return false;
      }
      if (description.selectedAssistant.value.isEmpty) {
        tasksController.setErrorMessage('Please select an assistant.');
        return false;
      }
      if (description.dueDate.value == null) {
        tasksController.setErrorMessage('Please select a due date.');
        return false;
      }
    }
    tasksController.setErrorMessage('');
    return true;
  }

  Future<void> _selectDueDate(BuildContext context) async {
    final TasksController tasksController = Get.find();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: tasksController.selectedDueDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != tasksController.selectedDueDate.value) {
      tasksController.setDueDate(pickedDate);
    }
  }
}

class TaskDescriptionWidget extends StatelessWidget {
  final TaskDescription description;
  final List<String> assistants;
  final VoidCallback onRemove;

  TaskDescriptionWidget({
    required this.description,
    required this.assistants,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController descriptionController =
    TextEditingController(text: description.description.value);

    descriptionController.addListener(() {
      description.description.value = descriptionController.text;
    });

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Task Description',
                border: OutlineInputBorder(),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    hint: const Text('Select VA'),
                    value: description.selectedAssistant.value.isEmpty
                        ? null
                        : description.selectedAssistant.value,
                    onChanged: (String? newValue) {
                      description.selectedAssistant.value =
                          newValue ?? '';
                    },
                    items: assistants
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    _selectDescriptionDueDate(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
            Obx(() {
              return Text(description.dueDate.value != null
                  ? description.dueDate.value.toString()
                  : 'No date chosen');
            }),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDescriptionDueDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: description.dueDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != description.dueDate.value) {
      description.dueDate.value = pickedDate;
    }
  }
}

class TaskDetailsDialog extends StatelessWidget {
  final Task task;

  const TaskDetailsDialog({required this.task, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              'Task Title: ${task.title}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            ...task.descriptions.map((description) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Task Description: ${description.description.value}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Assigned to: ${description.selectedAssistant.value}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Due Date: ${description.dueDate.value != null ? description.dueDate.value.toString() : 'No date chosen'}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const Divider(),
                ],
              );
            }).toList(),
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
}
