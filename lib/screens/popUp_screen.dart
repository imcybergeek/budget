import 'package:flutter/material.dart';

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
      ),
    );
  }
}
