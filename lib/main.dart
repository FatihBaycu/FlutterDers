import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/main_screen.dart';
import 'package:mobil_kodlama_ornekleri/student_add.dart';
import 'package:mobil_kodlama_ornekleri/student_list.dart';
import 'package:mobil_kodlama_ornekleri/student_list_gridview.dart';

void main() {runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/HomeScreen":(context)=>MainScreen(),
        "/StudentList":(context)=>StudentList(),
        "/StudentAdd":(context)=>StudentAdd(),
        "/StudentGrid":(context)=>StudentListGridView(),
    },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: MainScreen(),
    );
  }
}
