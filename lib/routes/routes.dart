import 'package:get/get.dart';
import 'package:todoapp/pages/add_task_screen.dart';
import 'package:todoapp/pages/home_screen.dart';

class Routes {
  static List<GetPage> get pages => [
        GetPage(name: '/homescreen', page: () => const HomeScreen()),
        GetPage(name: '/addscreen', page: () => const AddTaskScreen())
      ];
}
