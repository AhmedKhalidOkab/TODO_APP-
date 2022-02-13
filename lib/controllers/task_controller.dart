import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/db/db_helper.dart';
import 'package:todo/models/task.dart';

class TaskController extends GetxController {
  final RxList<Task> taskList = <Task>[].obs;
  Future<int> addtask({Task? task}) {
    return DBHelper.insert(task);
  }

  //**TO get all tasks exist in Tasks page */
  Future<void> getTask() async {
    final List<Map<String, Object?>> tasks = await DBHelper.query();
    //todo: to get all data from the database
    taskList.assignAll(tasks.map((data) => Task.fromjson(data)));
  }

  //todo: to DELETE THE TASKS
  void deleteTask(Task task) async {
    await DBHelper.delete(task);
  }

  void markTaskCompleted(int id) async {
    await DBHelper.update(id);
  }
}
