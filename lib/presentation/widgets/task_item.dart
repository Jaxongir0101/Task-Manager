import 'package:flutter/material.dart';
import 'package:taskmanager/main_provider.dart';
import 'package:taskmanager/models/task.dart';
import 'package:taskmanager/presentation/screens/thirdpage.dart';
import 'package:provider/provider.dart';


class TaskItem extends StatelessWidget {
  final Task task;
  const TaskItem(this.task, {Key? key}) : super(key: key);

  void taskItemList(context){
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    mainProvider.updateTaskList();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(18)),
          child: ListTile(
            title: Text(
              task.title ?? "...",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(task.startTime ?? "..."),
            trailing: PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'),
                  )
                ];
              },
              onSelected: (String value) {
                if (value == "edit") {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ThirdPage(
                        currentTask: task,
                      ),
                    ),
                  ).then((value) =>taskItemList(context));
                }
              },
            ),
            leading: Container(
              height: 61.0,
              width: 61.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF9C2CF3),
                      Color(0xFF3A49F9),
                    ],
                  )),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Image.asset(
                  'assets/images/list_icon.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
