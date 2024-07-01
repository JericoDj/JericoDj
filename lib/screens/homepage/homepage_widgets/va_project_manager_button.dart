import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/colors/colors.dart';

class VAProjectManagerContainer extends StatelessWidget {
  final bool darkTheme;

  const VAProjectManagerContainer({required this.darkTheme});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: context.width,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        margin: const EdgeInsets.all(20),
        child: GestureDetector(
          onTap: () {
            // Navigate to the VAProjectManagerPage on tap
            Get.to(() => VAProjectManagerPage());
          },
          child: CustomPaint(
            painter: GradientBorderPainter(
              strokeWidth: 3.0,
              radius: 10.0,
              gradient: LinearGradient(
                colors: darkTheme
                    ? [AppColors.primary, AppColors.secondary]
                    : [AppColors.paletteGreen2, AppColors.paletteCyan2],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              margin: const EdgeInsets.all(10),

              decoration: BoxDecoration(
                color: darkTheme ? AppColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: darkTheme
                            ? [AppColors.primary, AppColors.secondary]
                            : [AppColors.paletteGreen3, AppColors.paletteCyan3],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Icon(
                      Icons.manage_accounts,
                      color: Colors.white, // This color won't be visible due to the shader mask
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ShaderMask(
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: darkTheme
                            ? [AppColors.primary, AppColors.secondary]
                            : [AppColors.paletteGreen1, AppColors.paletteCyan2],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ).createShader(bounds);
                    },
                    child: Text(
                      'VA Project Manager',
                      style: TextStyle(

                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white, // This color won't be visible due to the shader mask

                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
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

class VAProjectManagerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VA Project Manager'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to the VA Project Manager',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'This page is designed to help you manage your virtual assistant projects efficiently. Here you can keep track of tasks, deadlines, and communicate with your team members. Stay organized and boost your productivity with our comprehensive project management tools.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
