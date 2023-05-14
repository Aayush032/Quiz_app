import 'package:flutter/material.dart';
import 'package:quiz_app/db_connect.dart';
import 'package:quiz_app/homescreen.dart';

void main(){
  runApp(const MyApp());
  var db = DBconnect();
  // db.addQuestion(
  //   Questions(
  //     title: "What is 20X20",
  //      id: '3',
  //       options: {'200': false, '400':true, '2000':false, '1':false})
  // );
  db.fetchQuestion();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}