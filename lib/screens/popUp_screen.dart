import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'first_page.dart';
import 'second_page.dart';

class popUpScreen extends StatelessWidget {
  const popUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: SizedBox(
            width: 210,
            child: TabBar(
              isScrollable: true,
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey[600],
              tabs: [
                Tab(
                  text: "EXPENSES",
                ),
                Tab(
                  text: "INCOME",
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        body: TabBarView(
          children: [FirstPage(), SecondPage()],
        ),
      ),
    );
  }
}

class PopUpTile extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  const PopUpTile({
    Key? key,
    required this.icon,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 10,
          dense: true,
          leading: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(50)),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          title: CustomText(
            text: text,
            size: 16,
          ),
        ),
        Div(),
      ],
    );
  }
}
