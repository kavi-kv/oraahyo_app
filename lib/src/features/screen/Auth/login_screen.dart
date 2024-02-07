import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oraah_app/src/Home.dart';
import 'package:oraah_app/src/constants/text_strings.dart';
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
  final emailTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void loginUser() {
      AuthController.instance
          .signIn(emailTxtController.text, passwordTxtController.text, context);
    }

    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Welcome back",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(
            height: 25.0,
          ),
          CustomTextField(
            hintText: "Email",
            obscureText: false,
            prefixIcon: Icons.person,
            controller: emailTxtController,
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Please fill the email field";
              }
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
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(""),
              Padding(
                  padding: EdgeInsets.only(right: 20),
                  child: Text("Forget Password"))
            ],
          ),
          const SizedBox(
            height: 25.0,
          ),
          SizedBox(
            width: media.width * 0.95,
            height: 55,
            child: ElevatedButton(
              onPressed: loginUser,
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextButton(
            onPressed: () => Get.to(() => Registration()),
            child: Text.rich(
              TextSpan(
                  text: tDontHaveAcc.toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(fontSize: 12.0),
                  children: const [
                    TextSpan(
                      text: tSignUp,
                      style: TextStyle(color: Colors.blue),
                    ),
                    TextSpan(
                      text: tSignUp,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ]),
            ),
          )
        ],
      ),
    );
  }
}
