import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget/main.dart';
import 'package:budget/screens/sub_screens/popUp_screen.dart';

class EditIOScreen extends StatelessWidget {
  final String data;
  const EditIOScreen({Key? key, required this.data}) : super(key: key);

  @override
  void initState(context) {
    print("XD");
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return PopUpScreen();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Details"),
        actions: [
          Icon(
            FontAwesomeIcons.solidTrashAlt,
            size: 20,
          ),
          SizedBox(
            width: 20,
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Card(
              child: Column(
                children: [
                  ListTile(
                    horizontalTitleGap: 20,
                    leading: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return PopUpScreen();
                            },
                          );
                        },
                        child: Icon(
                          FontAwesomeIcons.youtube,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                    title: CustomText(
                      text: "Travel",
                      size: 18,
                    ),
                    trailing: CustomText(
                      text: "-60,000",
                      size: 16,
                      weight: FontWeight.bold,
                    ),
                  ),
                  Div(),
                  optionTile(
                    leading: Icons.dashboard,
                    text: "Category",
                    trailing: "Expenses",
                  ),
                  Div(),
                  optionTile(
                    leading: Icons.calendar_today,
                    text: "Date",
                    trailing: "01/31/2022, 13:42",
                  ),
                  Div(),
                  optionTile(
                    leading: Icons.note_alt_outlined,
                    text: "Remark",
                    trailing: "swiggy paneer",
                  ),
                ],
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: SizedBox(
              width: 50,
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.pen,
                    size: 12,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    text: "EDIT",
                    size: 15,
                    color: Colors.white,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class optionTile extends StatelessWidget {
  final IconData leading;
  final String text;
  final double size;
  final String trailing;
  const optionTile({
    Key? key,
    required this.leading,
    required this.text,
    required this.trailing,
    this.size = 14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 0,
      dense: true,
      leading: Icon(
        leading,
        size: 20,
      ),
      title: CustomText(
        text: text,
        size: 16,
      ),
      trailing: CustomText(text: trailing, size: size),
    );
  }
}
