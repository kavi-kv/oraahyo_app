import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/constants/color.dart';
import 'package:oraah_app/src/features/screen/widgets/Profile_Tile.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {},
          icon: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                LineAwesomeIcons.arrow_left,
                color: Colors.black,
              )),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            margin: const EdgeInsets.only(right: 10, top: 10, left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => UserProfileUpdate(user: user)),
                  // );
                },
                icon: const Icon(
                  LineAwesomeIcons.pen_square,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /* Profile Header */
            Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  margin: const EdgeInsets.only(left: 16, top: 20),
                  decoration: BoxDecoration(
                      // color: Colors.red
                      ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(""),
                    SizedBox(
                      height: 8,
                    ),
                    Text("data")
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            /* Phone And Email */
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 18),
                          child: Icon(
                            Icons.phone,
                            color: Colors.grey[700],
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text("User Mobile")
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Container(
                          margin: const EdgeInsets.only(left: 18),
                          child: Icon(
                            Icons.email_outlined,
                            color: Colors.grey[700],
                          )),
              
                      const Divider(),
                      const SizedBox(
                        height: 10,
                      ),
              
                      /* Other Profile Categories */
                      ProfileTile(
                        title: "Bookmark",
                        icon: LineAwesomeIcons.bookmark,
                        onPress: () {},
                        leadingIconColor: tYellowish,
                      ),
                      const Divider(
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      ProfileTile(
                        title: "tSetting",
                        icon: LineAwesomeIcons.accusoft,
                        onPress: () {},
                        leadingIconColor: tYellowish
                      ),
                      ProfileTile(
                        title: "tLogOut",
                        icon: LineAwesomeIcons.arrow_right,
                        onPress: () {},
                        endIcon: false,
                        color: Colors.red,
                        leadingIconColor: Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
