import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TasksController extends GetxController {
  final taskTitleController = TextEditingController();
  var taskDescriptions = <TaskDescription>[].obs;
  var selectedDueDate = Rxn<DateTime>();
  var errorMessage = ''.obs;
  var tasks = <Task>[].obs;

  List<String> assistants = ['VA 1', 'VA 2', 'VA 3', 'VA 4', 'VA 5'];

  void addTaskDescription() {
    taskDescriptions.add(TaskDescription());
  }

  void removeTaskDescription(int index) {
    taskDescriptions.removeAt(index);
  }

  void setDueDate(DateTime date) {
    selectedDueDate.value = date;
  }

  void setErrorMessage(String message) {
    errorMessage.value = message;
  }

  bool createTask() {
    if (_validateTask()) {
      tasks.add(Task(
        title: taskTitleController.text,
        descriptions: taskDescriptions.map((d) => TaskDescription(
          description: d.description.value,
          selectedAssistant: d.selectedAssistant.value,
          dueDate: d.dueDate.value,
        )).toList(),
        dueDate: selectedDueDate.value,
      ));
      _clearFields();
      return true;
    } else {
      return false;
    }
  }

  bool _validateTask() {
    bool isValid = true;
    errorMessage.value = '';

    if (taskTitleController.text.isEmpty) {
      isValid = false;
      errorMessage.value += 'Task title is required.\n';
    }
    if (taskDescriptions.isEmpty) {
      isValid = false;
      errorMessage.value += 'At least one task description is required.\n';
    }
    for (var description in taskDescriptions) {
      if (description.description.value.isEmpty) {
        isValid = false;
        errorMessage.value += 'Task description cannot be empty.\n';
      }
      if (description.selectedAssistant.value.isEmpty) {
        isValid = false;
        errorMessage.value += 'Please select an assistant.\n';
      }
      if (description.dueDate.value == null) {
        isValid = false;
        errorMessage.value += 'Please select a due date.\n';
      }
    }

    return isValid;
  }

  void _clearFields() {
    taskTitleController.clear();
    taskDescriptions.clear();
    selectedDueDate.value = null;
    errorMessage.value = '';
  }
}

class Task {
  String title;
  List<TaskDescription> descriptions;
  DateTime? dueDate;

  Task({
    required this.title,
    required this.descriptions,
    this.dueDate,
  });
}

class TaskDescription {
  RxString description = ''.obs;
  RxString selectedAssistant = ''.obs;
  Rxn<DateTime> dueDate = Rxn<DateTime>();

  TaskDescription({
    String description = '',
    String selectedAssistant = '',
    DateTime? dueDate,
  }) {
    this.description.value = description;
    this.selectedAssistant.value = selectedAssistant;
    this.dueDate.value = dueDate;
  }
}
