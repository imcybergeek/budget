import 'package:budget/custom/new_IO_controller.dart';
import 'package:budget/screens/io.dart';
import 'package:budget/screens/sub_screens/popUp_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'custom/budget_controller.dart';
import 'route_generator.dart';
import 'screens/sub_screens/app_drawer.dart';
import 'package:firebase_core/firebase_core.dart';

double monthlyExpense = 0.0;
double monthlyIncome = 0.0;
double monthlyTotal = 0.0;
double dailyExpense = 0.0;
double dailyIncome = 0.0;
var uniqueDates = <String>{};

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
    final NewIOController controller = Get.put(NewIOController());
    return GetBuilder<BudgetController>(
      init: BudgetController(),
      initState: (_) {},
      builder: (budgetController) {
        budgetController.getData();

        var i = 0;
        while (i < budgetController.budget.length) {
          uniqueDates.add(budgetController.budget[i].date);
          i++;
        }

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
                  SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MonthlyInfo(),
                        BudgetInfo(),
                        Visibility(
                          visible: budgetController.isLoading,
                          child: SizedBox(
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50)),
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: !budgetController.isLoading,
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: uniqueDates.length,
                            itemBuilder: (context, index) {
                              dailyExpense = 0;
                              dailyIncome = 0;
                              var i = 0;
                              while (i < budgetController.budget.length) {
                                if (uniqueDates.elementAt(index) ==
                                    budgetController.budget[i].date) {
                                  budgetController.budget[i].type
                                      ? dailyExpense = dailyExpense +
                                          double.parse(budgetController
                                              .budget[i].computed)
                                      : dailyIncome = dailyIncome +
                                          double.parse(budgetController
                                              .budget[i].computed);
                                }
                                i++;
                              }
                              if (dailyExpense == 0.0 && dailyIncome == 0.0) {
                                return SizedBox();
                              }
                              return DailyIO(
                                uniqueDates.elementAt(index),
                                budgetController.monthlyExpense.value,
                                budgetController.monthlyExpense.value,
                              );
                            },
                          ),
                        ),
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
                          controller.clear();
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
  BudgetController budgetController = Get.find();
  MonthlyInfo({
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
                text: "2022-02",
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
                text: budgetController.monthlyTotal.value
                    .toString()
                    .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]},'),
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
                text: "-" +
                    budgetController.monthlyExpense.value
                        .toString()
                        .replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},'),
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
                text: "+" +
                    budgetController.monthlyIncome.value
                        .toString()
                        .replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},'),
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
  final BudgetController budgetController = Get.find();
  BudgetInfo({
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
                      text: budgetController.monthlyBudget.value
                          .toString()
                          .replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},'),
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
                    percent: budgetController.budgetPercentage.value,
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
                      text: budgetController.remainingBudget.value
                          .toString()
                          .replaceAllMapped(
                              RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                              (Match m) => '${m[1]},'),
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
  final BudgetController budgetController = Get.find();
  YearlyInfo({
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
                            color: Colors.white, text: "2022-02", size: 15),
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
                              text: "-" +
                                  budgetController.monthlyExpense.value
                                      .toString()
                                      .replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'),
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
                              text: "+" +
                                  budgetController.monthlyIncome.value
                                      .toString()
                                      .replaceAllMapped(
                                          RegExp(
                                              r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                          (Match m) => '${m[1]},'),
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
  final String uniqueDates;
  final double expenses;
  final double incomes;

  DailyIO(
    this.uniqueDates,
    this.expenses,
    this.incomes, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BudgetController budgetController = Get.find();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Container(
            color: Colors.grey[100],
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: uniqueDates,
                    size: 10,
                  ),
                  Spacer(),
                  CustomText(
                    text: "Expense:-" +
                        dailyExpense.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},') +
                        "  ",
                    size: 10,
                  ),
                  CustomText(
                    text: "Income:+" +
                        dailyIncome.toString().replaceAllMapped(
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                            (Match m) => '${m[1]},'),
                    size: 10,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: budgetController.budget.length,
          itemBuilder: (context, index) {
            if (uniqueDates != budgetController.budget[index].date) {
              return SizedBox();
            }
            int key = budgetController.budget[index].key;
            List type = budgetController.budget[index].type ? expense : income;
            budgetController.budget[index].type
                ? monthlyExpense = monthlyExpense +
                    double.parse(budgetController.budget[index].computed)
                : monthlyIncome = monthlyIncome +
                    double.parse(budgetController.budget[index].computed);

            if (index == budgetController.budget.length - 1) {
              budgetController.monthlyExpense.value = monthlyExpense;
              budgetController.monthlyIncome.value = monthlyIncome;
              budgetController.monthlyTotal.value =
                  monthlyIncome - monthlyExpense;

              budgetController.remainingBudget.value =
                  budgetController.monthlyExpense.value >
                          budgetController.monthlyBudget.value
                      ? 0.0
                      : budgetController.monthlyBudget.value -
                          budgetController.monthlyExpense.value;

              budgetController.budgetPercentage.value = 1 -
                  budgetController.remainingBudget.value /
                      budgetController.monthlyBudget.value;
              monthlyIncome = 0.0;
              monthlyExpense = 0.0;
            }

            return IO(
              () {
                budgetController.id.value = budgetController.budget[index].id;
                budgetController.type.value =
                    budgetController.budget[index].type;
                budgetController.date.value =
                    budgetController.budget[index].date;
                budgetController.time.value =
                    budgetController.budget[index].time;

                budgetController.list.value = type;
                budgetController.key.value = key;
                budgetController.computed.value =
                    budgetController.budget[index].computed;

                budgetController.category.value =
                    budgetController.budget[index].type ? "Expenses" : "Income";
                budgetController.dateTime.value =
                    "${budgetController.budget[index].date}, ${budgetController.budget[index].time}";
                budgetController.remark.value =
                    budgetController.budget[index].text;
              },
              type[key - 1].icon,
              type[key - 1].color,
              type[key - 1].text,
              budgetController.budget[index].text,
              budgetController.budget[index].computed,
              type: budgetController.budget[index].type,
            );
          },
        ),
      ],
    );
  }
}

class IO extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String ioName;
  final String ioDesc;
  final String ioAmt;
  final VoidCallback func;
  bool type;

  IO(
    this.func,
    this.icon,
    this.color,
    this.ioName,
    this.ioDesc,
    this.ioAmt, {
    Key? key,
    this.type = false,
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
            func();
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
            text: type ? "-$ioAmt" : "+$ioAmt",
            size: 15,
            weight: FontWeight.bold,
            color: type ? null : Colors.blue,
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
