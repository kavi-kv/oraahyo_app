import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/constants/images.dart';
import 'package:oraah_app/src/constants/text_strings.dart';
import 'package:oraah_app/src/features/controllers/User/user_controller.dart';
import 'package:oraah_app/src/features/controllers/auth/auth_controller.dart';
import 'package:oraah_app/src/features/controllers/others/deviceSpecController.dart';
import 'package:oraah_app/src/features/screen/Auth/login_screen.dart';
import 'package:oraah_app/src/features/screen/Auth/registration.dart';
import 'package:oraah_app/src/features/screen/profile/user_profile.dart';
import 'package:oraah_app/src/repository/services/api/auth_services.dart';

class NavigationsDrawer extends StatefulWidget {
  const NavigationsDrawer({
    super.key,
  });

  @override
  State<NavigationsDrawer> createState() => _NavigationsDrawerState();
}

class _NavigationsDrawerState extends State<NavigationsDrawer> {
  late UserController userController;
  final authController = AuthController();
  bool isLoggedIn = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
    print("Inside Drawer Widget=> ${userController.isLoggedIn}");
  }

  void signOutUser() {
    AuthService().signOut();
  }

  void logOut(){
    authController.logOut();
  }

  // UserController get userController => Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        // padding: const EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              if (userController.userIsLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (userController.isLoggedIn) {
                return const BuildLoggedInUserHeader();
              }
              return const BuildLoggedOutUserHeader();
            }),
            // FutureBuilder<bool>(
            //   future: AuthService().validateToken(),
            //   builder: (context, snapshot) {
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: SizedBox(
            //           width: 50.0,
            //           height: 50.0,
            //           child: CircularProgressIndicator(
            //             backgroundColor: Colors.grey,
            //             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            //             strokeWidth: 5.0,
            //           ),
            //         ),
            //       );
            //     } else if (snapshot.hasData && snapshot.data == true) {
            //       return const _buildLoggedInUserHeader();
            //     } else {
            //       return const _buildLoggedOutUserHeader();
            //     }
            //   },
            // ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              leading: const Icon(Icons.explore),
              title: Text(
                "About",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                "Setting",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: Text(
                "Info",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: const Icon(Icons.favorite_outline),
              title: Text(
                "favourite",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(LineAwesomeIcons.angle_right),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help_center_rounded),
              title: Text(
                "Help",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: const Icon(LineAwesomeIcons.angle_right),
            ),
            Obx(() => userController.user.token.isEmpty
                ? InkWell(
                    child: ListTile(
                      leading: const Icon(Icons.login_outlined),
                      title: Text(
                        "Login",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  )
                : userController.user.token.isNotEmpty
                    ? InkWell(
                        onTap: logOut,
                        child: ListTile(
                          leading: const Icon(Icons.logout_outlined),
                          title: Text(
                            "Logout",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      )
                    : InkWell(
                        child: ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(
                            "Profile",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                          trailing: const Icon(LineAwesomeIcons.angle_right),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}

class BuildLoggedOutUserHeader extends StatelessWidget {
  const BuildLoggedOutUserHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      height: 120,
      color: tDarkPurple,
      // width: deviceSpecController.deiceWidth * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const Registration());
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: tDarkBlue,
                      side: const BorderSide(color: tWhiteSnow)),
                  child: const Text(tSignUp)),
              const SizedBox(
                width: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(() => const LoginScreen());
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: tDarkBlue,
                      side: const BorderSide(color: tWhiteSnow)),
                  child: const Text(tLogin)),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton.icon(
                  icon: const Image(
                    image: AssetImage(tGoogleLogoImage),
                    width: 25.0,
                    height: 25.0,
                  ),
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: tDarkBlue,
                      side: const BorderSide(color: tWhiteSnow)),
                  label: Text(
                    "",
                    style: Theme.of(context).textTheme.bodyMedium,
                  )),
            ],
          )
        ],
      ),
    );
  }
}

class BuildLoggedInUserHeader extends StatelessWidget {
  const BuildLoggedInUserHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Container(
              height: 120,
              color: tDarkBlue,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: ClipRRect(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset(user_icon),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              UserController.instance.user.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(color: tBabbyPowder),
                            ),
                            // const SizedBox(height: 5,),
                            Text(
                              UserController.instance.user.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelSmall
                                  ?.copyWith(
                                      color: tBabbyPowder,
                                      fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: Container(
                decoration: const BoxDecoration(
                  color: tGreySnow,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  onPressed: () {
                    Get.to(const UserProfile());
                  },
                  icon: const Icon(
                    Icons.edit,
                  ),
                  color: tBabbyPowder,
                ),
              ),
            ),
          ],
        ));
  }
}
