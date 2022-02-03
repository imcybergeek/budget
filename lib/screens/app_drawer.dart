import 'package:flutter/material.dart';
import 'package:budget/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.zero,
      children: [
        SizedBox(
          height: 135,
          child: DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(
              child: CustomText(
                text: "XD",
                size: 100,
                color: Colors.white,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 10),
          child: CustomText(
            text: "VIP",
            size: 15,
            color: Colors.grey,
            weight: FontWeight.bold,
          ),
        ),
        DrawerTile(
          icon: FontAwesomeIcons.ad,
          text: "Remove Ads",
        ),
        DrawerTile(
          icon: FontAwesomeIcons.paintBrush,
          text: "Switch Colors",
        ),
        DrawerTile(
          icon: FontAwesomeIcons.fileExcel,
          text: "Excel Export",
        ),
        DrawerTile(
          icon: FontAwesomeIcons.sun,
          text: "Dark Theme",
        ),
        DrawerTile(
          icon: FontAwesomeIcons.searchengin,
          text: "Search",
        ),
        Div(),
        DrawerTile(
          icon: Icons.restore,
          text: "Backup/ Restore",
        ),
        DrawerTile(
          icon: Icons.update,
          text: "Check Update",
        ),
        DrawerTile(
          icon: Icons.star,
          text: "Grade",
        ),
        DrawerTile(
          icon: Icons.share,
          text: "Share",
        ),
        DrawerTile(
          icon: Icons.settings,
          text: "Settings",
        ),
      ],
    );
  }
}

class DrawerTile extends StatelessWidget {
  final IconData icon;
  final String text;
  const DrawerTile({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 10,
      dense: true,
      leading: Icon(
        icon,
        size: 20,
      ),
      title: CustomText(
        text: text,
        size: 16,
      ),
    );
  }
}
