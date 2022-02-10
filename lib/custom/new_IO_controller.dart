import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

String no = "";
List exprList = ["/", "*", "-", "+", "."];

class NewIOController extends GetxController {
  RxString number = ("0=").obs;
  RxBool changed = (false).obs;
  RxString computed = ("0").obs;

  numeric(String num) {
    if (no.length == 10) {
      return null;
    }
    number.value = no = no + num;
    changed.value = true;
  }

  expression(String expr) {
    if (no == "" || no.length == 9) {
      return null;
    }
    String lastNo = no.substring(no.length - 1, no.length);
    for (final i in exprList) {
      if (lastNo == i) {
        return null;
      }
    }
    number.value = no = no + expr;
    changed.value = true;
  }

  removeLast() {
    if (no != "" && no.isNotEmpty) {
      number.value = no = no.substring(0, no.length - 1);
    } else {
      changed.value = false;
    }
  }

  compute() {
    Parser p = Parser();
    Expression exp = p.parse(no);
    ContextModel cm = ContextModel();

    var eval = double.parse(exp.evaluate(EvaluationType.REAL, cm).toString())
        .toStringAsFixed(2);

    if (eval.substring(eval.length - 1, eval.length) == "0") {
      eval = eval.substring(0, eval.length - 1);
      if (eval.substring(eval.length - 1, eval.length) == "0") {
        eval = eval.substring(0, eval.length - 2);
      }
    }
    computed.value = eval;
    number.value = no = "";
    changed.value = false;
  }
}
