import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_5/controller/add_controller.dart';
import 'package:task_5/controller/controller.dart';

import 'student_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => DataController(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddController(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.blueGrey, primaryColor: Colors.purple),
        debugShowCheckedModeBanner: false,
        home: StudentList(),
      ),
    );
  }
}
