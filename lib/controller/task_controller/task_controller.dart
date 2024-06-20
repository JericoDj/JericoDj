import 'package:get/get.dart';
import 'package:flutter/material.dart';

class TasksController extends GetxController {
  final taskTitleController = TextEditingController();
  var taskDescriptions = <TaskDescription>[].obs;
  var selectedDueDate = Rxn<DateTime>();
  var errorMessage = ''.obs;
  var assistants = <String>[].obs;
  var tasks = <Task>[].obs;
  var recurrences = ["1", "2", "3", "5", "7", "Specify"].obs;
  var hoursPerWeekOptions = ["10", "20", "30", "40", "Specify"].obs;

  void addTaskDescription([String? assistant]) {
    taskDescriptions.add(TaskDescription(
      description: ''.obs,
      selectedAssistant: (assistant ?? '').obs,
      startDate: Rxn<DateTime>(),
      endDate: Rxn<DateTime>(),
      weeklyCompletion: ''.obs,
      hoursPerWeek: ''.obs,
      isCustomWeeklyCompletion: false.obs,
      isCustomHoursPerWeek: false.obs,
    ));
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

  void setAssistants(List<String> assistantNames) {
    assistants.value = assistantNames;
  }

  bool createTask() {
    if (_validateTask()) {
      tasks.add(Task(
        title: taskTitleController.text,
        descriptions: taskDescriptions.map((d) => TaskDescription(
          description: d.description,
          selectedAssistant: d.selectedAssistant,
          startDate: d.startDate,
          endDate: d.endDate,
          weeklyCompletion: d.weeklyCompletion,
          hoursPerWeek: d.hoursPerWeek,
          isCustomWeeklyCompletion: d.isCustomWeeklyCompletion,
          isCustomHoursPerWeek: d.isCustomHoursPerWeek,
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
      if (description.startDate.value == null) {
        isValid = false;
        errorMessage.value += 'Please select a start date.\n';
      }
      if (description.endDate.value == null) {
        isValid = false;
        errorMessage.value += 'Please select an end date.\n';
      }
      if (description.weeklyCompletion.value.isEmpty) {
        isValid = false;
        errorMessage.value += 'Please select weekly completion.\n';
      }
      if (description.hoursPerWeek.value.isEmpty) {
        isValid = false;
        errorMessage.value += 'Please select hours per week.\n';
      }
    }
    if (selectedDueDate.value == null) {
      isValid = false;
      errorMessage.value += 'Please select a due date.\n';
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
  RxString description;
  RxString selectedAssistant;
  Rxn<DateTime> startDate;
  Rxn<DateTime> endDate;
  RxString weeklyCompletion;
  RxString hoursPerWeek;
  RxBool isCustomWeeklyCompletion;
  RxBool isCustomHoursPerWeek;

  TaskDescription({
    required this.description,
    required this.selectedAssistant,
    required this.startDate,
    required this.endDate,
    required this.weeklyCompletion,
    required this.hoursPerWeek,
    required this.isCustomWeeklyCompletion,
    required this.isCustomHoursPerWeek,
  });
}
