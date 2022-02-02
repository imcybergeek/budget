import 'package:budget/main.dart';
import 'package:budget/screens/popUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class NewIOScreen extends StatelessWidget {
  final String data;
  const NewIOScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        children: [
          Stack(
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
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: Icon(
                                LineIcons.youtube,
                                color: Colors.white,
                              ),
                              iconSize: 30,
                              onPressed: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return popUpScreen();
                                  },
                                );
                              },
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
                  Divider(
                    height: 0.5,
                  ),
                  optionTile(
                    leading: Icons.access_time_filled,
                    text: "Time  18:33",
                    trailing: Icons.arrow_forward_ios,
                  ),
                  Divider(
                    height: 0.5,
                  ),
                  Stack(
                    children: [
                      ListTile(
                        visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                        leading: Icon(
                          LineIcons.pen,
                          size: 18,
                        ),
                        title: CustomText(
                          text: "Remark",
                          size: 16,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 150, top: 15, bottom: 15),
                        child: SizedBox(
                          width: 225,
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
      dense: true,
    );
  }
}