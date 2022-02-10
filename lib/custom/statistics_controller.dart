import 'package:get/get.dart';

class StatsController extends GetxController {
  RxBool expense = (true).obs;
  RxBool income = (false).obs;

  selected() {
    expense.value = !expense.value;
    income.value = !income.value;
  }
}
