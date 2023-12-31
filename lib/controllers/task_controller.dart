import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:todoapp/models/task_model.dart';

class TaskController extends GetxController {
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  bool isEditing = false;
  int index = 0;
  @override
  void onInit() {
    var box = GetStorage();
    if (box.read('tasks') != null) {
      var list = box.read('tasks');
      for (var json in list) {
        tasks.add(TaskModel.fromJson(json));
      }
    }
    ever(tasks, (value) {
      box.write('tasks', tasks.toJson());
    });
    super.onInit();
  }
}
