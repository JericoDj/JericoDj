class VAProjectManager {
  String name;
  List<Task> tasks;
  List<VirtualAssistant> assignedVAs;

  VAProjectManager({required this.name, required this.tasks, required this.assignedVAs});
}

class Task {
  String title;
  String description;
  DateTime deadline;
  bool isCompleted;

  Task({required this.title, required this.description, required this.deadline, this.isCompleted = false});
}

class VirtualAssistant {
  String name;
  String role;

  VirtualAssistant({required this.name, required this.role});
}
