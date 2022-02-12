import 'package:budget/custom/new_IO_controller.dart';
import 'package:budget/screens/io.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:budget/main.dart';
import 'package:budget/screens/sub_screens/popUp_screen.dart';
import 'package:budget/custom/sliding_panel.dart';
import 'package:budget/custom/animated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class NewIOScreen extends StatelessWidget {
  const NewIOScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewIOController controller = Get.put(NewIOController());
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
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
                                color: controller.type.value
                                    ? expense[controller.key.value - 1].color
                                    : income[controller.key.value - 1].color,
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
                                  controller.type.value
                                      ? expense[controller.key.value - 1].icon
                                      : income[controller.key.value - 1].icon,
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
                                      text: controller.computed.value,
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
                                    text: controller.number.value,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
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
        body: SlidingUpPanel(
          defaultPanelState: PanelState.OPEN,
          renderPanelSheet: false,
          boxShadow: [BoxShadow(blurRadius: 0, color: Colors.transparent)],
          maxHeight: 350,
          minHeight: 100,
          panel: Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  SizedBox(
                    height: 55,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        CalcBtn("7"),
                        CalcBtn("8"),
                        CalcBtn("9"),
                        CalcBtn(
                          "÷",
                          right: 5,
                          color: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        CalcBtn("4"),
                        CalcBtn("5"),
                        CalcBtn("6"),
                        CalcBtn(
                          "x",
                          right: 5,
                          color: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        CalcBtn("1"),
                        CalcBtn("2"),
                        CalcBtn("3"),
                        CalcBtn(
                          "-",
                          right: 5,
                          color: true,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        CalcBtn("."),
                        CalcBtn("0"),
                        CalcBtn(
                          "C",
                          color: true,
                        ),
                        CalcBtn(
                          "+",
                          right: 5,
                          color: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  child: Column(
                    children: [
                      optionTile(
                        func: (() {
                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.utc(DateTime.now().year,
                                      DateTime.now().month, 1),
                                  lastDate: DateTime.utc(DateTime.now().year,
                                      DateTime.now().month + 1, 0))
                              .then((value) => controller.date.value =
                                  "${value == null ? controller.date.value : DateFormat('MMM dd, yyyy').format(value)}");
                        }),
                        leading: Icons.calendar_today,
                        text: "Date  ${controller.date.value}",
                        trailing: Icons.arrow_forward_ios,
                      ),
                      Div(),
                      optionTile(
                        func: (() {
                          showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) => controller.time.value =
                                  "${value == null ? controller.time.value : value.format(context)}");
                        }),
                        leading: Icons.access_time_filled,
                        text: "Time  ${controller.time.value}",
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
                                onChanged: (value) =>
                                    controller.text.value = value,
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
        ),
      ),
    );
  }
}

class CalcBtn extends StatefulWidget {
  final String no;
  final double right;
  final bool color;

  const CalcBtn(
    this.no, {
    Key? key,
    this.right = 0,
    this.color = false,
  }) : super(key: key);

  @override
  State<CalcBtn> createState() => _CalcBtnState();
}

class _CalcBtnState extends State<CalcBtn> {
  @override
  Widget build(BuildContext context) {
    final NewIOController controller = Get.find();
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(left: 5, right: widget.right),
        child: SizedBox(
          height: 55,
          child: LayoutBuilder(
            builder: (BuildContext context, constraints) {
              return AnimatedButton(
                height: constraints.maxHeight,
                width: constraints.maxWidth,
                color: (widget.color ? Colors.blue : Colors.grey[200])!,
                onPressed: () {
                  if (widget.no == "C") {
                    controller.removeLast();
                  } else if (widget.no == "÷") {
                    controller.expression("/");
                  } else if (widget.no == "x") {
                    controller.expression("*");
                  } else if (widget.no == "-") {
                    controller.expression(widget.no);
                  } else if (widget.no == "+") {
                    controller.expression(widget.no);
                  } else if (widget.no == ".") {
                    controller.expression(widget.no);
                  } else {
                    controller.numeric(widget.no);
                  }
                },
                child: CustomText(
                  text: widget.no,
                  size: 25,
                  color: widget.color ? Colors.white : Colors.black,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class optionTile extends StatelessWidget {
  final IconData leading;
  final String text;
  final IconData trailing;
  final VoidCallback func;
  const optionTile({
    Key? key,
    required this.leading,
    required this.text,
    required this.trailing,
    required this.func,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => func(),
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

// onTap: () {
//         widget.onPressed();
//         Future.delayed(const Duration(milliseconds: 50), () {
//           setState(() {
//             _position = 3;
//           });
//         });
//       },

// child: Stack(
//                         clipBehavior: Clip.none,
//                         children: [
//                           child!,
//                           Padding(
//                             padding: const EdgeInsets.only(top: 50),
//                             child: SizedBox(
//                               height: 50,
//                               width: double.infinity,
//                               child: ElevatedButton(
//                                 style: ElevatedButton.styleFrom(
//                                     shadowColor: Colors.transparent,
//                                     primary: Colors.white),
//                                 onPressed: () {
//                                   _ac.value == 1
//                                       ? _ac.value = 0
//                                       : _ac.value = 1;
//                                 },
//                                 child: Icon(
//                                   Icons.horizontal_rule_rounded,
//                                   size: 50,
//                                   color: Theme.of(context).colorScheme.primary,
//                                 ),
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             top: 13,
//                             right: 16,
//                             child: FloatingActionButton(
//                               onPressed: () {
//                                 _ac.value == 1 ? _ac.value = 0 : _ac.value = 1;
//                               },
//                               child: IconButton(
//                                 icon: Icon(buttonIcon),
//                                 onPressed: () {
//                                   _ac.value == 1
//                                       ? _ac.value = 0
//                                       : _ac.value = 1;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),