import 'package:budget/screens/budget_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var isLoading = false;
  var taskList = <BudgetModel>[];

  Future<void> addTodo(String id, String income, String key, String ioName,
      String ioDesc, String ioAmt, String date) async {
    await FirebaseFirestore.instance.collection('todos').doc().set(
      {
        'id': id,
        'income': income,
        'key': key,
        'ioName': ioName,
        'ioDesc': ioDesc,
        'ioAmt': ioAmt,
        'date': date,
      },
      SetOptions(merge: true),
    ).then(
      (value) => Get.back(),
    );
  }

  Future<void> getData() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todos')
          .orderBy('task')
          .get();

      taskList.clear();
      for (var item in _taskSnap.docs) {
        taskList.add(
          BudgetModel(
            item['id'],
            item['income'],
            item['key'],
            item['ioName'],
            item['ioDesc'],
            item['ioAmt'],
            item['date'],
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
