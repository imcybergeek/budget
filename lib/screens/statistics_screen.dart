import 'package:budget/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:budget/custom/statistics_controller.dart';

class StatisticsScreen extends StatelessWidget {
  final String data;
  const StatisticsScreen({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final StatsController controller = Get.put(StatsController());
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
                  text: "CATEGORY",
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Tab(
                  text: "STATISTICS",
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  width: 250,
                  child: MaterialButton(
                    color: Colors.blueAccent,
                    height: 35,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)),
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 18,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        CustomText(
                          text: "Feb 1, 2022 - Feb 28, 2022",
                          size: 15,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    SelectType(
                      controller: controller,
                      text: "Expenses",
                    ),
                    SelectType(
                      controller: controller,
                      text: "Income",
                    ),
                  ],
                )
              ],
            ),
            Text(data),
          ],
        ),
      ),
    );
  }
}

class SelectType extends StatelessWidget {
  final String text;
  const SelectType({
    Key? key,
    required this.text,
    required this.controller,
  }) : super(key: key);

  final StatsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      margin: EdgeInsets.only(left: 10),
      child: Obx(
        () => MaterialButton(
          color: text == "Expenses" && controller.expense.value ||
                  text == "Income" && controller.income.value
              ? Colors.blue
              : Colors.grey[300],
          shape: RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30)),
          onPressed: () {
            controller.selected();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: text == "Expenses"
                    ? controller.expense.value
                    : controller.income.value,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              CustomText(
                text: text,
                size: 15,
                color: text == "Expenses" && controller.expense.value ||
                        text == "Income" && controller.income.value
                    ? Colors.white
                    : Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
