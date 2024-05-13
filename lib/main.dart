

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:internship_task1/loginPage.dart';
import 'package:internship_task1/taskSelectionPage.dart';
import 'package:internship_task1/task_5.dart';
import 'package:internship_task1/task_6.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:internship_task1/task_4.dart';
import 'myHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
        '/login': (context) => Login(),
        '/taskSelection':(context)=>TaskSelectionPage(),
        '/task4': (context) => Task_4(),
        '/task5': (context) => Task_5(),
        '/task6': (context) => task_6(),

      },
     // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

