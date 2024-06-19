import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/assistants_controller/job_posting_controller.dart';

class JobPostingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final JobPostingsController jobPostingsController = Get.put(JobPostingsController());

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Job Postings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(() => ListView.builder(
              itemCount: jobPostingsController.jobPostings.length,
              itemBuilder: (context, index) {
                final jobPosting = jobPostingsController.jobPostings[index];
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
                        jobPostingsController.jobPostings.refresh();
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
      child: Card(
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
    'General Virtual Assistant (VA)',
    'Social Media Management',
    'Computer Technical VA',
    'Graphical Creation VA',
    'Administrative VA',
    'Marketing VA',
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
  RxList<TextEditingController> generalRequirementControllers = <TextEditingController>[].obs;
  TextEditingController salaryExpectationController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.initialJobPosting != null) {
      selectedSkills.addAll(widget.initialJobPosting!.skills);
      skillRequirements.addAll(widget.initialJobPosting!.skillRequirements);
      generalRequirementControllers.addAll(widget.initialJobPosting!.generalRequirements.map((requirement) {
        final controller = TextEditingController(text: requirement);
        controller.addListener(() {
          int index = generalRequirementControllers.indexOf(controller);
          if (index != -1) {
            widget.initialJobPosting!.generalRequirements[index] = controller.text;
          }
        });
        return controller;
      }));
      salaryExpectationController.text = widget.initialJobPosting!.salaryExpectation;
      titleController.text = widget.initialJobPosting!.title;
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
                                child: Obx(() {
                                  var controller = TextEditingController(text: skillRequirements[skill]?[index]);
                                  controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));
                                  return TextField(
                                    decoration: const InputDecoration(
                                      labelText: 'Enter requirement',
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (value) {
                                      skillRequirements[skill]?[index] = value;
                                    },
                                    controller: controller,
                                  );
                                }),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  setState(() {
                                    skillRequirements[skill]?.removeAt(index);
                                    if (skillRequirements[skill]?.isEmpty ?? true) {
                                      skillRequirements.remove(skill);
                                      selectedSkills.remove(skill);
                                    }
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            skillRequirements[skill]?.add('');
                          });
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
                  generalRequirementControllers.add(TextEditingController());
                },
                child: const Text('Add General Requirement'),
              ),
              const SizedBox(height: 10),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: generalRequirementControllers.map((controller) {
                  int index = generalRequirementControllers.indexOf(controller);
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
                            controller: controller,
                            onChanged: (value) {
                              widget.initialJobPosting?.generalRequirements[index] = value;
                            },
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            setState(() {
                              generalRequirementControllers.removeAt(index);
                              widget.initialJobPosting?.generalRequirements.removeAt(index);
                            });
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
                    generalRequirements: generalRequirementControllers.map((controller) => controller.text).toList(),
                    salaryExpectation: salaryExpectationController.text,
                    status: 'Open'.obs,
                  );
                  Get.back();
                  Get.dialog(JobPostingDetailsDialog(
                    jobPosting: jobPosting,
                    onEdit: () {
                      Get.back();
                      Get.dialog(HireAssistantDialog(initialJobPosting: jobPosting));
                    },
                    onSubmit: () {
                      final JobPostingsController jobPostingsController = Get.find();
                      jobPosting.status.value = 'Submitted';
                      jobPostingsController.addJobPosting(jobPosting);
                      Get.back();
                    },
                    onSave: () {
                      final JobPostingsController jobPostingsController = Get.find();
                      jobPostingsController.jobPostings.refresh();
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
