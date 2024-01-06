import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:oraah_app/src/Home.dart';
import 'package:oraah_app/src/constants/text_strings.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/features/screen/MainScreen.dart';
import 'package:oraah_app/src/services/api/auth_services.dart';
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
      AuthService().signIn(
          email: emailTxtController.text,
          password: passwordTxtController.text,
          onSuccess: () {
            if (mounted) {
              Get.off(() => const MainScreen());
            }
          },
          onError: (message) {
            if (mounted) {
              showSnackBar(context, message);
            }
          });
    }

    final media = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Column(
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
                hintText: "Full Name",
                obscureText: false,
                prefixIcon: Icons.person,
                controller: emailTxtController),
            const SizedBox(
              height: 12.0,
            ),
            CustomTextField(
              hintText: "Password",
              obscureText: true,
              prefixIcon: Icons.security,
              suffixIcon: Icons.visibility_off_rounded,
              controller: passwordTxtController,
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
      ),
    );
  }
}
