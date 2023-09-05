import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/constants.dart';
import 'package:todoapp/controllers/task_controller.dart';
import 'package:todoapp/controllers/textfield_controller.dart';
import 'package:todoapp/models/task_model.dart';

import '../main.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    MyApp.changeColor(const Color(0xFFF5F5F5), Brightness.dark);
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          MyCustomAppBar(),
          TitleWidget(),
          TaskTextField(),
          NoteWidget(),
          MyButton()
        ],
      )),
    );
  }
}

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: Get.width,
      height: 40,
      child: ElevatedButton(
        style: TextButton.styleFrom(
            elevation: 0, backgroundColor: kLightBlueColor),
        onPressed: () {
          if (Get.find<TaskController>().isEditing) {
            var task = Get.find<TaskController>()
                .tasks[Get.find<TaskController>().index];
            task.taskTitle = Get.find<TextFieldController>().taskTitle!.text;
            task.taskSubtitle =
                Get.find<TextFieldController>().taskSubTitle!.text;

            Get.find<TaskController>().tasks[Get.find<TaskController>().index] =
                task;
          } else {
            Get.find<TaskController>().tasks.add(TaskModel(
                taskTitle: Get.find<TextFieldController>().taskTitle!.text,
                taskSubtitle:
                    Get.find<TextFieldController>().taskSubTitle!.text,
                status: true));
          }
          Get.back();
        },
        child: Text(Get.find<TaskController>().isEditing ? 'Edit' : 'Add'),
      ),
    );
  }
}

class NoteWidget extends StatelessWidget {
  const NoteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: Get.find<TextFieldController>().taskSubTitle,
      maxLength: 30,
      cursorColor: kLightBlueColor,
      decoration: InputDecoration(
          border: InputBorder.none,
          counter: Container(),
          hintText: 'Add Note',
          prefixIcon: const Icon(
            Icons.bookmark_border,
            color: Colors.grey,
          )),
    );
  }
}

class TaskTextField extends StatelessWidget {
  const TaskTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: Get.find<TextFieldController>().taskTitle,
        maxLines: 6,
        cursorColor: kLightBlueColor,
        cursorHeight: 40,
        decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300))),
      ),
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, top: 10),
      child: Text('What Are U Planning',
          style: TextStyle(color: Colors.grey[600], fontSize: 16)),
    );
  }
}

class MyCustomAppBar extends StatelessWidget {
  const MyCustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 45),
            child: Text(
              Get.find<TaskController>().isEditing ? 'EditTask' : 'New Task',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
          ),
        ),
        Hero(
          tag: 'hero',
          child: Material(
            child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.close)),
          ),
        )
      ],
    );
  }
}
