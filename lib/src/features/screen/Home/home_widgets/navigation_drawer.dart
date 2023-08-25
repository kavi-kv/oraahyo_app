
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class NavigationsDrawer extends StatelessWidget {
  const NavigationsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.only(top: 35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              leading: Icon(Icons.explore),
              title: Text("About",style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text("Setting",style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text("Info",style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline),
              title: Text("favourite",style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.help_center_rounded),
              title: Text("Help",style: Theme.of(context).textTheme.bodyMedium,),
              trailing: Icon(LineAwesomeIcons.angle_right),
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text("Logout",style: Theme.of(context).textTheme.bodyMedium,),
             
            ),
            
          ],
        ),
      ),
    );
  }
}



