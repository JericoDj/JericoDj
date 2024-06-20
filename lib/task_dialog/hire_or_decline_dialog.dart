import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:slider_button/slider_button.dart';

import '../controller/assistants_controller/applicants_controller.dart';
import '../models/applicant_model.dart';

class HireDeclineDialog extends StatelessWidget {
  final Applicant applicant;
  final String action;

  HireDeclineDialog({
    required this.applicant,
    required this.action,
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  action == 'Hire' ? 'Hire Applicant' : 'Decline Applicant',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop(false);  // Ensure false is returned
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue,
              backgroundImage: NetworkImage('https://loremflickr.com/320/240'),
            ),
            const SizedBox(height: 10),
            Text(
              applicant.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              'Are you sure you want to ${action.toLowerCase()} this applicant?',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            SliderButton(
              buttonColor: Colors.yellow,
              shimmer: true,
              action: () async {
                final ApplicantsController applicantsController = Get.find();
                if (action == 'Hire') {
                  applicantsController.hireApplicant(applicant);
                } else {
                  applicantsController.declineApplicant(applicant);
                }
                Navigator.of(context).pop(true);  // Ensure true is returned
              },
              label: Text(
                'Slide to $action',
                style: TextStyle(color: Colors.black),
              ),
              icon: Icon(Icons.arrow_right_alt, color: Colors.blueAccent, size: 30,),
              width: 300,
              height: 60,
              buttonSize: 60,
              backgroundColor: Colors.grey.shade300,
              highlightedColor: Colors.green,
              baseColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
