class MyAssistant {
  /// Personal details of assistant
  String name;
  String profilePictureUrl;
  String email;
  String phone;

  /// Job Related details
  String skills;
  double rating;
  String jobAppliedFor;
  String startDate;
  String? dateHired; // Nullable date fields
  String? dateFinishedContract; // Nullable date fields

  /// Updating details for the assistant
  String? review; // Nullable review field
  int tasksUpdated; // New field for number of tasks updated
  String taskStatus; // New field for task status

  MyAssistant({
    required this.name,
    required this.skills,
    required this.rating,
    required this.jobAppliedFor,
    required this.startDate,
    required this.email,
    required this.phone,
    required this.profilePictureUrl,
    this.dateHired,
    this.dateFinishedContract,
    this.review,
    this.tasksUpdated = 0, // Default to 0 tasks updated
    this.taskStatus = 'No Task', // Default to 'No Task' status
  });
}
