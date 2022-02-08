import 'package:budget/custom/animated_button.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  final String data;
  const StatisticsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text("Chart"),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            tabs: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Tab(
                  text: "EXPENSES",
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Tab(
                  text: "INCOME",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              children: [AnimatedButton(onPressed: () {}, child: Text(""))],
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}
