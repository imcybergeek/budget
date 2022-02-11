import 'package:budget/screens/sub_screens/popUp_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'custom/budget_controller.dart';
import 'route_generator.dart';
import 'screens/sub_screens/app_drawer.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemUiOverlayStyle myOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: myOverlayStyle,
      child: GetMaterialApp(
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
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  void _create() async {
    try {
      await firestore.collection("users").doc("testUser").set({
        'firstName': 'test',
        'lastName': 'user',
      });
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    DocumentSnapshot documentSnapshot;
    try {
      documentSnapshot =
          await firestore.collection('users').doc('testUser').get();
      print(documentSnapshot.data());
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore
          .collection('users')
          .doc('testUser')
          .update({'firstName': 'testUpdated'});
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').doc('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

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
    return GetBuilder<TodoController>(
      init: TodoController(),
      initState: (_) {},
      builder: (todoController) {
        todoController.getData();
        return Container(
          color: Theme.of(context).colorScheme.primary,
          child: SafeArea(
            child: Scaffold(
              drawer: SizedBox(
                width: 250,
                child: Drawer(
                  child: AppDrawer(),
                ),
              ),
              backgroundColor: Colors.grey[200],
              body: Stack(
                children: [
                  todoController.isLoading
                      ? SizedBox(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: todoController.taskList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title:
                                  Text(todoController.taskList[index].ioName),
                            );
                          },
                        ),
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MonthlyInfo(),
                        BudgetInfo(),
                        ElevatedButton(
                            onPressed: () async => await todoController.addTodo(
                                "XD", "XD", "XD", "XD", "XD", "XD", "XD"),
                            child: Text("Create")),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _read();
                        //     },
                        //     child: Text("Read")),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _update();
                        //     },
                        //     child: Text("Update")),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       _delete();
                        //     },
                        //     child: Text("Delete")),
                        // DailyIO(
                        //   "Jan 28, 2022",
                        //   "-160",
                        //   "+10,000",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.wallet,
                        //   Colors.red,
                        //   "Salary",
                        //   "salary",
                        //   "+10,000",
                        //   income: true,
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "swiggy paneer",
                        //   "-160",
                        // ),
                        // DailyIO(
                        //   "Jan 24, 2022",
                        //   "-510",
                        //   "+10,000",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.youtube,
                        //   Colors.green,
                        //   "XD",
                        //   "XD",
                        //   "-10",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.wallet,
                        //   Colors.red,
                        //   "Salary",
                        //   "",
                        //   "+10,000",
                        //   income: true,
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        // IO(
                        //   FontAwesomeIcons.utensils,
                        //   Colors.orange,
                        //   "Food",
                        //   "zomato",
                        //   "-500",
                        // ),
                        SizedBox(height: 15),
                      ],
                    ),
                  ),
                  YearlyInfo(opacity: opacity),
                ],
              ),
              bottomNavigationBar: opacity < 1
                  ? BottomAppBar(
                      shape: CircularNotchedRectangle(),
                      child: Row(
                        children: [
                          Builder(
                            builder: (context) => CustomIcon(
                              icon: FontAwesomeIcons.bars,
                              size: 27,
                              func: () => Scaffold.of(context).openDrawer(),
                            ),
                          ),
                          CustomIcon(
                            icon: Icons.dashboard_customize,
                            func: () =>
                                // Pushing a named route
                                Navigator.of(context).pushNamed(
                              '/fourth',
                              arguments: 'Hello there from the first page!',
                            ),
                          ),
                          CustomIcon(
                            icon: Icons.pie_chart_rounded,
                            func: () =>
                                // Pushing a named route
                                Navigator.of(context).pushNamed(
                              '/fifth',
                              arguments: 'Hello there from the first page!',
                            ),
                          ),
                          // CustomIcon(
                          //   icon: Icons.folder_special,
                          //   // ),
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
                          Navigator.of(context).pushNamed('/second');
                          Future.delayed(const Duration(milliseconds: 500), () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return PopUpScreen();
                              },
                            );
                          });
                        },
                      ),
                    )
                  : null,
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.endDocked,
            ),
          ),
        );
      },
    );
  }
}

class MonthlyInfo extends StatelessWidget {
  const MonthlyInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class BudgetInfo extends StatelessWidget {
  const BudgetInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                BoxShadow(color: Colors.grey.shade400, blurRadius: 3)
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
    );
  }
}

class YearlyInfo extends StatelessWidget {
  const YearlyInfo({
    Key? key,
    required this.opacity,
  }) : super(key: key);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Opacity(
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
                padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                            color: Colors.white, text: "2022-01", size: 15),
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        color: Colors.grey[100],
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: "Jan 31, 2022",
                size: 10,
              ),
              Spacer(),
              CustomText(
                text: "Expense:-27,206  Income:+10,000",
                size: 10,
              ),
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
  bool income;

  IO(
    this.icon,
    this.color,
    this.ioName,
    this.ioDesc,
    this.ioAmt, {
    Key? key,
    this.income = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey, blurRadius: .5, offset: Offset(0, .5)),
          ],
        ),
        child: ListTile(
          onTap: () {
            // Pushing a named route
            Navigator.of(context).pushNamed(
              '/third',
              arguments: 'Hello there from the first page!',
            );
          },
          horizontalTitleGap: 0,
          minVerticalPadding: 6,
          visualDensity: VisualDensity(vertical: -4),
          contentPadding: EdgeInsets.only(left: 10, right: 10),
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
            text: ioName,
            size: 15,
          ),
          subtitle: CustomText(
            text: ioDesc,
            size: 8,
          ),
          trailing: CustomText(
            text: ioAmt,
            size: 15,
            weight: FontWeight.bold,
            color: income ? Colors.blue : null,
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
  VoidCallback? func;
  CustomText(
      {Key? key,
      required this.text,
      required this.size,
      this.weight,
      this.color,
      this.func})
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
  final VoidCallback func;
  double size;
  CustomIcon({
    Key? key,
    required this.icon,
    required this.func,
    this.size = 30,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        padding: EdgeInsets.fromLTRB(15, 12, 10, 20),
        icon: Icon(
          icon,
          size: size,
          color: Colors.grey[400],
        ),
        onPressed: () => func());
  }
}

class Div extends StatelessWidget {
  const Div({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Divider(
        thickness: 1,
        height: 0.5,
      ),
    );
  }
}
