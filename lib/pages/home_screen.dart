import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/controllers/textfield_controller.dart';
import 'package:todoapp/main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(kLightBlueColor, Brightness.light);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'hero',
        onPressed: () {
          Get.find<TaskController>().isEditing = false;
          Get.find<TextFieldController>().taskTitle!.text = '';
          Get.find<TextFieldController>().taskSubTitle!.text = '';
          Get.toNamed('/addscreen')!.then((value) {
            MyApp.changeColor(kLightBlueColor, Brightness.light);
          });
        },
        backgroundColor: kLightBlueColor,
        elevation: 0,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: const [TopSectionWidget(), BottomSectionWidget()],
        ),
      ),
    );
  }
}

//* Top Section Widget
class TopSectionWidget extends StatelessWidget {
  const TopSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kLightBlueColor,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          width: Get.width,
          color: kLightBlueColor,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 40, top: 20),
          child: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.white,
            child: Center(
                child: Icon(
              Icons.bookmarks,
              color: kLightBlueColor,
            )),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 50, top: 20),
          child: const Text(
            'All',
            style: TextStyle(
                color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 50, top: 5),
          child: Obx(() => Text(
                '${Get.find<TaskController>().tasks.length} Tasks',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              )),
        )
      ]),
    );
  }
}

// * BottomSection
class BottomSectionWidget extends StatelessWidget {
  const BottomSectionWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.6,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25))),
      child: Container(
        margin: const EdgeInsets.only(left: 50, top: 20, right: 10),
        child: Obx(() => ListView.separated(
            itemBuilder: (contex, index) {
              var task = Get.find<TaskController>().tasks[index];
              return ListTile(
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text(
                              'Are U Sure to wana Delete this item ?  ',
                              style: TextStyle(fontSize: 13),
                            ),
                            actionsAlignment: MainAxisAlignment.spaceBetween,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'No',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                              TextButton(
                                  onPressed: () {
                                    Get.find<TaskController>()
                                        .tasks
                                        .removeAt(index);
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Yes',
                                    style: TextStyle(color: Colors.black87),
                                  )),
                            ],
                          ));
                },
                title: Text(task.taskTitle ?? ''.toString()),
                subtitle: Text(task.taskSubtitle ?? ''.toString()),
                onTap: () {
                  Get.find<TaskController>().isEditing = true;
                  Get.find<TaskController>().index = index;

                  Get.find<TextFieldController>().taskTitle!.text =
                      task.taskTitle!;
                  Get.find<TextFieldController>().taskSubTitle!.text =
                      task.taskSubtitle!;
                  Get.toNamed('addscreen');
                },
                trailing: Checkbox(
                  side: const BorderSide(color: Colors.black45, width: 1.5),
                  activeColor: kLightBlueColor,
                  onChanged: (value) {
                    task.status = !task.status!;
                    Get.find<TaskController>().tasks[index] = task;
                  },
                  value: task.status,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: Colors.black, height: 1);
            },
            itemCount: Get.find<TaskController>().tasks.length)),
      ),
    );
  }
}
