import 'package:flutter/material.dart';
import 'package:budget/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 135,
          child: DrawerHeader(
            decoration: const BoxDecoration(
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
        const DrawerTile(
          icon: FontAwesomeIcons.ad,
          text: "Remove Ads",
        ),
        const DrawerTile(
          icon: FontAwesomeIcons.paintBrush,
          text: "Switch Colors",
        ),
        const DrawerTile(
          icon: FontAwesomeIcons.fileExcel,
          text: "Excel Export",
        ),
        const DrawerTile(
          icon: FontAwesomeIcons.sun,
          text: "Dark Theme",
        ),
        const DrawerTile(
          icon: FontAwesomeIcons.searchengin,
          text: "Search",
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Div(),
        ),
        const DrawerTile(
          icon: Icons.restore,
          text: "Backup/ Restore",
        ),
        const DrawerTile(
          icon: Icons.update,
          text: "Check Update",
        ),
        const DrawerTile(
          icon: Icons.star,
          text: "Grade",
        ),
        const DrawerTile(
          icon: Icons.share,
          text: "Share",
        ),
        const DrawerTile(
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
