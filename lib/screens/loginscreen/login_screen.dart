import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../controller/navigation_controller.dart';
import '../../global/global.dart';
import '../../utils/colors/colors.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../homepage/homepage.dart';
import '../registerscreen/register_screen.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

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
                Image.asset(
                  darkTheme ? 'assets/images/darkmode.png' : 'assets/images/lightmode.jpg',
                ),
                SizedBox(height: 20),
                ShaderMask(
                  shaderCallback: (bounds) => LinearGradient(
                    colors: [
                      AppColors.paletteCyan3,
                      AppColors.paletteGreen3,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white, // This color will be used for the gradient text
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Form(
                        key: controller.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextFormField(
                              controller: controller.emailController,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(50)
                              ],
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: darkTheme ? AppColors.darkHint : AppColors.lightHint,
                                ),
                                filled: true,
                                fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                  borderSide: BorderSide(
                                    width: 0,
                                    style: BorderStyle.none,
                                  ),
                                ),
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: darkTheme ? AppColors.accent : AppColors.paletteGreen2,
                                ),
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
                            Obx(
                                  () => TextFormField(
                                controller: controller.passwordController,
                                obscureText: !controller.passwordVisible.value,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(50)
                                ],
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    color: darkTheme ? AppColors.darkHint : AppColors.lightHint,
                                  ),
                                  filled: true,
                                  fillColor: darkTheme ? AppColors.darkSurface : AppColors.lightSurface,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(40),
                                    borderSide: BorderSide(
                                      width: 0,
                                      style: BorderStyle.none,
                                    ),
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: darkTheme ? AppColors.accent : AppColors.paletteGreen2,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      controller.passwordVisible.value
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: darkTheme ? AppColors.accent : AppColors.paletteGreen2,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                ),
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                validator: (text) {
                                  if (text == null || text.isEmpty) {
                                    return 'Password can\'t be empty';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(32),
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.paletteCyan2,
                                    AppColors.paletteYellow2,
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
                                onPressed: controller.submit,
                                child: Text(
                                  'Login',
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
                                    AppColors.paletteCyan3,
                                    AppColors.paletteGreen3,
                                  ],
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds),
                                child: Text(
                                  'Forgot Password',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white, // This color will be used for the gradient text
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
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
                                        AppColors.paletteCyan3,
                                        AppColors.paletteGreen3,
                                      ],
                                      tileMode: TileMode.mirror,
                                    ).createShader(bounds),
                                    child: Text(
                                      "Register",
                                      style: TextStyle(
                                        fontSize: 15,

                                        color: Colors.white, // This color will be used for the gradient text
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

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var passwordVisible = false.obs;

  final formKey = GlobalKey<FormState>();
  void togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  void submit() async {
    if (formKey.currentState!.validate()) {
      try {
        await firebaseAuth
            .signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        )
            .then((auth) async {
          currentUser = auth.user;

          await Fluttertoast.showToast(msg: "Successfully Logged In");
          Get.offAll(NavigationBarMenu());
        }).catchError((errorMessage) {
          Fluttertoast.showToast(msg: "Email or Password doesn't match");
        });
      } catch (error) {
        Fluttertoast.showToast(msg: "Error Occurred: \n${error.toString()}");
      }
    } else {
      Fluttertoast.showToast(msg: "Not all fields are valid");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
