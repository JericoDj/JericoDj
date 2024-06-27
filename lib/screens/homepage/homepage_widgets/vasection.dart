// va_niches_widget.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/homepage_datas/va_niche_data/va_niche_data.dart';
import '../../../utils/colors/colors.dart';


class VANichesSection extends StatelessWidget {
  final bool darkTheme;

  VANichesSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'VA Niches',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkTheme ? AppColors.darkText : AppColors.lightText),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: vaNiches
                .map((niche) => VAContainer(niche: niche, darkTheme: darkTheme))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class VAContainer extends StatelessWidget {
  final VANiche niche;
  final bool darkTheme;

  const VAContainer({required this.niche, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => VADetailsPage(niche: niche, darkTheme: darkTheme));
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 60) / 2,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkTheme ? AppColors.primary.withOpacity(0.8) : AppColors.paletteGreen3,
              darkTheme ? AppColors.darkBackground.withOpacity(0.8) : AppColors.paletteCyan3,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          niche.name,
          style: const TextStyle(
              fontSize: 16,
              color: AppColors.darkText,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class VADetailsPage extends StatelessWidget {
  final VANiche niche;
  final bool darkTheme;

  VADetailsPage({required this.niche, required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(niche.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: niche.tasks
              .map((task) => ExpandableTaskCard(task: task, darkTheme: darkTheme))
              .toList(),
        ),
      ),
    );
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
        title: Text(widget.task.keys.first,
            style: TextStyle(
                color: widget.darkTheme ? AppColors.darkText : AppColors.lightText)),
        leading: Icon(Icons.task,
            color: widget.darkTheme ? AppColors.darkText : AppColors.lightText),
        trailing: Icon(
            isExpanded ? Icons.expand_less : Icons.expand_more,
            color: widget.darkTheme ? AppColors.darkText : AppColors.lightText),
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
                  color: widget.darkTheme ? AppColors.darkText : AppColors.lightText),
            ),
          ),
        ],
      ),
    );
  }
}
