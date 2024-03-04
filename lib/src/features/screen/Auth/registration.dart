import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/custom_text_field.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/utils.dart';
import '../../../constants/images.dart';
import '../../../constants/text_strings.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthController authController = Get.find<AuthController>();
  final emailTxtController = TextEditingController();
  final fullNameTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();
  final confirmPasswordTxtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailTxtController.dispose();
    passwordTxtController.dispose();
    fullNameTxtController.dispose();
    confirmPasswordTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSpacController = Get.put(DeviceSpacController(context));
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    void signupUser() {
      AuthController.instance.registerUser(emailTxtController.text,
          passwordTxtController.text, fullNameTxtController.text, context);
    }

    bool isFormValid() {
      return _formKey.currentState?.validate() ?? false;
    }


    return Scaffold(
      backgroundColor: isDark ? tDarkBlue : tWhiteSnow,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Stack(
              children: [
                Positioned(
                    top: -50,
                    right: -50,
                    child: Image.asset(
                      'assets/images/reg_blob.png',
                      height: 200,
                      width: 200,
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 100.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        regTitle,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(color: isDark ? tWhiteSnow : tDarkBlue),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      CustomTextField(
                        hintText: nameHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.person,
                        controller: fullNameTxtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter A User Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        hintText: emailHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.mail,
                        controller: emailTxtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Provide email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        hintText: passwordHintTxt,
                        obscureText: true,
                        suffixIcon: Icons.remove_red_eye,
                        prefixIcon: Icons.security,
                        controller: passwordTxtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill the password field!";
                          }
                          if (value.length < 6) {
                            return "Password should be more than 6 character";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      CustomTextField(
                        hintText: confirmHintTxt,
                        obscureText: true,
                        prefixIcon: Icons.check_box,
                        controller: confirmPasswordTxtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please fill the password field!";
                          }
                          if (value != passwordTxtController.text) {
                            return "The password don't match, try again!";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: deviceSpacController.deiceWidth * 0.90,
                        height: 60,
                        child: TextButton(
                          onPressed: () {
                            if (isFormValid()) {
                              signupUser();
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.transparent, width: 0),
                              ),
                              backgroundColor: isDark ? tWhiteSnow : tDarkBlue),
                          child: Obx(() => authController.isLoading.value
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  registerBtn,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color:
                                              isDark ? tDarkBlue : tWhiteSnow,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600),
                                )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          const Text("OR"),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: deviceSpacController.deiceWidth * 0.95,
                            height: 55,
                            child: OutlinedButton.icon(
                                icon: const Image(
                                  image: AssetImage(tGoogleLogoImage),
                                  width: 20.0,
                                ),
                                onPressed: () {},
                                label: Text(
                                  tSignInWithGoogle.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: isDark ? tWhiteSnow : tDarkBlue,
                                      ),
                                )),
                          ),
                          const SizedBox(
                            height: 7,
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => const LoginScreen());
                            },
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: tAlreadyHaveAnAccount.toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          fontSize: 12.0,
                                          color:
                                              isDark ? tWhiteSnow : tDarkBlue,
                                        ),
                                  ),
                                  const WidgetSpan(
                                    child: SizedBox(
                                        width: 5.0), // Adjust width as needed
                                  ),
                                  TextSpan(
                                    text: tLogin,
                                    style: TextStyle(
                                        color: isDark ? tWhiteSnow : tDarkBlue,
                                        decoration: TextDecoration.underline,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
