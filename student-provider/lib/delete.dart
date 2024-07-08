import 'package:flutter/material.dart';
import 'package:task_5/controller/controller.dart';
import 'package:task_5/db_helper.dart';
import 'package:task_5/student_list.dart';

IconButton deleteButton(
    DataController controller, int index, BuildContext context) {
  return IconButton(
    onPressed: () {
      deleteData1(controller.filteredStudentList[index].id!,
          controller.filteredStudentList[index].name, context);
    },
    icon: Icon(
      Icons.delete,
      color: Colors.red[400],
    ),
  );
}

Future<void> deleteData1(int id, String name, context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          title: Text(
            "Delete $name ?",
            style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("NO")),
            TextButton(
                onPressed: () async {
                  await SQLHelper.deleteData(id, context);
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: Text("DATA DELTED"),
                      duration: Duration(milliseconds: 800)));
                  //  .refreshData();
                },
                child: Text(
                  "YES",
                  style: TextStyle(color: Colors.red),
                ))
          ],
        );
      });
}
