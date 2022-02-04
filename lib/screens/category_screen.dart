import 'package:budget/screens/io.dart';
import 'package:flutter/material.dart';
import 'package:budget/main.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'io.dart';

class CategoryScreen extends StatefulWidget {
  final String data;
  const CategoryScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
            ReorderableListView(
              onReorder: (oldIndex, newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final key = expense.removeAt(oldIndex);
                expense.insert(index, key);
              }),
              padding: EdgeInsets.all(5),
              children: [
                for (final IO in expense)
                  PopUpTile(
                    key: ValueKey(IO.key),
                    icon: IO.icon!,
                    color: IO.color!,
                    text: IO.text!,
                  ),
              ],
            ),
            ReorderableListView(
              onReorder: (oldIndex, newIndex) => setState(() {
                final index = newIndex > oldIndex ? newIndex - 1 : newIndex;
                final key = income.removeAt(oldIndex);
                income.insert(index, key);
              }),
              padding: EdgeInsets.all(5),
              children: [
                for (final IO in income)
                  PopUpTile(
                    key: ValueKey(IO.key),
                    icon: IO.icon!,
                    color: IO.color!,
                    text: IO.text!,
                  ),
              ],
            ),
          ],
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
          trailing: Icon(Icons.drag_handle_rounded),
        ),
        Div(),
      ],
    );
  }
}
