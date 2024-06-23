class MyAssistant {
  String name;
  String skills;
  double rating;
  String jobAppliedFor;
  String startDate;
  String email;
  String phone;
  String profilePictureUrl;
  String? dateHired; // Nullable date fields
  String? dateFinishedContract; // Nullable date fields
  String? review; // Nullable review field

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
  });
}
