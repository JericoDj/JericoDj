class Applicant {
  String name;
  String skills;
  double rating;
  String email;
  String phone;
  String location;
  String professionalSummary;
  String jobAppliedFor;
  String? interviewDate;
  String? interviewTime;
  String? status;

  Applicant({
    required this.name,
    required this.skills,
    required this.rating,
    required this.email,
    required this.phone,
    required this.location,
    required this.professionalSummary,
    required this.jobAppliedFor,
    this.interviewDate,
    this.interviewTime,
    this.status,
  });
}
