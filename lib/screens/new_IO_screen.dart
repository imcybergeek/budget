import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget/main.dart';
import 'package:budget/screens/popUp_screen.dart';

class NewIOScreen extends StatelessWidget {
  final String data;
  const NewIOScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(25),
          child: Stack(
            children: [
              Container(
                height: 65,
                color: Theme.of(context).colorScheme.primary,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return popUpScreen();
                                  },
                                );
                              },
                              child: Icon(
                                FontAwesomeIcons.youtube,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          Spacer(),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: "0",
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: 30,
                                    color: Colors.white,
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 5),
                                child: CustomText(
                                  text: "0=",
                                  size: 15,
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Card(
              child: Column(
                children: [
                  optionTile(
                    leading: Icons.calendar_today,
                    text: "Date  Today",
                    trailing: Icons.arrow_forward_ios,
                  ),
                  Div(),
                  optionTile(
                    leading: Icons.access_time_filled,
                    text: "Time  18:33",
                    trailing: Icons.arrow_forward_ios,
                  ),
                  Div(),
                  Stack(
                    children: [
                      ListTile(
                        dense: true,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Icon(
                          FontAwesomeIcons.pen,
                          size: 16,
                        ),
                        title: CustomText(
                          text: "Remark",
                          size: 16,
                        ),
                      ),
                      ListTile(
                        dense: true,
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 125),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: new InputDecoration.collapsed(
                                hintText: 'Write a note'),
                          ),
                        ),
                      ),
                    ],
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
  final IconData trailing;
  const optionTile({
    Key? key,
    required this.leading,
    required this.text,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity(horizontal: -2, vertical: -2),
      leading: Icon(
        leading,
        size: 18,
      ),
      title: CustomText(
        text: text,
        size: 16,
      ),
      trailing: Icon(
        trailing,
        size: 15,
      ),
    );
  }
}
