import 'package:flutter/material.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_list.dart';
import 'package:mobil_kodlama_ornekleri/main_screen.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_add.dart';
import 'package:mobil_kodlama_ornekleri/students_screen/student_list_gridview.dart';
import 'package:mobil_kodlama_ornekleri/user_screens/user_list.dart';



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
        "/UserList":(context)=>UserList(),
    },
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue,),
      home: MainScreen(),
    );
  }
}
