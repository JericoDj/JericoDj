import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../utils/colors/colors.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../loginscreen/login_screen.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final nameTextEditingController = TextEditingController();
  final emailTextEditingController = TextEditingController();
  final phoneTextEditingController = TextEditingController();
  final addressTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();
  final confirmTextEditingController = TextEditingController();

  bool _passwordVisible = false;
  bool _confirmpasswordVisible = false;

  // Declare a GlobalKey
  final _formKey = GlobalKey<FormState>();

  // Add the function to save user details to Firestore
  Future<void> addUserDetails(
      String userId, // Added parameter for userId
      String name,
      String email,
      String password,
      ) async {
    // Assuming you have a 'users' collection in Firestore
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    await users.add({
      'userId': userId, // Save the userId in Firestore
      'name': name,
      'email': email,
      'password': password,
      // Add other user details as needed
    });
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim(),
        );

        // Retrieve the uid from the UserCredential
        String userId = userCredential.user?.uid ?? "";

        // Save additional user details to Firestore
        await addUserDetails(
          userId, // Pass the uid to addUserDetails
          nameTextEditingController.text.trim(),
          emailTextEditingController.text.trim(),
          passwordTextEditingController.text.trim(),
        );

        // Optionally, you can add additional logic or UI updates here

        // Show success message
        Fluttertoast.showToast(msg: "Successfully Registered");

        // Navigate to the main screen
        Get.to(LoginScreen());
      } catch (error) {
        // Handle Firebase authentication or Firestore submission error
        Fluttertoast.showToast(msg: "Error occurred: \n $error");
      }
    } else {
      Fluttertoast.showToast(msg: "Not all fields are valid");
    }
  }

  @override
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
                  'Registration',
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
                              controller: nameTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Name",
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
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Name can\'t be empty';
                                }
                                if (text.length < 2) {
                                  return "Please Enter a valid name";
                                }
                                if (text.length > 49) {
                                  return "Name can\'t be more than 50";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
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
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Email can\'t be empty';
                                }
                                if (EmailValidator.validate(text)) {
                                  return null;
                                }
                                return "Please Enter a valid email";
                              },
                            ),
                            SizedBox(height: 20),
                            IntlPhoneField(
                              showCountryFlag: false,
                              dropdownIcon: Icon(
                                Icons.arrow_drop_down,
                                color: darkTheme ? AppColors.accent : AppColors.primary,
                              ),
                              decoration: InputDecoration(
                                hintText: "Phone",
                                hintStyle: TextStyle(color: darkTheme ? AppColors.darkHint : AppColors.lightHint),
                                filled: true,
                                fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                                ),
                              ),
                              onChanged: (text) {
                                phoneTextEditingController.text = text.completeNumber;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: addressTextEditingController,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Address",
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
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Address can\'t be empty';
                                }
                                if (text.length < 2) {
                                  return "Please Enter a valid Address";
                                }
                                if (text.length > 50) {
                                  return "Address can\'t be more than 50";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: passwordTextEditingController,
                              obscureText: !_passwordVisible,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(color: darkTheme ? AppColors.darkHint : AppColors.lightHint),
                                filled: true,
                                fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme ? AppColors.accent : AppColors.primary),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: darkTheme ? AppColors.accent : AppColors.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Password can\'t be empty';
                                }
                                if (text.length < 2) {
                                  return "Please Enter a valid Password";
                                }
                                if (text.length > 50) {
                                  return "Password can\'t be more than 50";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20),
                            TextFormField(
                              controller: confirmTextEditingController,
                              obscureText: !_confirmpasswordVisible,
                              inputFormatters: [LengthLimitingTextInputFormatter(50)],
                              decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: TextStyle(color: darkTheme ? AppColors.darkHint : AppColors.lightHint),
                                filled: true,
                                fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(width: 0, style: BorderStyle.none),
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme ? AppColors.accent : AppColors.primary),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _confirmpasswordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: darkTheme ? AppColors.accent : AppColors.primary,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _confirmpasswordVisible = !_confirmpasswordVisible;
                                    });
                                  },
                                ),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (text) {
                                if (text == null || text.isEmpty) {
                                  return 'Confirm Password can\'t be empty';
                                }
                                if (text != passwordTextEditingController.text) {
                                  return "Password do not match";
                                }
                                if (text.length < 2) {
                                  return "Please Enter a valid Password";
                                }
                                if (text.length > 50) {
                                  return "Password can\'t be more than 50";
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
                                  'Register',
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
                                Get.to(ForgotPasswordScreen());
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
                                  'Forgot Password',
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
                                  "Have an account?",
                                  style: TextStyle(
                                    color: darkTheme ? AppColors.darkHint : AppColors.lightHint,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(width: 5),
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
                                      "Sign In",
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
