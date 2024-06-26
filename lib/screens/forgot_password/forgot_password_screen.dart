import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../utils/colors/colors.dart';
import '../loginscreen/login_screen.dart';
import '../registerscreen/register_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailTextEditingController = TextEditingController();

  // Declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text("Checking user and sending password reset email..."),
              ],
            ),
          ),
        );

        // Check if the email exists in Firestore
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: emailTextEditingController.text.trim())
            .get();

        if (querySnapshot.docs.isEmpty) {
          // Close the loading indicator dialog
          Navigator.of(context).pop();
          Fluttertoast.showToast(msg: "No user found with this email address.");
          return;
        }

        // Attempt to send a password reset email
        await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailTextEditingController.text.trim(),
        );

        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "We have sent you an email to recover the password, please check your email.",
        );
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop();
        if (e.code == 'user-not-found') {
          Fluttertoast.showToast(msg: "No user found with this email address.");
        } else {
          Fluttertoast.showToast(msg: "Error Occurred: \n${e.message}");
        }
      } catch (error) {
        Navigator.of(context).pop();
        Fluttertoast.showToast(msg: "Error Occurred: \n${error.toString()}");
      }
    }
  }

  Widget build(BuildContext context) {
    bool darkTheme = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(0),
          children: [
            Column(
              children: [
                Image.asset(darkTheme ? 'assets/images/darkmode.png' : 'assets/images/lightmode.jpg'),
                SizedBox(height: 20),
                Text(
                  'Password Recovery',
                  style: TextStyle(
                    color: darkTheme ? AppColors.buttonGradientEnd : AppColors.primary,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: emailTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: darkTheme ? AppColors.darkHint : AppColors.lightHint),
                                filled: true,
                                fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme ? AppColors.accent : AppColors.primary),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (email) {
                                if (email == null || email.isEmpty) {
                                  return 'Email can\'t be empty';
                                }
                                if (EmailValidator.validate(email) == true) {
                                  return null;
                                }
                                if (email.length < 8) {
                                  return "Please Enter a valid email";
                                }
                                if (email.length > 50) {
                                  return "Email can\'t be more than 50";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.buttonGradientStart,
                                    AppColors.buttonGradientEnd,
                                  ],
                                ),
                              ),
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                ),
                                onPressed: _submit,
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: darkTheme ? AppColors.darkText : AppColors.lightSurface,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                Get.to(LoginScreen());
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    AppColors.buttonGradientStart,
                                    AppColors.buttonGradientEnd,
                                  ],
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds),
                                child: Text(
                                  'Already have an Account',
                                  style: TextStyle(
                                    color: darkTheme ? AppColors.darkText : AppColors.lightText,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Doesn't have an account?",
                                  style: TextStyle(
                                    color: darkTheme ? AppColors.darkHint : AppColors.lightHint,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
                                GestureDetector(
                                  onTap: () {
                                    Get.to(RegisterScreen());
                                  },
                                  child: ShaderMask(
                                    shaderCallback: (bounds) => LinearGradient(
                                      colors: [
                                        AppColors.buttonGradientStart,
                                        AppColors.buttonGradientEnd,
                                      ],
                                      tileMode: TileMode.mirror,
                                    ).createShader(bounds),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        color: darkTheme ? AppColors.darkText : AppColors.lightText,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
