

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:virtual_assistant/Screens/register_screen.dart';

import 'login_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {


  final emailTextEditingController = TextEditingController();

  //decalare a GlobalKey
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

        // Retrieve the current user from Firebase
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          print("Current User Email: ${user.email}");
        } else {
          print("No user is currently signed in.");
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
                    color: darkTheme ? Colors.deepOrange.shade400 : Colors.teal,
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
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),
                                filled: true,
                                fillColor: darkTheme ? Colors.black45 : Colors.grey.shade200,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    )
                                ),
                                prefixIcon: Icon(Icons.person, color: darkTheme ? Colors.deepOrange : Colors.teal,),
                              ),
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              validator: (email)  {
                                if(email == null || email.isEmpty){
                                  return 'Email can\'t be empty';
                                }
                                if(EmailValidator.validate(email) == true){
                                  return null;
                                }
                                if(email.length < 8) {
                                  return "Please Enter a valid email";
                                }
                                if(email.length > 50) {
                                  return "Email can\'t be more than 50";
                                }
                              },

                              onChanged: (text) => setState(() {
                                emailTextEditingController.text = text;
                              }),
                            ),



                            SizedBox(height: 20,),

                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: darkTheme ? Colors.black : Colors.white,
                                  backgroundColor: darkTheme ? Colors.deepOrange.shade400 : Colors.teal,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32),
                                  ),
                                  minimumSize: Size(double.infinity, 50),
                                ),
                              onPressed: () {
                                _submit();
                              },
                                child: Text(
                                  'Reset Password',
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                            ),

                            SizedBox(height: 20,),

                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (c) => LoginScreen()));
                              },
                              child: Text(
                                'Already have an Account',
                                style: TextStyle(
                                    color: darkTheme ? Colors.deepOrange.shade400 : Colors.teal
                                ),
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Doesn't have an account?",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                ),

                                SizedBox(width: 5,),

                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (c) => RegisterScreen()));
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: darkTheme ? Colors.deepOrange.shade400 : Colors.teal,
                                    ),
                                  ),
                                )
                              ],
                            )
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
