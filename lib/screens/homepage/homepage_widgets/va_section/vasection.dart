import 'package:Sourcefully/screens/homepage/homepage_widgets/va_section/va_project_manager_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../data/homepage_datas/va_niche_data/va_niche_data.dart';
import '../../../../utils/colors/colors.dart';

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity, // Make the container take full width
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.paletteGreen2,
                            AppColors.paletteCyan1,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: HeaderSection(darkTheme: darkTheme),
                    ),
                  ),
                  const SizedBox(height: 10), // Add space between title and content
                  NichesSection(darkTheme: darkTheme),
                  const SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  final bool darkTheme;

  const HeaderSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0,), // Add padding to the top and bottom
      child: ShaderMask(
        shaderCallback: (bounds) => LinearGradient(
          colors: [
            darkTheme ? AppColors.primary : AppColors.lightBackground,
            darkTheme ? AppColors.darkBackground : AppColors.lightBackground,
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
    );
  }
}

class NichesSection extends StatelessWidget {
  final bool darkTheme;

  const NichesSection({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double boxHeight = screenHeight * 0.07; // Adjust this value as needed

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.transparent, // Background color for the expanded content
        borderRadius: BorderRadius.circular(10),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            alignment: WrapAlignment.center,
            spacing: 10, // Adjust spacing between boxes
            runSpacing: 10, // Adjust spacing between boxes
            children: List.generate(vaNiches.length, (index) {
              return Container(
                height: boxHeight, // Adjust height of the box
                width: (constraints.maxWidth / 2) - 20, // Adjust width of the box
                child: VAContainer(niche: vaNiches[index], darkTheme: darkTheme),
              );
            }),
          );
        },
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
        Get.to(() => VAProjectManagerPage(niche: niche, darkTheme: darkTheme));
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              darkTheme ? AppColors.primary.withOpacity(0.8) : AppColors.lightBackground,
              darkTheme ? AppColors.darkBackground.withOpacity(0.8) : AppColors.lightBackground,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 3,
            style: BorderStyle.solid,
            color: Colors.transparent, // Required for the gradient border
          ),
        ),
        child: CustomPaint(
          painter: GradientBorderPainter(
            strokeWidth: 3.0,
            radius: 10.0,
            gradient: LinearGradient(
              colors: [
                darkTheme ? AppColors.primary : AppColors.paletteGreen2,
                darkTheme ? AppColors.darkBackground : AppColors.paletteCyan2,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [AppColors.paletteGreen2, AppColors.paletteCyan2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds),
              child: Text(
                niche.name,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white, // The actual color doesn't matter due to the ShaderMask
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center, // Center align the text
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class GradientBorderPainter extends CustomPainter {
  final double strokeWidth;
  final double radius;
  final Gradient gradient;

  GradientBorderPainter({
    required this.strokeWidth,
    required this.radius,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..shader = gradient.createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final RRect outerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    canvas.drawRRect(outerRect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
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
