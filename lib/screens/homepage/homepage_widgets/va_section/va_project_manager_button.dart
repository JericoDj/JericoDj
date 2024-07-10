import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/homepage_datas/va_niche_data/va_niche_data.dart';
import '../../../../utils/colors/colors.dart';

class VAProjectManagerPage extends StatelessWidget {
  final VANiche niche;
  final bool darkTheme;
  final VAProjectManagerController controller = Get.put(VAProjectManagerController());

  VAProjectManagerPage({required this.niche, required this.darkTheme});

  void _showManageVADialog(BuildContext context, VAProjectManager manager) {
    List<VirtualAssistant> selectedVAs = List.from(manager.assignedVAs);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text('Manage Assigned VAs'),
            content: Container(
              width: double.maxFinite,
              height: 400,
              child: Obx(() {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: controller.availableVAs.map((va) {
                          return CheckboxListTile(
                            title: Text(va.name),
                            subtitle: Text('Tasks assigned: ${va.taskCount}'),
                            value: selectedVAs.contains(va),
                            onChanged: (isSelected) {
                              setState(() {
                                isSelected! ? selectedVAs.add(va) : selectedVAs.remove(va);
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              }),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  controller.assignVAsToManager(manager, selectedVAs);
                  Navigator.of(context).pop();
                },
                child: Text('Save'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showManageProjectDialog(BuildContext context, VAProjectManager manager) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Manage Projects'),
          content: Obx(() {
            final projects = manager.projects;
            if (projects.isEmpty) {
              return Center(child: Text('No projects. Create one.'));
            }
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: projects.map((project) {
                return ListTile(
                  title: Text(project.title),
                  subtitle: Text('Start: ${project.startDate} - End: ${project.dueDate}'),
                  onTap: () {
                    _showProjectDetailsDialog(context, project);
                  },
                );
              }).toList(),
            );
          }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showCreateProjectDialog(context, manager);
              },
              child: Text('Create Project'),
            ),
          ],
        );
      },
    );
  }

  void _showProjectDetailsDialog(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(project.title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Manager: ${project.manager.name}'),
            const SizedBox(height: 8),
            Text('Start Date: ${project.startDate}'),
            Text('End Date: ${project.dueDate}'),
            const SizedBox(height: 16),
            Text('Assigned VAs:'),
            ...project.assignedVAs.map((va) => Text('- ${va.name} (${va.role})')).toList(),
            const SizedBox(height: 16),
            Text('Tasks:'),
            ...project.tasks.map((task) => Text('- ${task.title}: ${task.description}')).toList(),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showCreateProjectDialog(BuildContext context, VAProjectManager manager) {
    final TextEditingController titleController = TextEditingController();
    DateTime? startDate;
    DateTime? endDate;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Create Project'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Project Title'),
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'Start Date (YYYY-MM-DD)'),
              onChanged: (value) {
                startDate = DateTime.tryParse(value);
              },
            ),
            const SizedBox(height: 8),
            TextField(
              decoration: InputDecoration(labelText: 'End Date (YYYY-MM-DD)'),
              onChanged: (value) {
                endDate = DateTime.tryParse(value);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (titleController.text.isNotEmpty && startDate != null && endDate != null) {
                final newProject = Project(
                  title: titleController.text,
                  manager: manager,
                  startDate: startDate!,
                  dueDate: endDate!,
                  tasks: [],
                  assignedVAs: <VirtualAssistant>[].obs,
                );
                controller.addProjectToManager(manager, newProject);
                Navigator.of(context).pop();
              }
            },
            child: Text('Create'),
          ),
        ],
      ),
    );
  }

  void _showHireVADialog(BuildContext context) {
    final VAProjectManagerController controller = Get.find();
    String managerName = '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Hire VA Project Manager'),
        content: TextField(
          onChanged: (value) => managerName = value,
          decoration: InputDecoration(hintText: 'Project Manager Name'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (managerName.isNotEmpty) {
                controller.hireVAProjectManager(managerName);
                Navigator.of(context).pop();
              }
            },
            child: Text('Hire'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(niche.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    child: Text(
                      'A',
                      style: TextStyle(fontSize: 24),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(() {
                        return Row(
                          children: controller.availableVAs.map((va) {
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                children: [
                                  CircleAvatar(
                                    radius: 20,
                                    child: Text(
                                      va.name[0],
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(va.name),
                                  Text('Title: ${va.role}'),
                                  Text('Tasks assigned: ${va.taskCount}'),
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      }),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => _showHireVADialog(context),
                child: Text('Hire VA Project Manager'),
              ),
              const SizedBox(height: 16),
              Text(
                'VA Managers:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() {
                if (controller.vaManagers.isEmpty) {
                  return Container(); // Empty container if no vaManagers
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.vaManagers.length,
                  itemBuilder: (context, index) {
                    final manager = controller.vaManagers[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              child: Text(
                                manager.name[0],
                                style: TextStyle(fontSize: 24),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              manager.name,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () => _showManageVADialog(context, manager),
                              child: Text('Manage Assigned VAs'),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: () => _showManageProjectDialog(context, manager),
                              child: Text('Manage Projects'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Assigned VAs:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                          children: manager.assignedVAs.map((va) {
                            return Chip(
                              label: Text('${va.name} (${va.role})'),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Projects:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ...manager.projects.map((project) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                title: Text(project.title),
                                subtitle: Text(
                                  'Start: ${project.startDate.toLocal()} Due: ${project.dueDate.toLocal()}',
                                ),
                                onTap: () => _showProjectDetailsDialog(context, project),
                              ),
                              Text(
                                'Assigned VAs:',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ...project.assignedVAs.map((va) => Padding(
                                padding: const EdgeInsets.only(left: 16.0),
                                child: Text('- ${va.name} (${va.role})'),
                              )).toList(),
                            ],
                          );
                        }).toList(),
                        const SizedBox(height: 16),
                      ],
                    );
                  },
                );
              }),
              const SizedBox(height: 16),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: niche.tasks
                    .map((task) => ExpandableTaskCard(task: task, darkTheme: darkTheme))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VAProjectManager {
  String name;
  RxList<Project> projects;
  RxList<VirtualAssistant> assignedVAs;
  VAProjectManager({required this.name, required this.projects, required this.assignedVAs});
}

class Project {
  String title;
  VAProjectManager manager;
  DateTime startDate;
  DateTime dueDate;
  List<Task> tasks;
  RxList<VirtualAssistant> assignedVAs;

  Project({
    required this.title,
    required this.manager,
    required this.startDate,
    required this.dueDate,
    required this.tasks,
    required this.assignedVAs,
  });
}

class Task {
  String title;
  String description;
  DateTime deadline;
  bool isCompleted;

  Task({
    required this.title,
    required this.description,
    required this.deadline,
    this.isCompleted = false,
  });
}

class VirtualAssistant {
  String name;
  String role;
  int taskCount;

  VirtualAssistant({
    required this.name,
    required this.role,
    required this.taskCount,
  });
}

class VAProjectManagerController extends GetxController {
  var vaManagers = <VAProjectManager>[].obs;
  var availableVAs = <VirtualAssistant>[
    VirtualAssistant(name: "Jane Smith", role: "Designer", taskCount: 2),
    VirtualAssistant(name: "Robert Brown", role: "Developer", taskCount: 3),
  ].obs;

  void hireVAProjectManager(String name) {
    vaManagers.add(VAProjectManager(name: name, projects: <Project>[].obs, assignedVAs: <VirtualAssistant>[].obs));
  }

  void assignVAsToManager(VAProjectManager manager, List<VirtualAssistant> vas) {
    manager.assignedVAs.clear();
    manager.assignedVAs.addAll(vas);
    vaManagers.refresh();
    availableVAs.removeWhere((va) => vas.contains(va));
  }

  void addProjectToManager(VAProjectManager manager, Project project) {
    manager.projects.add(project);
    vaManagers.refresh();
  }
}

class ExpandableTaskCard extends StatefulWidget {
  final Map<String, String> task;
  final bool darkTheme;

  const ExpandableTaskCard({required this.task, required this.darkTheme});

  @override
  _ExpandableTaskCardState createState() => _ExpandableTaskCardState();
}

class _ExpandableTaskCardState extends State<ExpandableTaskCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ExpansionTile(
        title: Text(
          widget.task.keys.first,
          style: TextStyle(
            color: widget.darkTheme ? AppColors.darkText : AppColors.lightText,
          ),
        ),
        trailing: Icon(
          isExpanded ? Icons.expand_less : Icons.expand_more,
          color: widget.darkTheme ? AppColors.darkText : AppColors.lightText,
        ),
        onExpansionChanged: (bool expanded) {
          setState(() {
            isExpanded = expanded;
          });
        },
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              widget.task.values.first,
              style: TextStyle(
                color: widget.darkTheme ? AppColors.darkText : AppColors.lightText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
