import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:oraah_app/src/constants/color.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.color,
    required this.leadingIconColor,
  });

  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? color;
  final Color? leadingIconColor;

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    // var iconColor = isDark ? colors['primary'] : colors['secondary'];
    return ListTile(
      shape: const StadiumBorder(),
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: tYellowish.withOpacity(0.1)),
        child: Icon(icon,color: leadingIconColor,),
      ),
      title: Text("Title"),
      trailing: endIcon
          ? Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.grey.withOpacity(0.1)),
        child:  const Icon(
          LineAwesomeIcons.angle_right,
          size: 18.0,
          color: tYellowish,
        ),
      )
          : null,
    );
  }
}
