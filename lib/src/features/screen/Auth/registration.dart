import 'package:flutter/material.dart';
import 'package:oraah_app/src/common_widgets/custom_text_field.dart';
import 'package:oraah_app/src/features/controllers/deviceSpecController.dart';
import '../../../constants/text_strings.dart';
import 'package:get/get.dart';

class Registration extends StatelessWidget {
  Registration({super.key});

  final emailTxtController = TextEditingController();
  final fullNameTxtController = TextEditingController();
  final passwordTxtController = TextEditingController();
  final confirmPasswordTxtController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final deviceSpacController = Get.put(DeviceSpacController(context));
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Stack(
            children: [
              Positioned(
                  top: -50,
                  right: -50,
                  child: Image.asset('assets/images/reg_blob.png',height: 200,width: 200,)),
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
                        controller: emailTxtController),
                    const SizedBox(
                      height: 12.0,
                    ),
                    CustomTextField(
                        hintText: confirmHintTxt,
                        obscureText: false,
                        prefixIcon: Icons.check_box,
                        controller: emailTxtController),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: deviceSpacController.deiceWidth * 0.95,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text(
                          registerBtn,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
