import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:math_expressions/math_expressions.dart';

String no = "";
List exprList = ["/", "*", "-", "+", "."];

class NewIOController extends GetxController {
  RxString number = ("0=").obs;
  bool checkZero = true;
  RxBool changed = (false).obs;
  RxBool type = (true).obs;
  RxInt key = (1).obs;
  RxString computed = ("0").obs;
  RxString date = ("Today").obs;
  RxString text = ("").obs;
  RxString time =
      ("${TimeOfDay.now().hour}:${TimeOfDay.now().minute < 10 ? "0" + "${TimeOfDay.now().minute}" : TimeOfDay.now().minute} ${TimeOfDay.now().hour < 12 ? "AM" : "PM"}")
          .obs;

  numeric(String num) {
    if (no.length == 15) {
      return null;
    }
    if (checkZero && num == "0") {
      return null;
    } else {
      checkZero = false;
    }
    number.value = no = no + num;
    compute();
    if (double.parse(computed.value) / 1 != 0) {
      changed.value = true;
    } else {
      changed.value = false;
    }
  }

  expression(String expr) {
    checkZero = true;
    if (no == "" || no.length == 14) {
      return null;
    }
    String lastNo = no.substring(no.length - 1, no.length);
    for (final i in exprList) {
      if (lastNo == i) {
        removeLast();
      }
    }
    number.value = no = no + expr;
    changed.value = true;
  }

  removeLast() {
    if (no != "" && no.isNotEmpty) {
      number.value = no = no.substring(0, no.length - 1);
      if (no.isNotEmpty) {
        String lastNo = no.substring(no.length - 1, no.length);
        for (final i in exprList) {
          if (lastNo == i || lastNo == "0") {
            checkZero = true;
            return null;
          }
        }
      } else {
        checkZero = true;
        number.value = no = "";
        computed.value = "";
        changed.value = false;
        return null;
      }
      compute();
      if (double.parse(computed.value) / 1 != 0) {
        changed.value = true;
      } else {
        changed.value = false;
      }
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
  }
}
