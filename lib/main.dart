import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:line_icons/line_icons.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'route_generator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle myOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.blue);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: myOverlayStyle,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Budget App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Rubik',
        ),
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int offset = 250;
  double opacity = 0;
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  void _scrollListener() {
    setState(() {
      if (_controller.offset < 25) {
        opacity = 0;
      } else if (_controller.offset > 250) {
        opacity = 1;
      } else {
        opacity = 1 - (offset - _controller.offset) / offset;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Theme.of(context).colorScheme.primary,
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              color: Colors.white,
                              size: 12,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            CustomText(
                              text: "2022-01",
                              size: 12,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            CustomText(
                              text: "Balance",
                              size: 12,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CustomText(
                              text: "+19,330",
                              color: Colors.white,
                              size: 35,
                              weight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: "Expense:",
                              color: Colors.white,
                              size: 12,
                            ),
                            CustomText(
                              text: "-670",
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            CustomText(
                              text: "Income:",
                              color: Colors.white,
                              size: 12,
                            ),
                            CustomText(
                              text: "+20,000",
                              color: Colors.white,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                    child: Stack(
                      children: [
                        Container(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.grey, blurRadius: 4)
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 15, 10, 20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1),
                                    child: CustomText(
                                      text: "Budget:",
                                      size: 10,
                                      weight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomText(
                                    text: "5,000",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                LinearPercentIndicator(
                                  width: MediaQuery.of(context).size.width,
                                  lineHeight: 8,
                                  percent: 0.25,
                                  backgroundColor: Colors.grey[100],
                                  progressColor: Colors.blue,
                                  barRadius: Radius.circular(10),
                                )
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 1),
                                    child: CustomText(
                                      text: "Remaining Budget:",
                                      size: 12,
                                    ),
                                  ),
                                  CustomText(
                                    text: "4,330",
                                    size: 18,
                                    weight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  DailyIO(
                    "Jan 28, 2022",
                    "-160",
                    "+10,000",
                  ),
                  IO(
                    LineIcons.wallet,
                    Colors.red,
                    "Salary",
                    "salary",
                    "+10,000",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "swiggy paneer",
                    "-160",
                  ),
                  DailyIO(
                    "Jan 24, 2022",
                    "-510",
                    "+10,000",
                  ),
                  IO(
                    LineIcons.youtube,
                    Colors.green,
                    "XD",
                    "XD",
                    "-10",
                  ),
                  IO(
                    LineIcons.wallet,
                    Colors.red,
                    "Salary",
                    "",
                    "+10,000",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                  IO(
                    LineIcons.utensils,
                    Colors.orange,
                    "Food",
                    "zomato",
                    "-500",
                  ),
                ],
              ),
            ),
            Opacity(
              opacity: opacity,
              child: SizedBox(
                height: 45,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                    color: Colors.white,
                                    text: "2022-01",
                                    size: 15)
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    CustomText(
                                      color: Colors.white,
                                      text: "Expense:",
                                      size: 14,
                                      weight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      color: Colors.white,
                                      text: "-7,376",
                                      size: 16,
                                      weight: FontWeight.bold,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    CustomText(
                                      color: Colors.white,
                                      text: "Income:",
                                      size: 14,
                                      weight: FontWeight.w600,
                                    ),
                                    CustomText(
                                      color: Colors.white,
                                      text: "+20,000",
                                      size: 16,
                                      weight: FontWeight.bold,
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
            ),
          ],
        ),
        bottomNavigationBar: opacity < 1
            ? BottomAppBar(
                shape: CircularNotchedRectangle(),
                child: Row(
                  children: [
                    CustomIcon(
                      icon: Icons.menu_rounded,
                    ),
                    CustomIcon(
                      icon: Icons.apps_rounded,
                    ),
                    CustomIcon(
                      icon: Icons.pie_chart_rounded,
                    ),
                    CustomIcon(
                      icon: Icons.folder_special,
                    ),
                  ],
                ),
              )
            : null,
        floatingActionButton: opacity < 1
            ? Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: FloatingActionButton(
                    child: Icon(
                      Icons.add_rounded,
                      size: 40,
                    ),
                    onPressed: () {
                      // Pushing a named route
                      Navigator.of(context).pushNamed(
                        '/second',
                        arguments: 'Hello there from the first page!',
                      );
                    }),
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      ),
    );
  }
}

class DailyIO extends StatelessWidget {
  final String date;
  final String expense;
  final String income;

  DailyIO(
    this.date,
    this.expense,
    this.income, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: .5, offset: Offset(0, .5)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(5),
          color: Colors.grey[100],
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              CustomText(text: date, color: Colors.grey[600], size: 10),
              Spacer(),
              CustomText(
                  text: "Expense:$expense", color: Colors.grey[600], size: 10),
              SizedBox(width: 5),
              CustomText(text: "Income:$income", color: Colors.blue, size: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class IO extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String ioName;
  final String ioDesc;
  final String ioAmt;

  IO(
    this.icon,
    this.color,
    this.ioName,
    this.ioDesc,
    this.ioAmt, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: .5, offset: Offset(0, .5)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Container(
          height: 50,
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(10)),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: ioName,
                    size: 15,
                  ),
                  ioDesc != ""
                      ? CustomText(
                          text: ioDesc,
                          color: Colors.grey[600],
                          size: 8,
                        )
                      : Container(),
                ],
              ),
              Spacer(),
              CustomText(
                text: ioAmt,
                color: Colors.blue,
                size: 15,
                weight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  final String text;
  final double size;
  FontWeight? weight;
  Color? color;
  CustomText(
      {Key? key,
      required this.text,
      required this.size,
      this.weight,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size,
        fontWeight: weight,
        color: color,
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  final IconData icon;
  CustomIcon({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.fromLTRB(10, 12, 10, 20),
        icon: Icon(
          icon,
          size: 30,
          color: Colors.grey[400],
        ),
        onPressed: () {});
  }
}
