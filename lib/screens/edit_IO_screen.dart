import 'package:budget/custom/budget_controller.dart';
import 'package:budget/screens/new_IO_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget/main.dart';
import 'package:budget/screens/sub_screens/popUp_screen.dart';
import 'package:get/get.dart';

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
    final BudgetController budgetController = Get.find();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Text("Edit Details"),
          actions: [
            IconButton(
              onPressed: () => {
                FirebaseFirestore.instance
                    .collection('transactions')
                    .doc(budgetController.id.value)
                    .delete(),
                Navigator.pop(context)
              },
              icon: Icon(
                FontAwesomeIcons.solidTrashAlt,
                size: 20,
              ),
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
                          color: budgetController
                              .list[budgetController.key.value - 1].color,
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
                            budgetController
                                .list[budgetController.key.value - 1].icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                      title: CustomText(
                        text: budgetController
                            .list[budgetController.key.value - 1].text,
                        size: 18,
                      ),
                      trailing: CustomText(
                        text: budgetController.category.value == "Expenses"
                            ? "-${budgetController.computed.value}"
                            : "+${budgetController.computed.value}",
                        size: 16,
                        weight: FontWeight.bold,
                        color: budgetController.category.value == "Expenses"
                            ? null
                            : Colors.blue,
                      ),
                    ),
                    Div(),
                    optionTile(
                      leading: Icons.dashboard,
                      text: "Category",
                      trailing: budgetController.category.value,
                    ),
                    Div(),
                    optionTile(
                      leading: Icons.calendar_today,
                      text: "Date",
                      trailing: budgetController.dateTime.value,
                    ),
                    Div(),
                    optionTile(
                      leading: Icons.note_alt_outlined,
                      text: "Remark",
                      trailing: budgetController.remark.value,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                budgetController.edit();
                Get.to(NewIOScreen());
              },
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
