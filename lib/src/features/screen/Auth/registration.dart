import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/custom_text_field.dart';
import 'package:oraah_app/src/features/controllers/auth/sign_up_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/services/api/auth_services.dart';
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

  @override
  Widget build(BuildContext context) {
    final signUpController = Get.put(SignUpController());
    final _formKey = GlobalKey<FormState>();
    final deviceSpacController = Get.put(DeviceSpacController(context));

    void signupUser() {
      AuthService().signUpUser(
          // context: context,
          email: emailTxtController.text,
          password: passwordTxtController.text,
          name: fullNameTxtController.text,
          onSuccess: () {
            if(mounted){
              showSnackBar(context, "Account created! Login with the same credentials!");
            }
          },
          onError: (String message) {
      if (mounted) {
        showSnackBar(context, message);
      }
    },
          );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
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
                margin: const EdgeInsets.symmetric(vertical: 160.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      regTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    CustomTextField(
                        hintText: nameHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.person,
                        controller: fullNameTxtController),
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextField(
                        hintText: emailHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.mail,
                        controller: emailTxtController),
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextField(
                        hintText: passwordHintTxt,
                        obscureText: true,
                        suffixIcon: Icons.remove_red_eye,
                        prefixIcon: Icons.security,
                        controller: passwordTxtController),
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextField(
                        hintText: confirmHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.check_box,
                        controller: confirmPasswordTxtController),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: deviceSpacController.deiceWidth * 0.95,
                      child: ElevatedButton(
                        onPressed: signupUser,
                        child: Text(
                          registerBtn,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
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
    );
  }
}
