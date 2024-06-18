import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'messages_page.dart';

class AssistantsController extends GetxController {
  var selectedIndex = 0.obs;
  var jobPostings = <JobPosting>[].obs;
}

class AssistantsPage extends StatelessWidget {
  const AssistantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AssistantsController assistantsController = Get.put(AssistantsController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Assistants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Obx(() => FeatureCard(
                    title: 'My Assistants',
                    isSelected: assistantsController.selectedIndex.value == 0,
                    onTap: () {
                      assistantsController.selectedIndex.value = 0;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Job Postings',
                    isSelected: assistantsController.selectedIndex.value == 1,
                    onTap: () {
                      assistantsController.selectedIndex.value = 1;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Applicants',
                    isSelected: assistantsController.selectedIndex.value == 2,
                    onTap: () {
                      assistantsController.selectedIndex.value = 2;
                    },
                  )),
                  Obx(() => FeatureCard(
                    title: 'Past Assistants',
                    isSelected: assistantsController.selectedIndex.value == 3,
                    onTap: () {
                      assistantsController.selectedIndex.value = 3;
                    },
                  )),
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(() {
                  switch (assistantsController.selectedIndex.value) {
                    case 0:
                      return MyAssistantsPage();
                    case 1:
                      return JobPostingsPage();
                    case 2:
                      return ApplicantsPage();
                    case 3:
                      return PastAssistantsPage();
                    default:
                      return MyAssistantsPage();
                  }
                }),
              ),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.all(10),
              child: ElevatedButton(
                onPressed: () {
                  Get.dialog(const HireAssistantDialog());
                },
                child: const Text('Hire Assistant'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  FeatureCard({
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: isSelected ? Colors.blue : Colors.grey, width: 2),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.22,
          height: 100,
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.blue : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class MyAssistantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('My Assistants details'),
    );
  }
}

class JobPostingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AssistantsController assistantsController = Get.find();

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Job Postings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: assistantsController.jobPostings.length,
              itemBuilder: (context, index) {
                final jobPosting = assistantsController.jobPostings[index];
                return JobPostingTile(
                  jobPosting: jobPosting,
                  onTap: () {
                    Get.dialog(JobPostingDetailsDialog(
                      jobPosting: jobPosting,
                      onEdit: () {
                        Get.back();
                        Get.dialog(HireAssistantDialog(initialJobPosting: jobPosting));
                      },
                      onSubmit: () {
                        jobPosting.status.value = 'Submitted';
                        Get.back();
                      },
                      onSave: () {
                        Get.back();
                      },
                    ));
                  },
                );
              },
            )),
          ),
        ],
      ),
    );
  }
}

class JobPostingTile extends StatelessWidget {
  final JobPosting jobPosting;
  final VoidCallback onTap;

  JobPostingTile({
    required this.jobPosting,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Obx(() => Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: getStatusColor(jobPosting.status.value),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(jobPosting.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(jobPosting.vaNiche, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text('Status: ${jobPosting.status.value}', style: const TextStyle(fontSize: 14)),
            ],
          ),
        ),
      )),
    );
  }
}

class ApplicantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Applicants', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Replace with actual number of applicants
              itemBuilder: (context, index) {
                return AssistantTile(
                  name: 'Applicant ${index + 1}',
                  skills: 'Skill Set',
                  rating: 4.0,
                  onTap: () {
                    Get.to(() => AssistantProfilePage(name: 'Applicant ${index + 1}'));
                  },
                  onScheduleInterview: () {
                    Get.to(() => ScheduleInterviewPage(name: 'Applicant ${index + 1}'));
                  },
                  onHireOrDecline: () {
                    Get.to(() => HireOrDeclinePage(name: 'Applicant ${index + 1}'));
                  },
                  onAssignTasks: () {
                    Get.to(() => AssignTasksPage(name: 'Applicant ${index + 1}'));
                  },
                  onTrackPerformance: () {
                    Get.to(() => TrackPerformancePage(name: 'Applicant ${index + 1}'));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class PastAssistantsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Past Assistants details'),
    );
  }
}

class AssistantTile extends StatelessWidget {
  final String name;
  final String skills;
  final double rating;
  final VoidCallback onTap;
  final VoidCallback onScheduleInterview;
  final VoidCallback onHireOrDecline;
  final VoidCallback onAssignTasks;
  final VoidCallback onTrackPerformance;

  AssistantTile({
    required this.name,
    required this.skills,
    required this.rating,
    required this.onTap,
    required this.onScheduleInterview,
    required this.onHireOrDecline,
    required this.onAssignTasks,
    required this.onTrackPerformance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: const BorderSide(color: Colors.grey),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 5),
              Text(skills, style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 5),
              Text('Rating: $rating', style: const TextStyle(fontSize: 14)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.schedule),
                    onPressed: onScheduleInterview,
                  ),
                  IconButton(
                    icon: const Icon(Icons.thumb_up),
                    onPressed: onHireOrDecline,
                  ),
                  IconButton(
                    icon: const Icon(Icons.task),
                    onPressed: onAssignTasks,
                  ),
                  IconButton(
                    icon: const Icon(Icons.track_changes),
                    onPressed: onTrackPerformance,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HireAssistantDialog extends StatefulWidget {
  final JobPosting? initialJobPosting;

  const HireAssistantDialog({super.key, this.initialJobPosting});

  @override
  _HireAssistantDialogState createState() => _HireAssistantDialogState();
}

class _HireAssistantDialogState extends State<HireAssistantDialog> {
  final List<String> vaNiches = [
    'General Social Media VA',
    'Customer Support VA',
    'Web/Mobile App VA',
    'E-commerce VA',
    'Bookkeeping VA',
    'Graphic Design VA',
  ];

  final List<String> skills = [
    'Content Creation',
    'SEO',
    'Customer Service',
    'Project Management',
    'Accounting',
    'Graphic Design',
    'Social Media Management',
    'Technical Support',
    'Web Development',
    'Data Entry',
  ];

  RxList<String> selectedSkills = <String>[].obs;
  RxMap<String, List<String>> skillRequirements = <String, List<String>>{}.obs;
  RxList<String> generalRequirements = <String>[].obs;
  TextEditingController salaryExpectationController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  String selectedStatus = 'Open';

  final List<String> statuses = [
    'Open',
    'Submitted',
    'In Review',
    'On Hold',
    'Cancelled',
  ];

  @override
  void initState() {
    super.initState();
    if (widget.initialJobPosting != null) {
      selectedSkills.addAll(widget.initialJobPosting!.skills);
      skillRequirements.addAll(widget.initialJobPosting!.skillRequirements);
      generalRequirements.addAll(widget.initialJobPosting!.generalRequirements);
      salaryExpectationController.text = widget.initialJobPosting!.salaryExpectation;
      titleController.text = widget.initialJobPosting!.title;
      selectedStatus = widget.initialJobPosting!.status.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hire Assistant',
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
                decoration: const InputDecoration(
                  labelText: 'Job Title',
                  border: OutlineInputBorder(),
                ),
                controller: titleController,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Select VA Niche',
                  border: OutlineInputBorder(),
                ),
                items: vaNiches.map((String niche) {
                  return DropdownMenuItem<String>(
                    value: niche,
                    child: Text(niche),
                  );
                }).toList(),
                onChanged: (String? value) {},
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _showSkillsDialog();
                },
                child: const Text('Add Skill Requirement'),
              ),
              const SizedBox(height: 20),
              Obx(() => Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: selectedSkills.map((String skill) {
                  return Chip(
                    label: Text(skill),
                    onDeleted: () {
                      selectedSkills.remove(skill);
                      skillRequirements.remove(skill);
                    },
                  );
                }).toList(),
              )),
              const SizedBox(height: 10),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedSkills.map((String skill) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Requirement for $skill',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      ...List.generate(
                        skillRequirements[skill]?.length ?? 0,
                            (index) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Enter requirement',
                                    border: OutlineInputBorder(),
                                  ),
                                  onChanged: (value) {
                                    skillRequirements[skill]?[index] = value;
                                  },
                                  controller: TextEditingController(
                                    text: skillRequirements[skill]?[index],
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  skillRequirements[skill]?.removeAt(index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          skillRequirements[skill]?.add('');
                        },
                        child: const Text('Add Another Requirement'),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              )),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  generalRequirements.add('');
                },
                child: const Text('Add General Requirement'),
              ),
              const SizedBox(height: 10),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: generalRequirements.map((String requirement) {
                  int index = generalRequirements.indexOf(requirement);
                  TextEditingController controller = TextEditingController(text: requirement);
                  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            decoration: const InputDecoration(
                              labelText: 'Enter general requirement',
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              generalRequirements[index] = value;
                            },
                            controller: controller,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            generalRequirements.removeAt(index);
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              )),
              const SizedBox(height: 20),
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Salary Expectation',
                  border: OutlineInputBorder(),
                ),
                controller: salaryExpectationController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  JobPosting jobPosting = JobPosting(
                    title: titleController.text,
                    vaNiche: 'VA Niche', // Update this to the actual VA niche
                    skills: selectedSkills.toList(),
                    skillRequirements: Map<String, List<String>>.from(skillRequirements),
                    generalRequirements: generalRequirements.toList(),
                    salaryExpectation: salaryExpectationController.text,
                    status: selectedStatus.obs,
                  );
                  Get.back();
                  Get.dialog(JobPostingDetailsDialog(
                    jobPosting: jobPosting,
                    onEdit: () {
                      Get.back();
                      Get.dialog(HireAssistantDialog(initialJobPosting: jobPosting));
                    },
                    onSubmit: () {
                      final AssistantsController assistantsController = Get.find();
                      jobPosting.status.value = 'Submitted';
                      assistantsController.jobPostings.add(jobPosting);
                      Get.back();
                    },
                    onSave: () {
                      setState(() {
                        jobPosting.status.value = selectedStatus;
                      });
                      Get.back();
                    },
                  ));
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSkillsDialog() {
    Get.dialog(Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select Skills',
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
              ListView.builder(
                shrinkWrap: true,
                itemCount: skills.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(skills[index]),
                    onTap: () {
                      if (!selectedSkills.contains(skills[index])) {
                        selectedSkills.add(skills[index]);
                        skillRequirements[skills[index]] = [''];
                      }
                      Get.back();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class JobPostingDetailsDialog extends StatelessWidget {
  final JobPosting jobPosting;
  final VoidCallback onEdit;
  final VoidCallback onSubmit;
  final VoidCallback onSave;

  JobPostingDetailsDialog({
    required this.jobPosting,
    required this.onEdit,
    required this.onSubmit,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Job Posting Details',
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
              Text('Job Title: ${jobPosting.title}'),
              const SizedBox(height: 10),
              Text('VA Niche: ${jobPosting.vaNiche}'),
              const SizedBox(height: 10),
              Text('Skills: ${jobPosting.skills.join(', ')}'),
              const SizedBox(height: 10),
              ...jobPosting.skills.map((String skill) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Requirements for $skill:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ...jobPosting.skillRequirements[skill]?.map((String requirement) {
                      return Text('- $requirement');
                    }) ?? [],
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
              const SizedBox(height: 10),
              Text(
                'General Requirements:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...jobPosting.generalRequirements.map((String requirement) {
                return Text('- $requirement');
              }).toList(),
              const SizedBox(height: 10),
              Text('Salary Expectation: ${jobPosting.salaryExpectation}'),
              const SizedBox(height: 10),
              Text('Status: ${jobPosting.status.value}'),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: jobPosting.status.value,
                decoration: const InputDecoration(
                  labelText: 'Select Status',
                  border: OutlineInputBorder(),
                ),
                items: ['Open', 'Submitted', 'In Review', 'On Hold', 'Cancelled'].map((String status) {
                  return DropdownMenuItem<String>(
                    value: status,
                    child: Text(status),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    jobPosting.status.value = value;
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onEdit,
                child: const Text('Edit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onSubmit,
                child: const Text('Submit'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onSave,
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class JobPosting {
  String title;
  String vaNiche;
  List<String> skills;
  Map<String, List<String>> skillRequirements;
  List<String> generalRequirements;
  String salaryExpectation;
  RxString status;

  JobPosting({
    required this.title,
    required this.vaNiche,
    required this.skills,
    required this.skillRequirements,
    required this.generalRequirements,
    required this.salaryExpectation,
    required this.status,
  });
}

Color getStatusColor(String status) {
  switch (status) {
    case 'Open':
      return Colors.green;
    case 'Submitted':
      return Colors.blue;
    case 'In Review':
      return Colors.orange;
    case 'On Hold':
      return Colors.yellow;
    case 'Cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

class AssistantProfilePage extends StatelessWidget {
  final String name;

  AssistantProfilePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$name\'s Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Profile details of $name'),
      ),
    );
  }
}

class ScheduleInterviewPage extends StatelessWidget {
  final String name;

  ScheduleInterviewPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule Interview with $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Schedule Interview details for $name'),
      ),
    );
  }
}

class HireOrDeclinePage extends StatelessWidget {
  final String name;

  HireOrDeclinePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire or Decline $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Hire or Decline options for $name'),
      ),
    );
  }
}

class AssignTasksPage extends StatelessWidget {
  final String name;

  AssignTasksPage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Assign Tasks to $name'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Task assignment details for $name'),
      ),
    );
  }
}

class TrackPerformancePage extends StatelessWidget {
  final String name;

  TrackPerformancePage({required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Track $name\'s Performance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              Get.to(() => const MessagesPage());
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Performance tracking details for $name'),
      ),
    );
  }
}
