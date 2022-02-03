import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final String data;
  const CategoryScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: Text("Category Settings"),
          bottom: TabBar(
            isScrollable: true,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
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
        body: TabBarView(
          children: [Text(data), Text(data)],
        ),
      ),
    );
  }
}
