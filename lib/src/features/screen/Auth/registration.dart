import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/custom_text_field.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';
import 'package:oraah_app/src/utils/utils.dart';
import '../../../constants/images.dart';
import '../../../constants/text_strings.dart';
import 'package:get/get.dart';

import 'login_screen.dart';

class Registration extends StatefulWidget {
  Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final emailTxtController = TextEditingController();

  final fullNameTxtController = TextEditingController();

  final passwordTxtController = TextEditingController();

  final confirmPasswordTxtController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final deviceSpacController = Get.put(DeviceSpacController(context));

    void signupUser() {
      AuthController.instance.registerUser(emailTxtController.text,
          passwordTxtController.text, fullNameTxtController.text, context);
    }

    bool isFormValid() {
      return _formKey.currentState?.validate() ?? false;
    }

    return Scaffold(
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
                        style: Theme.of(context).textTheme.headlineMedium,
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
                        width: deviceSpacController.deiceWidth * 0.95,
                        child: ElevatedButton(
                          onPressed: () {
                            if (isFormValid()) {
                              signupUser();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: Text(
                            registerBtn,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
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
                                  style: Theme.of(context).textTheme.bodyMedium,
                                )),
                          ),
                          TextButton(
                            onPressed: () => Get.to(() => const LoginScreen()),
                            child: Text.rich(
                              TextSpan(
                                  text: tAlreadyHaveAnAccount.toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(fontSize: 12.0),
                                  children: const [
                                    TextSpan(
                                      text: tLogin,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    TextSpan(
                                      text: tLogin,
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                  ]),
                            ),
                          )
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
