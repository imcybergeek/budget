import 'package:budget/screens/category_screen.dart';
import 'package:budget/screens/new_IO_screen.dart';
import 'package:budget/screens/edit_IO_screen.dart';
import 'package:budget/screens/statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:budget/main.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => MyHomePage());
      case '/second':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => NewIOScreen(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case '/third':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => EditIOScreen(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();

      case '/fourth':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => CategoryScreen(
              data: args,
            ),
          );
        }
        return _errorRoute();

      case '/fifth':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => StatisticsScreen(
              data: args,
            ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
