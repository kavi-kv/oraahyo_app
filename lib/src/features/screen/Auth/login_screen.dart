import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oraah_app/src/Home.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/constants/text_strings.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/utils.dart';

import '../../../common_widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();

  @override
  void dispose() {
    emailTxtController.dispose();
    passwordTxtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    final AuthController authController = Get.find<AuthController>();
    void loginUser() {
      AuthController.instance
          .signIn(emailTxtController.text, passwordTxtController.text, context);
    }

    bool isFormValid() {
      return _formKey.currentState?.validate() ?? false;
    }

    final media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: isDark ? tDarkBlue : tWhiteSnow,
      body: SingleChildScrollView(
        child: SafeArea(
          child: SizedBox(
            // color: Colors.red,
            height: media.height * 1,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Welcome back",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.copyWith(color: isDark ? tWhiteSnow : tDarkBlue),
                  ),
                  const SizedBox(
                    height: 25.0,
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
                    height: 16.0,
                  ),
                  CustomTextField(
                    hintText: "Password",
                    obscureText: true,
                    prefixIcon: Icons.security,
                    suffixIcon: Icons.visibility_off_rounded,
                    controller: passwordTxtController,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return "Please fill the password field";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(""),
                      Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                color: isDark ? tWhiteSnow : tDarkBlue,
                                decoration: TextDecoration.underline),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  SizedBox(
                    width: media.width * 0.95,
                    height: 55,
                    child: TextButton(
                      onPressed: () {
                        if (isFormValid()) {
                          loginUser();
                        }
                      },
                      style: TextButton.styleFrom(
                          backgroundColor: isDark ? tWhiteSnow : tDarkBlue,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      child: Obx(() => authController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: isDark ? tDarkBlue : tWhiteSnow,
                                    fontWeight: FontWeight.bold,
                                  ),
                            )),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () => Get.to(() => const Registration()),
                    child: Text.rich(
                      TextSpan(
                          text: tDontHaveAcc.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(
                                  fontSize: 12.0,
                                  color: isDark ? tWhiteSnow : tDarkBlue),
                          children: [
                            const WidgetSpan(
                              child: SizedBox(
                                width: 10,
                              ),
                            ),
                            TextSpan(
                              text: tSignUp,
                              style: TextStyle(
                                  color: isDark ? tWhiteSnow : tDarkBlue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  decoration: TextDecoration.underline),
                            ),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
