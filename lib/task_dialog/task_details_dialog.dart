import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/task_controller/task_controller.dart';

class TaskDescriptionWidget extends StatelessWidget {
  final TaskDescription description;
  final List<String> assistants;
  final List<String> recurrences;
  final List<String> hoursPerWeekOptions;
  final VoidCallback onRemove;
  final String? showSelectedAssistant;

  TaskDescriptionWidget({
    required this.description,
    required this.assistants,
    required this.recurrences,
    required this.hoursPerWeekOptions,
    required this.onRemove,
    this.showSelectedAssistant,
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
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                      labelText: 'Task Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: onRemove,
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    hint: const Text('Select Assistant'),
                    value: description.selectedAssistant.value.isEmpty
                        ? showSelectedAssistant
                        : description.selectedAssistant.value,
                    onChanged: (String? newValue) {
                      description.selectedAssistant.value = newValue ?? '';
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Start Date:'),
                      Obx(() => Text(description.startDate.value != null
                          ? DateFormat('yyyy-MM-dd').format(description.startDate.value!)
                          : 'No date chosen')),
                      TextButton(
                        onPressed: () => _selectStartDate(context),
                        child: const Text('Select Start Date'),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('End Date:'),
                      Obx(() => Text(description.endDate.value != null
                          ? DateFormat('yyyy-MM-dd').format(description.endDate.value!)
                          : 'No date chosen')),
                      TextButton(
                        onPressed: () => _selectEndDate(context),
                        child: const Text('Select End Date'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    hint: const Text('Weekly Completion'),
                    value: description.weeklyCompletion.value.isEmpty
                        ? null
                        : description.weeklyCompletion.value,
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue == 'Specify') {
                        description.weeklyCompletion.value = '';
                        description.isCustomWeeklyCompletion.value = true;
                      } else {
                        description.weeklyCompletion.value = newValue ?? '';
                        description.isCustomWeeklyCompletion.value = false;
                      }
                    },
                    items: recurrences
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
                ),
                if (description.isCustomWeeklyCompletion.value)
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        description.weeklyCompletion.value = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Specify',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Obx(() => DropdownButton<String>(
                    hint: const Text('Hours per Week'),
                    value: description.hoursPerWeek.value.isEmpty
                        ? null
                        : description.hoursPerWeek.value,
                    onChanged: (String? newValue) {
                      if (newValue != null && newValue == 'Specify') {
                        description.hoursPerWeek.value = '';
                        description.isCustomHoursPerWeek.value = true;
                      } else {
                        description.hoursPerWeek.value = newValue ?? '';
                        description.isCustomHoursPerWeek.value = false;
                      }
                    },
                    items: hoursPerWeekOptions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
                ),
                if (description.isCustomHoursPerWeek.value)
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        description.hoursPerWeek.value = value;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Specify',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: description.startDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != description.startDate.value) {
      description.startDate.value = pickedDate;
    }
  }

  Future<void> _selectEndDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: description.endDate.value ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != description.endDate.value) {
      description.endDate.value = pickedDate;
    }
  }
}
