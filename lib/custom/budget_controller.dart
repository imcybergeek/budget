import 'package:budget/screens/budget_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BudgetController extends GetxController {
  var isLoading = false;
  var budget = <BudgetModel>[];

  Future<void> addTransaction(bool type, int key, String date, String time,
      String text, String computed) async {
    await FirebaseFirestore.instance.collection('transactions').doc().set(
      {
        'type': type,
        'key': key,
        'date': date,
        'time': time,
        'text': text,
        'computed': computed,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('transactions')
          .orderBy('date')
          .get();

      budget.clear();
      for (var item in _taskSnap.docs) {
        budget.add(
          BudgetModel(
            item['type'],
            item['key'],
            item['date'],
            item['time'],
            item['text'],
            item['computed'],
          ),
        );
      }
      isLoading = false;
      update();
    } catch (e) {
      print(e.toString());
    }
  }
}
