import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:samplemobileapp/task_dialog/task_details_dialog.dart';
import '../../controller/task_controller/task_controller.dart';
import '../../models/my_assistant_model.dart';

class CreateTaskDialog extends StatelessWidget {
  final MyAssistant? assistant;
  final List<MyAssistant> assistants;

  CreateTaskDialog({this.assistant, required this.assistants});

  @override
  Widget build(BuildContext context) {
    final TasksController tasksController = Get.find();

    // Set the initial assistant for the first task description
    if (tasksController.taskDescriptions.isEmpty && assistant != null) {
      tasksController.addTaskDescription(assistant!.name);
    }

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
                  'Create Task',
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
            TextField(
              controller: tasksController.taskTitleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: tasksController.taskDescriptions.length,
                itemBuilder: (context, index) {
                  return TaskDescriptionWidget(
                    description: tasksController.taskDescriptions[index],
                    assistants: assistants.map((a) => a.name).toList(),
                    recurrences: tasksController.recurrences,
                    hoursPerWeekOptions: tasksController.hoursPerWeekOptions,
                    onRemove: () {
                      tasksController.removeTaskDescription(index);
                    },
                    showSelectedAssistant: index == 0 && assistant != null ? assistant!.name : null,
                  );
                },
              );
            }),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                tasksController.addTaskDescription();
              },
              child: const Text('Add Task Description'),
            ),
            const SizedBox(height: 20),
            const Text('Due Date:'),
            Obx(() {
              return TextButton(
                onPressed: () {
                  _selectDueDate(context);
                },
                child: Text(tasksController.selectedDueDate.value != null
                    ? DateFormat('yyyy-MM-dd').format(tasksController.selectedDueDate.value!)
                    : 'No date chosen'),
              );
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
      if (description.startDate.value == null) {
        tasksController.setErrorMessage('Please select a start date.');
        return false;
      }
      if (description.endDate.value == null) {
        tasksController.setErrorMessage('Please select an end date.');
        return false;
      }
      if (description.weeklyCompletion.value.isEmpty) {
        tasksController.setErrorMessage('Please select weekly completion.');
        return false;
      }
      if (description.hoursPerWeek.value.isEmpty) {
        tasksController.setErrorMessage('Please select hours per week.');
        return false;
      }
    }
    if (tasksController.selectedDueDate.value == null) {
      tasksController.setErrorMessage('Please select a due date.');
      return false;
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
