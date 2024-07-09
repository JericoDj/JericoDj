import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/homepage_datas/va_niche_data/va_niche_data.dart';
import '../../../utils/colors/colors.dart';

class SpecializedVADrawer extends StatelessWidget {
  final bool darkTheme;

  const SpecializedVADrawer({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Stack(
          children: [
            // Gradient border container
            Positioned.fill(
              child: CustomPaint(
                painter: BorderPainter(),
                child: Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Transparent container to show the gradient border
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent, // White background for the inner content
              ),
              child: Theme(
                data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0), // Add padding to the top
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            darkTheme ? AppColors.primary : AppColors.paletteGreen1,
                            darkTheme ? AppColors.darkBackground : AppColors.paletteCyan2,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds),
                        child: Text(
                          'Specialized Virtual Assistants',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white, // Set text color to white
                          ),
                          textAlign: TextAlign.center, // Center align the text
                        ),
                      ),
                    ),
                    const SizedBox(height: 10), // Add space between title and content
                    Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.transparent, // Background color for the expanded content
                        borderRadius: BorderRadius.circular(10),
                      ),
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          return Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 10,
                            runSpacing: 10,
                            children: List.generate(vaNiches.length, (index) {
                              return Container(
                                height: 50,
                                width: (constraints.maxWidth / 2) - 10,
                                child: VAContainer(niche: vaNiches[index], darkTheme: darkTheme),
                              );
                            }),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 10,)
                  ],
                ),
              ),
            ),
          ],
        ),
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
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkTheme ? AppColors.primary.withOpacity(0.8) : AppColors.paletteGreen2,
              darkTheme ? AppColors.darkBackground.withOpacity(0.8) : AppColors.paletteCyan2,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            niche.name,
            style: TextStyle(
              fontSize: 12,
              color: darkTheme ? Colors.white : AppColors.darkText, // Ensure contrast
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center, // Center align the text
          ),
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

// Custom painter for the gradient border
class BorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.paletteGreen2, AppColors.paletteCyan2],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final RRect rrect = RRect.fromRectAndRadius(rect, Radius.circular(10));
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
